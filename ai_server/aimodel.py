import torch
import gptqmodel
from gptqmodel import GPTQModel
import logging
from transformers import AutoTokenizer

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# --- 禁用 TorchInductor / 强制 eager 执行 ---
torch._dynamo.config.suppress_errors = True
torch._dynamo.config.cache_size_limit = 0
torch._dynamo.config.verbose = False

class ParsedCommand:
    def __init__(self, key: str, obj: str, target: str, action: str):
        self.key = key
        self.obj = obj
        self.target = target
        self.action = action

    def __repr__(self):
        return f"ParsedCommand(key={self.key!r}, object={self.obj!r}, target={self.target!r}, action={self.action!r})"

    def to_dict(self):
        return {
            "key": self.key,
            "object": self.obj,
            "target": self.target,
            "action": self.action
        }

class AiCtrl:
    def __init__(self):
        #self.model_path: str = r"D:\openModels\Qwen2.5-7B-Instruct-GPTQ-Int4"
        #self.model_path: str = r"D:\openModels\Qwen3-4B-Instruct-2507-GPTQ-Int4"
        self.model_path: str = ""  # 动态由界面赋值
        self.device: str = "cuda" if torch.cuda.is_available() else "cpu"
        self.model = None
        self.tokenizer = None
        self.is_loaded = False
        logger.info(f"AI init the params")
        print(f"gptqmodel-version={gptqmodel.__version__}")

    def load_model(self):
        try:
            logger.info("start to load ai model...")
            # 1. 加载分词器
            self.tokenizer = AutoTokenizer.from_pretrained(
                self.model_path,
                trust_remote_code=True
            )
            if self.tokenizer.pad_token is None:
                self.tokenizer.pad_token = self.tokenizer.eos_token
            # 2. 加载 GPTQ INT4 模型
            self.model = GPTQModel.load(
                self.model_path,
                device=self.device,
                trust_remote_code=True,
                dtype=torch.float16 if self.device == "cuda" else torch.float32
            )
            self.is_loaded = True
            logger.info("success to load the model")
        except Exception as e:
            logger.error(f"fail to load the model: {str(e)}")
            raise

    def unload_model(self):
        if self.is_loaded:
            del self.model
            del self.tokenizer
            self.model = None
            self.tokenizer = None
            self.is_loaded = False
            if torch.cuda.is_available():
                torch.cuda.empty_cache()
            logger.info("unload the ai model")

    def chat(self, text: str, max_length: int = 128, max_output_chars: int = 2000) -> str:
        """
        Robust chat wrapper:
          - tokenize input
          - generate with safe generation kwargs
          - decode tensor outputs
          - handle exceptions and return a safe message
        """
        if not self.is_loaded:
            raise RuntimeError("model unload can't talk")
        prompt = (text or "").strip()
        if not prompt:
            return ""
        try:
            # 1) tokenize (truncation to model max length)
            inputs = self.tokenizer(
                prompt,
                return_tensors="pt",
                truncation=True,
                max_length=max_length
            ).to(self.device)
            # 2) generation kwargs
            gen_kwargs = dict(
                input_ids=inputs.input_ids,
                attention_mask=inputs.attention_mask,
                max_length=max_length,
                do_sample=True,
                temperature=0.7,
                top_p=0.9,
                eos_token_id=self.tokenizer.eos_token_id if hasattr(self.tokenizer, "eos_token_id") else None,
                pad_token_id=self.tokenizer.pad_token_id if hasattr(self.tokenizer, "pad_token_id") else None,
            )
            outputs = self.model.generate(**{k: v for k, v in gen_kwargs.items() if v is not None})
            # 3) outputs -> string
            decoded = ""
            if isinstance(outputs, torch.Tensor):
                # outputs shape: (batch, seq)
                decoded = self.tokenizer.decode(outputs[0], skip_special_tokens=True, clean_up_tokenization_spaces=True)
            elif isinstance(outputs, (list, tuple)) and len(outputs) > 0:
                # some libs return list of tensors or list of ids
                first = outputs[0]
                if isinstance(first, torch.Tensor):
                    decoded = self.tokenizer.decode(first, skip_special_tokens=True, clean_up_tokenization_spaces=True)
                else:
                    decoded = str(first)
            else:
                # maybe string already
                decoded = str(outputs)
            cleaned = decoded.strip()
            # 4) optional safety: truncate to max_output_chars
            if max_output_chars and len(cleaned) > max_output_chars:
                cleaned = cleaned[:max_output_chars] + "... [truncated]"
            logger.info(f"AI reply (len={len(cleaned)}): {cleaned[:200]}...")
            return cleaned

        except Exception as e:
            logger.exception("AI chat error")
            return "Error: model failed to generate response. Please try again later."

# for outside use
_ai_ctrl = AiCtrl()

def ai_init(model_path: str):
    _ai_ctrl.model_path = model_path
    _ai_ctrl.load_model()

def ai_unload():
    _ai_ctrl.unload_model()

def ai_chat(text: str) -> str:
    return _ai_ctrl.chat(text, max_length=128, max_output_chars=128)

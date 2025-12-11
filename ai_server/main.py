import sys
import threading
import tkinter as tk
from tkinter.scrolledtext import ScrolledText
from tkinter import filedialog

import uvicorn
from fastapi import FastAPI, Header
from pydantic import BaseModel
from Crypto.Cipher import AES
import base64
import asyncio
from concurrent.futures import ThreadPoolExecutor
import jwt
import time
import database
from aimodel import ai_init, ai_unload, ai_chat


# =============================================================================
# Tkinter GUI
# =============================================================================

root = tk.Tk()
root.title("Demo Backend Control")
root.geometry("900x550")

frame_left = tk.Frame(root, width=200)
frame_left.pack(side="left", fill="y", padx=10, pady=10)

log_box = ScrolledText(root, wrap="word", state="disabled")
log_box.pack(side="right", expand=True, fill="both", padx=10, pady=10)


def log(msg: str):
    log_box.config(state="normal")
    log_box.insert("end", msg.rstrip() + "\n")
    log_box.see("end")
    log_box.config(state="disabled")


# ---- 日志重定向到 Tkinter ----
class TkLogStream:
    def write(self, msg):
        if msg.strip():
            root.after(0, lambda: log(msg))
    def flush(self):
        pass


sys.stdout = TkLogStream()
sys.stderr = TkLogStream()


database.init_db()
app = FastAPI()

AES_KEY = b"1234567890abcdef"
AES_IV = b"abcdef1234567890"

JWT_SECRET = "lins8767as3455n7M8"
JWT_EXPIRE = 24 * 3600  # token 24 小时过期

executor = ThreadPoolExecutor(max_workers=1)


def aes_decrypt(cipher_text: str) -> str:
    data = base64.b64decode(cipher_text)
    cipher = AES.new(AES_KEY, AES.MODE_CBC, AES_IV)
    decrypted = cipher.decrypt(data)
    pad_len = decrypted[-1]
    return decrypted[:-pad_len].decode("utf-8")

def create_token(user_id: int):
    now = int(time.time())
    payload = {
        "user_id": user_id,
        "exp": now + JWT_EXPIRE,
        "iat": now
    }
    return jwt.encode(payload, JWT_SECRET, algorithm="HS256")


def verify_token(token: str):
    try:
        data = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        return data["user_id"]
    except Exception:
        return None

def response(code: int, message: str, data=None):
    res = {"code": code, "message": message}
    if data:
        res["data"] = data
    return res


class RequestModel(BaseModel):
    username: str = ""
    email: str = ""
    password: str = ""
    code: str = ""
    msg: str = ""


@app.post("/register")
def register(req: RequestModel):
    if not req.username or not req.email or not req.password:
        return response(210, "Missing parameters")

    if database.get_user_by_username(req.username) or database.get_user_by_email(req.email):
        return response(201, "Username or Email already exists")

    pwd = aes_decrypt(req.password)
    database.create_user(req.username, req.email, pwd)
    print(f"User registered: {req.username}")
    return response(200, "Success")


@app.post("/login")
def login(req: RequestModel):
    if not req.username or not req.password:
        return response(210, "Missing parameters")

    user = database.get_user_by_username(req.username)
    if not user:
        return response(202, "Invalid username")

    pwd = aes_decrypt(req.password)
    if user.password != pwd:
        return response(203, "Invalid password")

    token = create_token(user.id)
    print(f"User login: {req.username}")

    return response(200, "Login success", {
        "token": token,
        "user_id": user.id
    })

@app.post("/get_user")
def get_user(authorization: str = Header(default="")):
    # Flutter 侧用:   Authorization: Bearer <token>
    if not authorization.startswith("Bearer "):
        return response(401, "Missing or invalid token")

    token = authorization.split(" ")[1]
    user_id = verify_token(token)
    if not user_id:
        return response(403, "Token expired or invalid")

    user = database.get_user_by_id(user_id)
    if not user:
        return response(404, "User not found")

    return response(200, "Success", {
        "id": user.id,
        "username": user.username,
        "email": user.email
    })


@app.post("/reset_password")
def reset_password(req: RequestModel):
    if not req.email or not req.code or not req.password:
        return response(210, "Missing parameters")

    if req.code != "123456":
        return response(204, "Invalid code")

    pwd = aes_decrypt(req.password)
    database.update_password(req.email, pwd)
    print(f"Password reset: {req.email}")
    return response(200, "Password reset success")


# ---- AI 非阻塞推理 ----
async def run_ai(text: str):
    loop = asyncio.get_event_loop()
    return await loop.run_in_executor(executor, ai_chat, text)


@app.post("/ai_chat")
async def ai_message(req: RequestModel):
    if not req.msg:
        return response(210, "Missing parameters")
    try:
        reply = await run_ai(req.msg)
        print(f"AI chat request: {req.msg} → {reply[:50]}...")
        return response(200, "success", data=reply)
    except Exception as e:
        return response(500, f"AI Server Error: {str(e)}")


# =============================================================================
# Uvicorn Server Thread
# =============================================================================

server_running = False


def run_server():
    global server_running
    server_running = True
    print("🚀 Uvicorn server is starting...")

    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8000,
        log_level="info",
        use_colors=False    # 禁止 ANSI 颜色，Tkinter 显示更干净
    )

    server_running = False
    print("❌ Uvicorn stopped.")


def start_server():
    global server_running
    if server_running:
        log("⚠️ Server already running.")
        return

    t = threading.Thread(target=run_server, daemon=True)
    t.start()
    log("🟢 Start Server clicked.")


def start_ai():
    log("Select AI model folder...")
    path = filedialog.askdirectory(title="Select AI Model Folder")
    if path:
        log("Loading AI model, may need 10–30 seconds...")
        ai_init(path)
        log("AI model loaded.")


def close_app():
    log("Closing application...")
    ai_unload()
    root.destroy()


# =============================================================================
# GUI Buttons
# =============================================================================

tk.Button(frame_left, text="Start Server", width=20, command=start_server).pack(pady=15)
tk.Button(frame_left, text="Load AI Model", width=20, command=start_ai).pack(pady=15)
tk.Button(frame_left, text="Close", width=20, command=close_app).pack(pady=15)

log("App UI Loaded.")
root.mainloop()

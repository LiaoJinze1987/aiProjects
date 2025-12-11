<details open>
<summary>English</summary>

**Simple design description**  

This project uses Flutter to develop the app and Python to develop the server. Both operate on the same internal network for registration, password recovery, login, and loading and interacting with local AI models.

**Development tools**  

android studio Giraffe | 2022.3.1 Patch 1  
PyCharm Community Edition 2025.2.1.1  
flutter sdk version: 3.22.3  

**Why**  

These development environments were all configured in China. If the latest version was used at the time, there would be issues connecting to overseas networks, preventing the program from running, even with a VPN, especially with Android Studio.  

**How to load**  

Use Android Studio Giraffe | 2022.3.1 Patch 1 or above to load the code in the user_app directory.  
Use PyCharm Community Edition 2025.2.1.1 or above to load the ai_server directory.  
Flutter SDK ≥ 3.22.3.  

**How to run**  

1. Run the `cmd` command, then enter `ipconfig` to view your computer's internal network IP.  
2. In the `user_app` directory, modify **login.dart、forget.dart、register.dart、tab_ai.dart**, replace `"http://192.168.3.6"` with **your internal network IP**.  
3. Install `user_app` via Android Studio to an emulator or a real device. Important: **Phone and server host must be on the same LAN**.  
4. Run `main.py` inside the ai_server directory. A server window will appear. Click **Start Server** to start receiving requests.  
5. You can now test the functions.  

**About AI**  

Click “Load AI Model” in the Server window to load a local AI model.  
The app + server allow chatting with a local AI model.  

**About GPU performance required for loading local AI models**  

Based on practical testing:  

- **12GB GPU**：Qwen3-4B-Instruct-2507-GPTQ-Int4 works smoothly. Qwen2.5-7B-GPTQ-Int4 is theoretically possible but unbearably slow.  
- **6–8GB GPU**：Models between 1.5B–3B (Int4). 3B is borderline.  
- **2–4GB GPU**：1.5B or smaller. Anything over 1.5B is difficult to run.  

</details>


<details>
<summary>日本語</summary>

**Simple design description**  

このプロジェクトでは、アプリの開発にFlutter、サーバーの開発にPythonを使用しています。どちらも同じ内部ネットワーク上で動作し、登録、パスワード回復、ログイン、ローカルAIモデルの読み込みと操作を行います。

**Development tools**  

android studio Giraffe | 2022.3.1 Patch 1  
PyCharm Community Edition 2025.2.1.1  
flutter sdk version: 3.22.3  

**Why**  

これらの開発環境はすべて中国で構築されました。当時の最新バージョンを使用していた場合、VPN を使用していても、特に Android Studio で海外ネットワークへの接続に問題が発生し、プログラムが実行できなくなります。  

**How to load**  

Use Android Studio Giraffe | 2022.3.1 Patch 1 or above to load the code in the user_app directory.  
Use PyCharm Community Edition 2025.2.1.1 or above to load the ai_server directory.  
Flutter SDK ≥ 3.22.3.  

**How to run**  

1. 「cmd」コマンドを実行し、「ipconfig」と入力してコンピュータの内部ネットワーク IP を表示します。  
2. 「user_app」ディレクトリで、**login.dart、forget.dart、register.dart、tab_ai.dart** を変更し、「http://192.168.3.6」を **内部ネットワーク IP** に置き換えます。  
3. Android Studio 経由で「user_app」をエミュレータまたは実機にインストールします。重要: **スマートフォンとサーバー ホストは同じ LAN 上にある必要があります**。  
4. ai_server ディレクトリ内で `main.py` を実行します。サーバーウィンドウが表示されます。 [**サーバーの開始**] をクリックしてリクエストの受信を開始します。  
5. 機能をテストできるようになりました。  

**About AI**  

サーバー ウィンドウで [AI モデルのロード] をクリックして、ローカル AI モデルをロードします。  
アプリ + サーバーにより、ローカル AI モデルとのチャットが可能になります。  

**About GPU performance required for loading local AI models**  

実地試験に基づく:  

- **12GB GPU**：Qwen3-4B-Instruct-2507-GPTQ-Int4 はスムーズに動作します。 Qwen2.5-7B-GPTQ-Int4 は理論的には可能ですが、耐えられないほど遅いです。  
- **6–8GB GPU**：1.5B ～ 3B (Int4) のモデル。 3Bはボーダーライン。  
- **2–4GB GPU**：1.5B以下。 1.5Bを超えるものは実行が困難です。  

</details>



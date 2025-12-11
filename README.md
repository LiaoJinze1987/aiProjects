<details open>
<summary>English</summary>

**Simple design description**  

This project uses Flutter to develop the app and Python to develop the server. Both operate on the same internal network for registration, password recovery, login, and loading and interacting with local AI models.

**With AI's help**  
From the beginning, I planned to implement the app and server using Flutter and Python.I planned to implement the server using Django, but on chatGpt's suggestion, I switched to the lighter FastAPI and SQLite.  
In terms of Flutter, chatGpt mainly assisted me in debugging the code and optimizing some functional stability, such as the issue of multiple API requests when switching between tab_main.dart's MainPage code. This is because MainPage is created and replaced multiple times in the original code, causing unnecessary multiple lifecycles.  
In terms of Python, chatGpt assisted me in several aspects of server development. Regarding user login, I originally planned to use SMS4 encryption, but with chatGpt's suggestions and code assistance, I switched to using AES-CBC + PKCS#7 padding + Base64 encoding for encrypting and decrypting login information.When implementing the local AI model dialogue function, an issue arose where the AI ​​model received user input characters and generated a response, but the APP could not receive the correct response. After chatGpt assisted in troubleshooting, it was discovered that the returned data format was not being correctly parsed by the APP, and this issue was resolved.

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
2. In the `user_app` directory, modify **config.dart**, replace `"http://192.168.3.6"` with **your internal network IP**.  
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

**With AI's help**  
当初から、アプリとサーバーはFlutterとPythonで実装する予定でした。サーバーはDjangoで実装するつもりでしたが、chatGptさんの提案で、より軽量なFastAPIとSQLiteに切り替えました。  
Flutter に関しては、chatGpt は主にコードのデバッグと、tab_main.dart の MainPage コードを切り替えるときに複数の API リクエストが発生する問題など、機能の安定性の最適化に役立ちました。  
これは、元のコード内で MainPage が複数回作成および置換され、不要な複数のライフサイクルが発生するためです。  
Python に関しては、chatGpt がサーバー開発のさまざまな側面で私を支援してくれました。 ユーザー ログインに関しては、当初は SMS4 暗号化を使用する予定でしたが、chatGpt の提案とコード支援により、ログイン情報の暗号化と復号化に AES-CBC + PKCS#7 パディング + Base64 エンコーディングを使用するように切り替えました。ローカルAIモデル対話機能を実装する際に、AIモデルがユーザー入力文字を受け取って応答を生成しても、APPが正しい応答を受信できないという問題が発生しました。chatGpt がトラブルシューティングを支援した結果、返されたデータ形式が APP によって正しく解析されていないことが判明し、この問題は解決されました。  

**Development tools**  

android studio Giraffe | 2022.3.1 Patch 1  
PyCharm Community Edition 2025.2.1.1  
flutter sdk version: 3.22.3  

**Why**  

これらの開発環境はすべて中国で構築されました。当時の最新バージョンを使用していた場合、VPN を使用していても、特に Android Studio で海外ネットワークへの接続に問題が発生し、プログラムが実行できなくなります。  

**How to load**  

Android Studio Giraffe | 2022.3.1 Patch 1 以上を使用して、user_app ディレクトリにコードをロードします。  
ai_server ディレクトリをロードするには、PyCharm Community Edition 2025.2.1.1 以上を使用します。  
Flutter SDK ≥ 3.22.3.  

**How to run**  

1. 「cmd」コマンドを実行し、「ipconfig」と入力してコンピュータの内部ネットワーク IP を表示します。  
2. 「user_app」ディレクトリで、**config.dart** を変更し、「http://192.168.3.6」を **内部ネットワーク IP** に置き換えます。  
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



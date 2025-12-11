<details open>
<summary>English</summary>

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



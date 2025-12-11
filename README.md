<details>

<summary>English</summary>  
**Development tools**  
android studio Giraffe | 2022.3.1 Patch 1  
PyCharm Community Edition 2025.2.1.1  
fluter sdk version: 3.22.3  
**Why**  
These development environments were all configured in China. If the latest version was used at the time, there would be issues connecting to overseas networks, preventing the program from running, even with a VPN, especially with Android Studio.  
**How to load**
Please use android studio Giraffe | 2022.3.1 Patch 1 or above to load the code of the user_app directory. If you have a better way, please feel free to do so.  
Please use PyCharm Community Edition 2025.2.1.1 or above to load the code of the user_app directory. If you have a better way, please feel free to do so.  
The version of flutter sdk is ≥3.22.3.  
**How to run**  
(1)Please run the cmd command and then enter the ipconfig command to view the internal network IP of your computer.  
(2)Change login.dart, forget.dart, register.dart, tab_ai.dart in the user_app directory, replace the ip "http://192.168.3.6" with your own internal network IP.  
(3)Use Android studio to install user_app to the emulator or a real phone. Please note that the phone and the computer running the server must be in the same internal network.  
(4)Run main.py in the ai_server directory of the python project. The server window will appear. Click Start Server to start the server that receives the request.  
(5)Functional testing is now possible.  
**About AI**  
Click the "Load AI Model" button in the Server window to load the local AI model. The app and Server implement the function of talking to the AI ​​local model.  
**About the performance required to load AI local models**  
Based on my experience, the local model that can be loaded with graphics card performance is roughly as follows:  
12G graphics card performance: Qwen3-4B-Instruct-2507-GPTQ-Int4, Theoretically, it is possible to load local models such as Qwen2.5-7B-Instruct-GPTQ-Int4, but it is very difficult and very slow.  
6-8G graphics card performance: The local model is around int4 between 1.5B-3B, but 3B is more reluctant.  
2-4G graphics card performance: Local models within 1.5B, exceeding 1.5 or even 1.5 are a bit reluctant.  

</details>

<details>
<summary>日本語</summary>

これは日本語バージョンの説明です。

</details>


<details open> <summary>English</summary>

Project Overview
This project implements a complete authentication workflow, including user registration, password recovery, login, and interaction with a locally hosted AI model.
The mobile application is built with Flutter, and the backend server is implemented using Python (FastAPI + SQLite). Both components operate within the same local network.

System Architecture

Frontend (Flutter)
Handles UI rendering, state management, form validation, and communication with the backend via REST APIs.

Backend (FastAPI)
Provides authentication endpoints, processes AES-CBC encrypted login payloads, manages user data, and exposes an inference interface for locally loaded AI models.

Database (SQLite)
Stores user credentials (salted and hashed passwords) and profile information.

Local AI Integration
The backend supports loading quantized LLM models and offers a simple streaming-response API for real-time interaction.

Technology Decisions

FastAPI instead of Django
Selected for its lightweight structure, faster startup times, and easier integration with asynchronous model inference.

AES-CBC + PKCS#7
Used to securely transmit encrypted login information.

SQLite
Chosen for its portability and suitability for a self-contained local development environment.

AI Assistance Usage
Generative AI (ChatGPT) was used in accordance with the assignment guidelines.
AI contributed to:

Comparing Django and FastAPI for backend design

Identifying unnecessary widget rebuilds in the Flutter UI

Reviewing AES encryption/decryption logic and resolving response-format issues

All final implementations were reviewed and completed manually.

Environment Requirements

Flutter SDK ≥ 3.22.3

Android Studio 2022.3.1 or later

Python 3.11+

Required Python packages listed in requirements.txt

Project Setup

Set the server host IP in config.dart.

Start the backend:

python main.py


Build and install the Flutter app on an emulator or physical device.

Ensure both the backend and the device are connected to the same local network.

Local AI Model Support
The backend supports loading quantized models up to approximately 4B parameters (Int4), depending on available GPU memory.
Actual performance varies by hardware capability.

</details>

Project Overview

This project implements a complete authentication workflow, including user registration, password recovery, login, and communication with a locally hosted AI model.
The mobile application is developed using Flutter, and the backend server is implemented with Python (FastAPI + SQLite). Both run within the same local network.

System Architecture

Frontend (Flutter)
Provides UI, manages state, handles form validation, and communicates with the backend via REST API.

Backend (FastAPI)
Provides authentication endpoints, AES-CBC encrypted login data handling, user management, and a local AI-model inference interface.

Database (SQLite)
Stores user credentials (salted & hashed passwords) and user profile information.

Local AI Integration
The server supports loading quantized LLM models and provides a simple streaming response API for the app.

Technology Decisions

FastAPI instead of Django
Chosen for its lightweight design, faster startup, and simpler integration with asynchronous model inference.

AES-CBC + PKCS#7
Used for secure handling of login payloads.

SQLite
Adequate for a local environment, zero-configuration, and portable.

AI Assistance Usage

Generative AI was used under the allowed rules of the assignment.
AI assisted with:

Framework comparison between Django and FastAPI

Identifying redundant widget rebuilds in Flutter

Reviewing encryption/decryption logic and debugging response format issues
All implemented logic was validated and finalized manually.

Environment Requirements

Flutter SDK ≥ 3.22.3

Android Studio 2022.3.1 or later

Python 3.10+

Required Python packages listed in requirements.txt

Project Setup

Configure the server’s host IP address in config.dart.

Start the backend:

python main.py


Build and install the Flutter app on an emulator or device.

Ensure both are on the same LAN.

Local AI Model Support

Supports loading models up to 4B parameters (Int4) depending on GPU memory.
The performance depends on hardware constraints.

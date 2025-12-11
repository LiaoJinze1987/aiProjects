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

<details open> <summary>日本語</summary>

プロジェクト概要
本プロジェクトは、ユーザー登録、パスワード再設定、ログイン機能、およびローカル環境で動作する AI モデルとの連携を含む認証ワークフローを実装しています。
フロントエンドは Flutter、バックエンドは Python（FastAPI + SQLite） を使用して構築され、両者は同一ローカルネットワーク上で動作します。

システム構成

フロントエンド（Flutter）
UI の描画、状態管理、フォームバリデーションを行い、REST API を通じてバックエンドと通信します。

バックエンド（FastAPI）
認証 API の提供、AES-CBC による暗号化ログインデータの処理、ユーザー情報の管理、ローカル AI モデル推論用インターフェースを提供します。

データベース（SQLite）
ソルト付きハッシュ化パスワードを含むユーザー情報を保存します。

ローカル AI 連携
量子化（Int4）された LLM モデルの読み込みに対応し、アプリ向けにストリーミング応答 API を提供します。

技術選定理由

Django ではなく FastAPI を採用
軽量で起動が速く、非同期処理を利用したモデル推論との統合が容易であるため採用しました。

AES-CBC + PKCS#7
ログイン情報の安全な送受信を実現するために採用しています。

SQLite
ローカル環境での簡易運用と移植性に優れているため選択しました。

生成 AI の利用箇所
課題ルールに従い、生成 AI（ChatGPT）を以下の点で利用しています。

Django と FastAPI の比較およびバックエンド構成の検討

Flutter における不要なウィジェット再構築の特定

AES 暗号化／復号ロジックのレビューおよびレスポンス形式のデバッグ

最終的な実装はすべて手動で確認・調整しています。

動作環境

Flutter SDK ≥ 3.22.3

Android Studio 2022.3.1 以上

Python 3.11+

必要な Python パッケージは requirements.txt に記載

セットアップ手順

config.dart にサーバーホストの IP アドレスを設定します。

バックエンドを起動します：

python main.py


Flutter アプリをエミュレータまたは実機にビルド・インストールします。

バックエンドとスマートフォン（またはエミュレータ）が同一 LAN 上にあることを確認します。

ローカル AI モデルの対応状況
GPU メモリ容量に応じて、おおよそ 最大 4B パラメータ（Int4） の量子化モデルを読み込むことが可能です。
性能はハードウェア構成に依存します。

</details>

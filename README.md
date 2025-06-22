# AruTracker

A simple inventory management web application using Aruco marker detection.  
Accessible on the local network.

## Features

- Detects Aruco markers via the device's camera
- Tracks items using unique marker IDs
- Lightweight and easy to deploy
- Runs in the browser via local network

## Requirements

- [V](https://vlang.io)
- [Ngrok](https://ngrok.com)

## Installation and usage

1. Clone the repository:

    ```bash
    git clone https://github.com/hiiamsheep/UcoTracker.git
    cd aruco-inventory
    ```

2. Run the app:

    ```bash
    v -d veb_livereload watch run .
    ```

3. Open another terminal and forward the local server through Ngrok:

    ```bash
    ngrok http 8000 --basic-auth="user:password"
    ```

    > I recommend at least to use a basic authentification for security.

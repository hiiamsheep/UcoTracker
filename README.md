# UcoTracker

A simple inventory management web application using Aruco marker detection.  
Accessible on the local network.

## Features

- Detects Aruco markers via the device's camera
- Tracks items using unique marker IDs
- Lightweight and easy to use

## Requirements

- [V](https://vlang.io)
- [Ngrok](https://ngrok.com)

## Installation and usage

1. Clone the repository:

    ```bash
    git clone https://github.com/hiiamsheep/UcoTracker.git
    cd UcoTracker
    ```

2. Run the app:

    ```bash
    v run .
    ```

3. Open another terminal and forward the local server through Ngrok:

    > Use Ngrok so we don't have to play with https certificates due to camera access :3

    ```bash
    ngrok http 8000 --basic-auth="user:password"
    ```

    > I recommend at least to use a basic authentification for security.

4. To use the app:

    Print some original Aruco markers that you can find at the [Aruco marker generator](https://chev.me/arucogen/)
    Go to the Ngrok-provided URL in your browser and start using the app!

    > make sure to choose the "Original ArUco" Dictionnary

# A-Frame WebXR App

This project is a simple XR app for seeing a sign in front of the user in mixed reality. The user can configure what is on the sign and how far away it is in real life units (feet or meters).

## Setup and Running the Project

1. Clone the repository:
    ```
    git clone https://github.com/githubnext/workspace-blank.git
    cd workspace-blank
    ```

2. Open `index.html` in a web browser to run the application.

## Configuring the Sign

1. Open `config.html` in a web browser to access the configuration interface.

2. Use the input fields to specify the text on the sign and its distance from the user.

3. Click "Save Configuration" to save the settings. The sign in the main application will be updated accordingly.

## Using Hand Tracking and Grabbable Objects

1. Ensure you have a VR headset with hand tracking capabilities.

2. Open `index.html` in a web browser with WebXR support.

3. Small grabbable objects will poof into existence in front of you every 5 seconds.

4. Use your hands to grab and throw these objects at the sign.

5. Visual and audio feedback will be provided for successful hits on the sign.

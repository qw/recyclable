# Recyclable

Use computer vision to see whether something is recyclable.

<img src="/screenshots/prediction_page.png" alt="Screenshot of Prediction page" width="350">

This is an app made for highschool outreach - a volunteering program I'm hosting for Software Engineering students volunteers to show highschool students how software is like through activities.

## Getting Started
### Step 1 - Installing Flutter
We will need to install `Flutter` to build and deploy this app. Flutter applications can be deployed on both iOS and Android devices.

Please follow [this link](https://flutter.dev/docs/get-started/install) to setup your Flutter environment. This guide takes you through on:
- Downloading Flutter
- Setting `PATH` to its location
- Running `flutter doctor` to install Android SDK (for Android) and/or XCode (for iOS)
  - Note: DO NOT install Android SDK to a path with space in it

After installing Flutter, clone or download this repository. Open this code in an IDE of your choice (Say Intellij or VSCode), then simply run `pub get` to install depedencies and build/deploy the project.

### Step 2 - Custom Vision API
Microsoft's Custom Vision API is what powers the image recognition used in this app. We need to get the `Prediction Key` and `Prediction URL` for this app to work.

- Sign up for a Microsoft account
- Use [Azure for student](https://azure.microsoft.com/en-in/free/students/) for free Azure credits
- Sign in [here](https://www.customvision.ai)
- Creat a project for `Multiclass (Single tag per image)`
- Upload images and train for an iteration
- Publish said iteration
- Find `Prediction Key` and `Prediction URL` under Performance > Prediction URL
- Enter them in either
  - In the app's Settings Page (Remember to save)
  - In `assets/config/config.json` to be used as defaults

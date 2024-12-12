# Assignment Tracker

Assignment Tracker is an iOS application designed to help students manage their assignments efficiently. This project was developed as part of a homework assignment for the iOS course at BME.

## Features

- **Assignment Management**: Add, edit, view, and delete assignments with details such as due date, course and status.
- **Adaptive Layout**: The app supports both iPhone and iPad devices with responsive layouts.
- **Firebase Integration**: 
  - **Authentication**: Users can sign up, log in, and manage their sessions securely.
  - **Data Storage**: Assignments are stored and synced using Firebase Firestore.
- **Undo Functionality**: Shake the device to undo changes during assignment editing.

## Technology Stack

- **Programming Language**: Swift
- **Framework**: SwiftUI
- **Backend**: Firebase (Firestore and Authentication)
- **Development Tools**: Xcode 15.0 or later
- **Supported Devices**: iPhone and iPad
- **Minimum iOS Version**: iOS 18.1

## Screenshots

<img src="https://github.com/user-attachments/assets/14c258e4-72ec-4907-8b0e-05d27d84215b" alt="Login View" width="200"/>
<img src="https://github.com/user-attachments/assets/a19ef5df-3034-48f5-81eb-426319af3ef0" alt="List View" width="200"/>
<img src="https://github.com/user-attachments/assets/4bc36e0f-f9a9-4cf0-a74f-c87a6b2db45f" alt="Edit View" width="200"/>
<img src="https://github.com/user-attachments/assets/dc3d443a-a82f-4237-8c6c-c98d9ed0b098" alt="IPad View" width="400"/>



## Prerequisites

- macOS with Xcode 15.0 or later installed.
- Firebase project configured (refer to Firebase documentation for setup).
  - Install Firebase SDK via Swift Package Manager
  - Place the GoogleService-Info.plist file from Firebase into the `Other` directory of the project

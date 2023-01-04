# OnMyMind

**Web App Hosted Link:** [OnMyMind](https://on-my-mind-acbc7.web.app/#/)

## Collaborators

**Flutter Project One - Group 5**
- Fatin Iftekhar @fiftekhar
- Nafisa Tanta @NafisaTanta
- Azarul Mohammad @Azarul9
- David Lin @David.Lin34
- Kelly Camacho @ksophia.martinez

## Description

This project is an app that can be used for notetaking. Users can log in or create an account using their email address, which will get saved into the Firebase Authentication database. They will also need to create a password to access our signature feature: *secret notes!*

Our app provides the ability to create, read, update, and delete notes, which are saved in a Cloud Firestore database. Standard and secret notes are saved in seperate databases.

## Download and Run

### Prerequesties
- Install Flutter 
- Install FirebaseCLI
- Configure FirebaseCLI to connect to the Firebase project of your choice

### Installation and Running

1. Clone this repository: `git clone <method-of-your-choice>`
2. Build the app: `flutter build web`
3. Deploy the app: `firebase deploy`
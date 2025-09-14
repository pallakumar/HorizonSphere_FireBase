# HorizonSphere FireBase Task (SwiftUI + Firebase)

## Overview

This is a one-way video interview app (“Hireflix clone”) developed with **native iOS (SwiftUI)** and **Firebase**.  
Core features implemented:

- Sign up / Sign in for three roles: **Admin**, **Reviewer**, **Candidate**  
- Admin / Reviewer: create interviews (title, description, questions)  
- Candidate: list interviews, record video answers per question, upload to Firebase Storage  
- Reviewer: view submissions, play video answers, add score & comment

## Tech Stack

- Swift 5, SwiftUI  
- Firebase Authentication, Firestore Database, Firebase Storage  
- Basic Firebase security rules for user/role permissions  

## Setup / Run Instructions

1. Clone the repository:  
   git clone https://github.com/pallakumar/HorizonSphere_FireBase.git
2. Checkout the Develop branch:
  cd HorizonSphere_FireBase
  git checkout Develop
3. Download and add your GoogleService-Info.plist (Firebase config) into the project.
4. Install dependencies :
   I used SPM Swift Packages, ensure they resolve.
5. Run on iOS Simulator.


Contact
Name: Pallakumar
GitHub: github.com/pallakumar/HorizonSphere_FireBase
LinkedIn profile: https://www.linkedin.com/in/palla-kumar-a1a47848/






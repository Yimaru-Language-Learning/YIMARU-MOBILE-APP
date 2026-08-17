# App Review Information

## 1. Test devices and operating systems

The iOS build was tested on the following devices:

- iPad (8th generation) — iPadOS 
- iPhone 17 Pro, Apple Simulator — iOS 
- iPhone 17 Pro Max, Apple Simulator — iOS 

The app's minimum supported platform is iOS/iPadOS 15.0. Android testing was also performed on several devices, but that testing is separate from this iOS submission. The app is built on the react native stack, therefore it might be relevant.

## 2. App functions, target audience, problem, and value

Yimaru is a mobile English-learning app designed primarily for learners in Ethiopia and for Amharic-speaking Ethiopians living abroad. Its target audience includes students, job seekers, working professionals, and exam candidates who need structured English instruction and speaking practice that is accessible on a mobile device.

In Ethiopia, consistent English-speaking practice and international English-exam preparation can be difficult to access and expensive relative to local incomes. Yimaru addresses this gap by providing guided, self-paced learning at locally relevant price points.

The app's main functions are:

- Structured Learn English programs organized into courses, modules, lessons, and practices. The learning system supports CEFR-based progression from A1 through C2 where that content is published.
- Video lessons followed by guided exercises. In speaking activities, learners listen to a prompt, record their response with the device microphone, and play back their recording alongside a model response.
- A guided speaking partner named “Daniel.” Daniel presents prerecorded, curriculum-authored prompts and model responses; this feature does not use a generative-AI or large-language-model service in the current build.
- International English-exam preparation, including structured IELTS and Duolingo English Test lessons and practice types covering speaking, listening, reading, and writing.
- Learning-progress tracking, subscriptions and course access, in-app notifications, account and privacy controls, FAQs, and support options.

The app's value is to make English fluency practice and exam preparation more accessible, consistent, and affordable for learners who may not have convenient access to in-person instruction.

## 3. Setup and access instructions

Review credentials have been supplied in App Store Connect under **App Review Information > Sign-In Information**. No sample files are required. You may also create a new account using the app, perhaps using the apple signin that has been integrated.


To access the main features:

1. Launch Yimaru. On a clean installation, complete the introductory screens to reach the sign-in page.
2. On the default email sign-in screen, enter the review email address and password provided in App Store Connect, then tap **Continue**.
3. After sign-in, the app opens to the main interface with the **Learn**, **Course**, and **Profile** tabs.
4. In **Learn**, select a program, then a course, module, and lesson. Open a video lesson or choose an available practice. Speaking practices request microphone access so the reviewer can record and replay an answer.
5. In **Course**, select **English Proficiency Exams**, choose an available exam-preparation course, and open its lessons or practices.
6. In **Profile**, the reviewer can view learning progress, subscriptions, notifications, account and privacy settings, FAQs, and support options. A profile image is used solely for personalization and is entirely optional; all app features remain available without one.

The supplied review account is preconfigured with completed onboarding and access to every paid or restricted section that Apple needs to review. Email/password access does not require an additional OTP or two-factor-authentication step. An internet connection is required for account data, course content, and video streaming. Notification permission is optional; microphone permission is required only for speaking exercises. Camera or photo-library access is requested only if the user chooses to add or change the optional profile image.

## 4. External services, tools, and platforms

The current app and production backend use the following services:

- **Yimaru backend API and infrastructure:** Provides account authentication, learner profiles, curriculum, progress, subscriptions, payments, notifications, and support features. The operations team reports that the production infrastructure is hosted through Hostinger.
- **Sign in with Apple and Google Sign-In:** Optional social sign-in methods. Email/password and phone/OTP authentication are handled by Yimaru's backend rather than Firebase Authentication.
- **Resend and AfroMessage:** Transactional email and SMS delivery, including registration, password-reset, and OTP messages where applicable.
- **Vimeo:** Hosts and streams lesson videos.
- **MinIO-compatible object storage:** Stores and delivers supporting media such as images, audio, and PDF learning materials.
- **Firebase Cloud Messaging:** Delivers push notifications. Firebase Authentication and Firebase Analytics are not integrated into the submitted mobile build.
- **Chapa:** Provides the hosted payment checkout. Depending on the production checkout configuration, Chapa can expose Ethiopian payment methods such as Telebirr and other supported mobile wallets or cards.

No external generative-AI service is used by the submitted build. The “Daniel” speaking-partner experience is driven by authored prompts and model audio from Yimaru's curriculum.

Google Play is used to distribute the Android version, but it is not a dependency of the iOS app and is not used to deliver its core functionality.

## 5. Regional differences

Yimaru is designed primarily for the Ethiopian market. The interface supports English and Amharic, prices are presented in Ethiopian birr, and the available payment options are oriented toward Ethiopian users.

The same curriculum, account features, and learning experience are provided in every App Store region where the app is made available; the code does not apply region-based feature restrictions. However, Ethiopian payment methods may require a supported Ethiopian phone number, wallet, card, or bank account and therefore may not be usable by every learner outside Ethiopia.

This submission is the iOS version of Yimaru. An Android version is already distributed separately. That platform difference does not create a regional difference in the curriculum or account experience.

## 6. Regulated services and protected third-party material

Yimaru is an educational product and does not operate in a highly regulated industry. It does not provide official examination registration, official scores, immigration advice, financial services, medical services, or other regulated professional services.

The exam-preparation lessons and practice materials are independently produced by Yimaru. References to examination names such as IELTS, TOEFL, and the Duolingo English Test are descriptive only. Yimaru does not claim affiliation with, sponsorship by, or endorsement from the organizations that own those examinations, and it does not use their official logos or branding without authorization. No additional regulatory license or third-party-content credential is required for the material in this submission.

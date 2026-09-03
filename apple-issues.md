## Test devices

Tested on an iPad (8th generation) and an iPhone 17 Pro Apple Simulator.

## Functions, audience, problem, value

Yimaru is a mobile English-learning app for Ethiopian/overseas students, job seekers, professionals, and exam candidates. Speaking and international-exam preparation can be scarce and costly in Ethiopia; Yimaru provides guided, self-paced learning at accessible local prices.

- Courses, modules, lessons, and practices supporting published CEFR levels A1–C2.
- Video lessons/exercises with prompts, answer recording/playback, and model-response comparison.
- “Daniel,” a guided speaking partner using prerecorded, authored prompts/model responses—not generative AI or an LLM.
- IELTS and Duolingo English Test preparation for speaking, listening, reading, and writing.
- Progress, subscriptions/course access, notifications, privacy controls, FAQs, and support.

It makes fluency/exam preparation accessible, consistent, and affordable where in-person teaching is unavailable.

## Setup and access

Credentials: **App Review Information > Sign-In Information**. No samples are needed; reviewers may instead register through Apple.

1. Launch Yimaru; complete the first-install introduction.
2. Enter the supplied email/password; tap **Continue**.
3. Use the **Learn**, **Course**, and **Profile** tabs.
4. **Learn:** choose a program, course, module, and lesson; open a video/practice. Speaking practice requests microphone access for recording/playback.
5. **Course:** choose **English Proficiency Exams**, then a course, lesson, or practice.
6. **Profile:** access progress, subscriptions, notifications, account/privacy, FAQs, and support. Its personalization image is optional and affects no features.

The review account completed onboarding and accesses all paid/restricted areas. Email/password needs no OTP/2FA. Internet is required for account data, content, and video. Notifications are optional; microphone is only for speaking; camera/photos only for the optional profile image.

## External services

- **Yimaru API:** Auth, profiles, curriculum, progress, subscriptions, payments, notifications, and support; Hostinger-hosted.
- **Apple/Google:** Optional social login. Yimaru—not Firebase—handles email/password and phone/OTP.
- **Resend/AfroMessage:** Registration, password-reset, OTP, and transactional email/SMS.
- **Vimeo:** Lesson-video hosting/streaming.
- **MinIO storage:** Images, audio, PDFs, and learning media.
- **Firebase Cloud Messaging:** Push only; Firebase Auth/Analytics are absent.
- **Chapa:** Hosted checkout with Telebirr and configured Ethiopian wallets/cards.

No external generative AI is used; Daniel uses Yimaru-authored prompts/model audio. Google Play distributes Android only; it is not an iOS dependency/core service.

## Regional differences

Yimaru primarily serves Ethiopia with English/Amharic, birr prices, and local payments. All enabled regions receive the same curriculum, accounts, and features; no code restricts them by region. Payments may require an Ethiopian phone, wallet, card, or bank account and be unavailable abroad. Separate iOS/Android apps have the same regional curriculum/account functions.

## Regulation and protected material

Yimaru is educational, not highly regulated, and offers no official exam registration/scores, immigration advice, financial/medical, or other regulated services. Yimaru independently produces its exam-prep content. IELTS, TOEFL, and Duolingo English Test names are descriptive only; Yimaru claims no affiliation, sponsorship, or endorsement and uses no official logos/branding without authorization. No additional regulatory or third-party-content credential is required.

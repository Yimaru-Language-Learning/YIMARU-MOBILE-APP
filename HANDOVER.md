# Technical Handover & Code Documentation: Yimaru Academy

## 1. Project Overview
*   **Project Name:** Yimaru Academy
*   **Purpose:** A comprehensive Learning Management System (LMS) mobile application designed to help users learn spoken English through structured courses, video lessons, and interactive practice sessions.
*   **Target Users:** Individuals seeking to improve English proficiency, specifically those preparing for exams like IELTS or Duolingo English Test.
*   **Main Functionality:** User authentication, proficiency assessment, course navigation, video streaming, interactive speaking/writing practice, and progress tracking.
*   **Project Scope:** Cross-platform mobile application (iOS and Android).

## 2. Developer & Company Information
*   **Developer:** Bisrat Hailu
*   **Development Company:** Yaltopia
*   **Handover Statement:** This project and its source code are being handed over by Yaltopia for ongoing maintenance and future development. All intellectual property and technical assets associated with the mobile application are included in this handover.

## 3. Technology Stack
*   **Framework:** [Flutter](https://flutter.dev/) (SDK >=3.0.3)
*   **Language:** [Dart](https://dart.dev/)
*   **Architecture & State Management:** [Stacked](https://stacked.filledstacks.com/) (MVVM pattern with a focus on separation of concerns).
*   **Networking:** [Dio](https://pub.dev/packages/dio) for API communication.
*   **Localization:** [Easy Localization](https://pub.dev/packages/easy_localization) (Supporting English and Amharic).
*   **Authentication:** Firebase Auth (Google Sign-In) and Custom API (Email/Phone).
*   **Local Storage:** `flutter_secure_storage` for sensitive data (tokens) and `path_provider`.
*   **Media:** `chewie` and `video_player` for lessons; `audioplayers` for speaking practice.
*   **UI/UX Components:** `flutter_carousel_widget`, `pinput` (for OTP), `syncfusion_flutter_pdfviewer`.

## 4. Application Architecture
The project follows the **Stacked Architecture**, which is a production-ready version of MVVM (Model-View-ViewModel).

*   **Views:** Responsible for the UI layout. They do not contain business logic.
*   **ViewModels:** Act as the "brain" for the Views. They handle state, call services, and react to user input.
*   **Services:** Singletons responsible for specific tasks (e.g., `ApiService`, `AuthenticationService`). They are injected using a Locator (GetIt).
*   **Models:** Data classes with JSON serialization (using `json_serializable`).

### Data Flow Example
1.  **User Action:** User taps "Start Course" in a `View`.
2.  **ViewModel:** The `View` calls a method in the `ViewModel`.
3.  **Service:** The `ViewModel` calls the `ApiService` to fetch course data.
4.  **Model:** The `ApiService` parses the JSON response into a `Course` model.
5.  **Reactive Update:** The `ViewModel` updates its internal state and calls `notifyListeners()`, causing the `View` to rebuild with the new data.

## 5. Project Folder Structure
```text
lib/
├── app/                  # Router and Dependency Injection setup (Locator)
├── models/               # Data classes (generated using json_serializable)
├── services/             # Business logic (API, Auth, Localization, etc.)
├── ui/                   # UI Layer
│   ├── common/           # App colors, UI helpers, and Translation keys
│   ├── dialogs/          # Custom pop-up dialogs
│   ├── bottom_sheets/    # Custom bottom sheets
│   ├── views/            # Screen folders (containing View and ViewModel)
│   └── widgets/          # Reusable custom UI components
├── main.dart             # Entry point
assets/
├── icons/                # SVG and PNG icons
├── images/               # App imagery
├── translations/         # JSON translation files (en.json, am.json)
└── fonts/                # Custom typography (Aeonik)
```
**Files to Modify for New Features:**
*   **New Screen:** Create a new folder in `lib/ui/views/`, run `build_runner` to generate the route.
*   **New API:** Add methods to `lib/services/api_service.dart`.
*   **New Text:** Add keys to `assets/translations/en.json` and run code generation.

## 6. Application Features
*   **Authentication:** Multi-method login (Email/Password, Phone/OTP, and Google Sign-In).
*   **Onboarding:** A multi-step flow collecting user data (Age, Gender, Occupation, Topic Interests) to personalize the experience.
*   **Proficiency Assessment:** Initial test to determine the user's current English level (A1, A2, B1, etc.).
*   **Learning Content:** Tree-structured navigation through programs and courses.
*   **Video Lessons:** Integrated video player with playback controls.
*   **Practice Engine:** 
    *   **IELTS Mode:** Specialized practice for Form Completion, Listening, and Reading.
    *   **Duolingo Mode:** Speaking (Describe photo), Interactive Writing, and Listening.
*   **Progress Tracking:** Visual representation of completed videos and practices.
*   **Localization:** Fully implemented support for English and Amharic across all screens.

## 7. Learning Content Hierarchy
Content is organized in the following descending order:
1.  **Program:** (e.g., "Spoken English")
2.  **Course:** (e.g., "Beginner English A1")
3.  **Unit:** Groupings within a course.
4.  **Module:** Specific subject areas.
5.  **Lesson:** Individual learning sessions.
6.  **Video/Practice:** The actual content delivered to the user.

**Practice Functionality:** Practice sessions are attached at the **Unit**, **Module**, or **Lesson** level depending on the course design.

## 8. API Integration
The application uses the `Dio` package for HTTP requests.
*   **Service:** `lib/services/api_service.dart`
*   **Base URL:** [VERIFY WITH DEVELOPMENT TEAM] (Usually found in a constant file or environment config).
*   **Serialization:** Uses `json_annotation`. Run `flutter pub run build_runner build` to update models.
*   **Authentication:** Bearer tokens are attached via Interceptors.
*   **Known Mismatches:** [VERIFY WITH DEVELOPMENT TEAM - e.g., "Some fields in User model are optional in mobile but required by backend"].

## 9. Authentication & User Flow
**Flow:** `Startup -> Landing -> Login -> Register -> Onboarding -> Assessment -> Home`

*   **Google Sign-In:** Uses `google_sign_in` package. Requires `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
*   **Secure Storage:** After login, the `access_token` is stored in `FlutterSecureStorage`.

## 10. Onboarding
*   **Fields:** Full Name, Gender, Age Group, Educational Background, Occupation, Country/Region, Language Goals, Topic Interests.
*   **Special Case:** If "Ethiopia" is selected as the country, the app provides region/city dropdowns.
*   **Validation:** All fields are validated before moving to the next step.

## 11. Assessment & Level Placement
The assessment logic is housed within `AssessmentViewModel`. 
1.  User answers a series of questions.
2.  Data is sent to the `/assess` endpoint.
3.  The backend returns a `proficiency_level`.
4.  The app updates the user profile and unlocks relevant course content.

## 12. Permissions
The app requests the following permissions:
*   **Microphone:** For speaking practice sessions.
*   **Storage/Gallery:** For uploading profile pictures.
*   **Notifications:** For reminders and content updates.
*   **Internet:** Standard requirement for API and video streaming.

## 13. Third-Party Dependencies
| Package | Purpose |
| :--- | :--- |
| `stacked` | Architecture framework |
| `dio` | API Networking |
| `easy_localization` | Multi-language support |
| `firebase_messaging` | Push notifications |
| `cached_network_image` | Image caching |
| `chewie` | Video playback UI |
| `flutter_secure_storage` | Token security |

## 14. Environment & Configuration
*   **Firebase:** Configured via `firebase_options.dart`.
*   **Sensitive Files (DO NOT COMMIT):**
    *   `android/app/google-services.json`
    *   `ios/Runner/GoogleService-Info.plist`
    *   `.env` files (if used for keys).

## 15. Build & Release Process
1.  **Dependencies:** `flutter pub get`
2.  **Code Gen:** `flutter pub run build_runner build --delete-conflicting-outputs`
3.  **Run:** `flutter run`
4.  **Release Build (Android):** `flutter build appbundle --release`
5.  **Release Build (iOS):** `flutter build ipa --release`

## 16. Known Issues & Limitations
*   **Video Buffering:** High-resolution videos may lag on slow connections; consider implementing HLS.
*   **Offline Mode:** Currently, localization is offline, but courses require an active connection.
*   **Practice Feedback:** Detailed AI feedback on speaking practice depends on backend processing time.

## 17. Maintenance Guide
*   **Adding a Screen:**
    1. Create folder in `lib/ui/views`.
    2. Define View and ViewModel.
    3. Add route to `lib/app/app.dart`.
    4. Run `build_runner`.
*   **Adding Translations:**
    1. Update `assets/translations/en.json` and `am.json`.
    2. Run `flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart`.

## 18. Handover Checklist
*   [ ] Repository access granted (GitHub/GitLab).
*   [ ] Backend API documentation and base URLs provided.
*   [ ] Firebase Project ownership transferred.
*   [ ] Android Signing Key (.jks) and credentials provided.
*   [ ] iOS Distribution Certificates and App Store Connect access.
*   [ ] Third-party service keys (Google Maps, etc.) provided.

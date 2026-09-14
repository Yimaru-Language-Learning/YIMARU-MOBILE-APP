# Yimaru Codebase Learning Guide

This is a living technical guide for the Yimaru mobile and backend codebases. It records the explanations and questions explored in this conversation, and should be extended as the walkthrough continues.

## 1. Repository map and runtime architecture

Yimaru Mobile is a Flutter learning-management application for English learning. It uses the Stacked MVVM framework, Firebase, Easy Localization, Dio, secure storage, Vimeo video playback, and backend-owned progress and access rules.

### Runtime stack

```text
Native plugins and platform services
  -> Flutter bootstrap in main.dart
  -> Stacked routes, service locator, dialogs, and sheets
  -> services for session, HTTP, content, and device integrations
  -> JSON models
  -> viewmodels
  -> views and reusable widgets
```

`lib/main.dart` initializes Flutter bindings, the Stacked locator, Firebase, push notifications, localization, dialogs, bottom sheets, portrait orientation, and the `MaterialApp`. The initial route is `StartupView`.

`lib/app/app.dart` is the source of truth for routes and singleton registrations. Stacked generates `app.router.dart`, `app.locator.dart`, dialog registration, bottom-sheet registration, and `.form.dart` files from annotations. Edit source declarations and regenerate; do not manually edit generated outputs.

### Main architectural flow

```text
View -> ViewModel -> Service -> ApiService -> DioService -> backend
                                      <- JSON models <-
```

`BaseViewModel` owns local screen state. `ReactiveViewModel` additionally rebuilds when its registered listenable services notify. `FormViewModel` adds Stacked form state and generated validation/controller helpers.

## 2. Shared infrastructure

### Session and storage

`SecureStorageService` stores values such as user ID, access token, refresh token, cached profile fields, subscription flags, first-install state, and selected language.

`AuthenticationService` turns those persisted keys into the in-memory `User` session. It is a `ListenableServiceMixin`: when it updates the user and calls `notifyListeners`, reactive viewmodels watching it rebuild.

### HTTP and token renewal

`DioService` adds bearer authentication and JSON headers to requests. A 401 response triggers a refresh-token attempt using a separate Dio instance; a successful refresh saves replacement tokens and retries the failed request(s). If refresh fails, the service logs out and returns the user to Login.

`ApiService` owns endpoint calls and response parsing. It often returns either a typed list or a `{status, message, data}` map.

**Maintenance concern:** `DioService` currently logs refresh tokens, request headers, and payloads. This should not remain enabled in production logging.

## 3. Startup and navigation

### Question: How does a new or returning user get routed?

`StartupViewModel.runStartupLogic()`:

```text
restore selected language
  -> check first-install marker
  -> check stored user ID
  -> restore cached user when logged in
  -> check profile completion
  -> route to Landing, Login, Onboarding, Home, or Failure
```

For a returning authenticated user, Startup loads cached credentials, checks whether the profile is complete, refreshes profile data when necessary, and then replaces the route with Home.

## 4. UI style-name convention

### Question: What is `style25DG600`, and is it generated?

It is handwritten source code in `lib/ui/common/ui_helpers.dart`, not generated.

```text
style 25  DG  600
      |   |    +-- FontWeight.w600
      |   +------- dark grey (`kcDarkGrey`)
      +----------- font size 25
```

Examples:

- `style16P600`: 16px, primary color, `w600`
- `style18W600`: 18px, white, `w600`
- `style14MG400`: 14px, medium grey, normal weight
- `style18G700`: 18px, deep green, `w700`

The abbreviations are author-defined and occasionally inconsistent, so read the `TextStyle` declaration rather than relying solely on its identifier. Git history shows `style25DG600` was manually added.

## 5. Authentication

### Login structure

`LoginView` hosts an `IndexedStack` with three in-app pages:

```text
0: email/password
1: phone number
2: OTP verification
```

Email login constructs `{email, password}`, calls `ApiService.login`, saves `userId`, access token, and refresh token through `AuthenticationService.saveUserCredential`, registers the FCM device when possible, then returns to `StartupView` for central profile routing.

Phone login sends `phone_number` with the hard-coded Ethiopian prefix `251`, requests an OTP, and submits `{otp, phone_number}` to the shared verification endpoint.

Google and Apple login obtain provider identity tokens, send them to the backend provider-auth endpoints, then receive the normal session response. Apple sign-in is iOS-only.

### Registration structure

`RegisterView` has four in-app pages:

```text
0: email
1: phone number
2: create password
3: OTP verification
```

Email registration accumulates email, `role: STUDENT`, `otp_medium: email`, and password before calling `/api/v1/user/register`. Phone registration uses the same endpoint with `otp_medium: sms` and a phone number.

The shared OTP endpoint finalizes both login and registration. It returns a user/session response, after which the app returns to Startup.

**Details to remember:**

- `registerWithEmail` is inaccurately named because it also serves phone registration.
- The password screen says “eight character minimum,” but the client requires `password.length > 8`, meaning nine or more characters.
- Apple registration currently does not register the FCM device, unlike the Google and ordinary login paths.

## 6. Onboarding and initial assessment

### Question: What happens after a user signs up?

After OTP verification, Startup finds the profile incomplete and sends the user to Onboarding. `OnboardingService` loads field-option lists from the backend. `OnboardingView` uses an `IndexedStack` for full name, gender, age group, education, occupation, country/region, learning goals, language goals, challenges, and topic interest.

The viewmodel accumulates an unsaved `_userData` map. On the final onboarding screen it routes to Assessment and passes this map as route data. The profile is persisted only at the final assessment/onboarding screen.

### Assessment flow

```text
GET /assessment/session
  -> next CEFR level, initially A1
GET /assessment/questions?level=<next level>
  -> questions for the current level
POST /assessment/submit
  -> pass/fail and next level or final placement
```

The four assessment pages are:

```text
0: introduction
1: questions
2: result
3: final “start lesson” profile completion
```

The assessment model keeps session state, questions, locally selected answers, API submission answers, the placement result, and the unsaved onboarding profile map.

### Question: What happens when assessment is skipped?

The initial mobile-only answer was refined after inspecting the backend:

- The mobile client requests an assessment session before showing its introduction screen.
- The backend creates placement-progress state with `next_level = A1` and `completed = false`.
- Skipping never calls `POST /assessment/submit`.
- Therefore `users.knowledge_level` remains `NULL` and `users.initial_assessment_completed` remains `false`.
- A later placement attempt starts at A1. A1 is pending assessment state, not an assigned proficiency level.

The backend’s graded placement flow starts at A1 and continues A1 -> A2 -> B1 -> B2 -> C1 -> C2. On a failure it finalizes the learner at the highest previously passed level, or A1 if no level was passed. On finalization it writes `users.knowledge_level` and `users.initial_assessment_completed = true`.

The mobile app’s `PUT /user/knowledge-level` call after the result is redundant. The backend treats it as a legacy/manual endpoint; the assessment submit endpoint is the authoritative placement path.

### Assessment/mobile integration concern

The backend deliberately removes `is_correct` from question responses to prevent client-side grading. The current mobile assessment UI expects `option['is_correct']` and attempts to locate correct answers locally. The mobile flow should rely on the backend submission result for correctness and placement.

## 7. Placement level groups

### Question: What are Beginner, Intermediate, and Advanced?

The backend explicitly maps Learn programs to CEFR courses:

| Program | Courses |
| --- | --- |
| Beginner | A1, A2 |
| Intermediate | B1, B2 |
| Advanced | C1, C2 |

The placement assessment and Learn catalog use the same CEFR sequence.

### Question: Are A1 and A2 programs or courses?

They are courses.

```text
Program: Beginner
  - Course: A1
  - Course: A2
```

The complete hierarchy is:

```text
Program -> Course -> Module -> Lesson -> Practice
```

## 8. Learn English LMS

### Catalog loading

The Learn tab is the Learn English LMS. It is distinct from the Course tab’s Duolingo/IELTS exam-prep experience.

```text
GET /programs
GET /programs/:programId/courses
GET /courses/:courseId/modules
GET /modules/:moduleId/lessons
```

`LearnService` holds the currently loaded lists of programs, courses, modules, and lessons. It is not a complete offline tree. Navigating to a different parent replaces the current list at that hierarchy level. Fetches sort by backend `sort_order`.

### Access has three distinct layers

| Layer | Backend responsibility |
| --- | --- |
| Catalog reads | Return published content and catalog metadata |
| Subscription enforcement | Block consumption of premium Learn English content without an active subscription |
| Sequential progression | Decide whether a learner has completed required preceding items |

The mobile client’s `user.learn` subscription flag is a UI convenience. The backend is authoritative.

`Access` in catalog responses contains `isAccessible`, `isCompleted`, `reason`, counts, and progress percentages. For a standard `STUDENT`, Learn English gating is sequential:

```text
next program requires previous program complete
next course requires previous course complete
next module requires previous module complete
next lesson requires previous lesson's published practices complete
```

`OPEN_LEARNER` bypasses subscription and sequential locks. Normal registration creates a `STUDENT`.

### Question: Does initial assessment affect Learn access?

No. The Learn access service does not read `knowledge_level` or `initial_assessment_completed`. Assessment records a learner’s CEFR placement; Learn access is controlled by subscription tier and completion order.

### Video tracking versus progression

`LearnLessonDetailViewModel` resolves a Vimeo URL, creates the Chewie player, and sends a video heartbeat every ten seconds and at playback completion.

```text
Video completed -> engagement analytics
Practice completed -> persisted learning progress -> next item may unlock
```

Video heartbeats record position, completion, replay, and drop-off. They do not mark a Learn lesson complete or unlock the next lesson. The backend has a lesson-completion endpoint, but the current mobile Learn flow does not call it.

### Practice completion and progress roll-up

Practices may attach directly to a course, module, or lesson.

```text
Course/module/lesson practice
  -> POST /progress/practices/:practiceId/complete
  -> record completion for question set + parent scope
  -> recalculate module completion
  -> recalculate course completion
  -> recalculate program completion
  -> expose updated Access values
```

The backend’s practice-completion transaction is the central progression mechanism. Completion of all required published practices can roll up module, course, and program state. `LearnService.getLearnProgress()` fetches `/lms/progress-summary` and merges updated `Access` values into cached mobile models.

### Current Learn integration risks

- `ApiService.completePractice` builds a `data` argument but does not pass it to Dio. The backend needs parent kind and parent ID when practice location is ambiguous.
- The mobile app uses only `_practices.first`, even though the API returns a list.
- The current practice flow marks completion after the user reaches its result flow; it does not submit or grade recorded answers.
- API errors are frequently converted to empty lists, making network, authorization, parsing, and genuine-empty-content states indistinguishable.
- `LearnService` has a lowercase `learnService()` method. It is not a Dart constructor and therefore is not invoked automatically.
- `LearnService.getProgressSummary()` adds to totals without resetting them before repeat calls.

## 9. Takeover priorities

Before making major Learn changes, understand these areas in order:

1. Backend route and middleware access rules.
2. Practice completion scope and the progression transaction.
3. Mobile/backend practice request and response contracts.
4. `LearnService` cache ownership and progress-refresh behavior.
5. Video engagement tracking versus actual progression.

A useful end-to-end verification path is:

```text
Beginner -> A1 -> first module -> first lesson -> watch video
-> complete lesson practice -> GET /lms/progress-summary
-> inspect Access changes -> verify next lesson unlocks
```

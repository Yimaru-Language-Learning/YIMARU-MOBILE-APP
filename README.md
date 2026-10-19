# yimaru_app

A new Flutter project.

## Android releases

Run these from the project root:

```bash
make bump-version                 # 0.1.124+126 -> 0.1.125+127
make appbundle                    # Signed release .aab; does not upload
```

The bundle is written to `build/app/outputs/bundle/release/app-release.aab`.
Building does not bump the version automatically. `pubspec.yaml` supplies both
the Android version name and version code (and the shared Flutter app version).
Commit the version change before distributing a release.

Optional version bumps: `make bump-version PART=minor` or `PART=major`.
Both reset the lower version components and increase the existing build number
by one; the default `PART=patch` increases patch and build by one.

The default upload keystore is
`/Users/kerod/keystores/yimaru-upload-keystore.jks`. Override it on another machine:

```bash
make appbundle UPLOAD_KEYSTORE="/absolute/path/to/yimaru-upload-keystore.jks"
```

Signing passwords and the alias come from the existing **ignored**
`android/key.properties`. If setting up a new machine, create it locally with:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=/absolute/path/to/yimaru-upload-keystore.jks
```

`make appbundle` overrides only `storeFile`; direct Flutter/Gradle builds keep
using the configured property. Never commit `key.properties`, passwords, or the
keystore. No Play Store upload or deployment is performed by these targets.

## iOS push notifications

Firebase is configured for bundle ID `com.yimaru.lms.app`. The Runner target now
includes Push Notifications, background fetch/remote notifications, and the APNs
entitlement. Keep Firebase method swizzling enabled. Device registration uses
the existing backend endpoint with `platform: ios`; APNs-not-ready, network
recovery, token rotation, restored sessions, and logout use the shared sync worker.

Before distributing an iOS build:

1. In Apple Developer, enable Push Notifications for this app ID and regenerate
   any manually managed provisioning profiles. Keep Sign in with Apple enabled.
2. In Firebase project `yimaru-academy-5e7e2` → Project settings → Cloud Messaging,
   upload/confirm an APNs `.p8` authentication key with its Key ID and Apple Team
   ID. Never commit the key. This console setup cannot be verified from the repo.
3. Check signing for Debug and Release/TestFlight. The source entitlement uses
   `development`; Xcode's distribution signing/export must produce `production`
   for TestFlight/App Store. Do not disable push to bypass a signing error.
4. Run the iOS push checks in [TESTING.md](TESTING.md) on a physical iPhone with
   tester-only notifications, including a distribution-signed build.

Foreground iOS alerts use native Firebase presentation; background/terminated
notification payloads are displayed by the OS. Notification taps open the app;
the existing custom `type: Page` destination remains a placeholder, not a new
deep-link implementation. Silent/data-only background work is not guaranteed.

References: [Firebase Flutter setup](https://firebase.google.com/docs/cloud-messaging/flutter/get-started)
and [message handling](https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages).

## Golden Tests

Golden tests are already setup for this project. To run the tests and update the golden files, run:

```bash
flutter test --update-goldens
```

The golden test screenshots will be stored under `test/golden/`.

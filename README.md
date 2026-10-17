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

## Golden Tests

Golden tests are already setup for this project. To run the tests and update the golden files, run:

```bash
flutter test --update-goldens
```

The golden test screenshots will be stored under `test/golden/`.

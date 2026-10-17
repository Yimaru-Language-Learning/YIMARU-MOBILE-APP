.DEFAULT_GOAL := help

FLUTTER ?= flutter
DART ?= dart
UPLOAD_KEYSTORE ?= /Users/kerod/keystores/yimaru-upload-keystore.jks
PUBSPEC ?= pubspec.yaml
PART ?= patch

.PHONY: help appbundle check-android-signing bump-version

help:
	@printf '%s\n' \
	  'make appbundle                 Build a signed release Android app bundle' \
	  'make bump-version              Increment version patch and build number' \
	  'make bump-version PART=minor    Increment minor version and build number' \
	  'make bump-version PART=major    Increment major version and build number'

check-android-signing:
	@test -r "$(UPLOAD_KEYSTORE)" && test -s "$(UPLOAD_KEYSTORE)" || \
	  { printf '%s\n' 'Upload keystore missing or unreadable; set UPLOAD_KEYSTORE to its path.' >&2; exit 1; }
	@test -r android/key.properties && test -s android/key.properties || \
	  { printf '%s\n' 'Create ignored android/key.properties with keyAlias, keyPassword, and storePassword (see README.md).' >&2; exit 1; }

appbundle: check-android-signing
	@YIMARU_UPLOAD_KEYSTORE="$(UPLOAD_KEYSTORE)" "$(FLUTTER)" build appbundle --release
	@printf '%s\n' 'Bundle: build/app/outputs/bundle/release/app-release.aab'

bump-version:
	@"$(DART)" tool/bump_version.dart "$(PART)" "$(PUBSPEC)"

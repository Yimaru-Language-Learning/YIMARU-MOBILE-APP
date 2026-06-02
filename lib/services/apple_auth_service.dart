import 'dart:io';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

class AppleAuthService with ListenableServiceMixin {
  AuthorizationCredentialAppleID? _appleCredential;

  AuthorizationCredentialAppleID? get appleCredential => _appleCredential;

  AppleAuthService() {
    listenToReactiveValues([_appleCredential]);
  }

  bool get isSupported => Platform.isIOS;

  Future<void> appleAuth() async {
    if (!isSupported) {
      throw UnsupportedError('Apple Sign-In is only available on iOS.');
    }

    _appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    notifyListeners();
  }

  void logout() {
    _appleCredential = null;
    notifyListeners();
  }
}

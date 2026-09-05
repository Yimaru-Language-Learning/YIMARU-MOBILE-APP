import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';

class AppleAuthService with ListenableServiceMixin {
  AuthorizationCredentialAppleID? _appleCredential;

  AuthorizationCredentialAppleID? get appleCredential => _appleCredential;

  String? get emailForDisplay => resolveEmailForDisplay(
        credentialEmail: _appleCredential?.email,
        identityToken: _appleCredential?.identityToken,
      );

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

    if (kDebugMode) {
      _logAppleCredentialForDebug();
    }

    notifyListeners();
  }

  void _logAppleCredentialForDebug() {
    if (!kDebugMode) return;

    final credential = _appleCredential;
    debugPrint(
      '[AppleAuth] Separate credential fields: '
      'givenName present=${credential?.givenName?.trim().isNotEmpty ?? false}, '
      'familyName present=${credential?.familyName?.trim().isNotEmpty ?? false}, '
      'email present=${credential?.email?.trim().isNotEmpty ?? false}',
    );

    final token = credential?.identityToken;
    if (token == null || token.isEmpty) {
      debugPrint('[AppleAuth] No identity token returned.');
      return;
    }

    try {
      final segments = token.split('.');
      if (segments.length != 3) {
        debugPrint('[AppleAuth] Identity token is not a three-part JWT.');
        return;
      }

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
      );
      debugPrint(
        '[AppleAuth] Decoded identity-token payload '
        '(unverified; backend validation still required):\n'
        '${const JsonEncoder.withIndent('  ').convert(payload)}',
      );
    } catch (_) {
      debugPrint('[AppleAuth] Unable to decode identity-token payload.');
    }
  }

  void logout() {
    _appleCredential = null;
    notifyListeners();
  }

  /// Resolves an email for display only. The backend must still validate the
  /// Apple identity token before trusting any of its claims.
  static String? resolveEmailForDisplay({
    String? credentialEmail,
    String? identityToken,
  }) {
    final directEmail = credentialEmail?.trim();
    if (directEmail != null && directEmail.isNotEmpty) {
      return directEmail;
    }

    if (identityToken == null || identityToken.isEmpty) return null;

    try {
      final segments = identityToken.split('.');
      if (segments.length != 3) return null;

      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
      );
      if (payload is! Map<String, dynamic>) return null;

      final tokenEmail = payload['email'];
      if (tokenEmail is! String) return null;

      final normalizedEmail = tokenEmail.trim();
      return normalizedEmail.isEmpty ? null : normalizedEmail;
    } catch (_) {
      return null;
    }
  }
}

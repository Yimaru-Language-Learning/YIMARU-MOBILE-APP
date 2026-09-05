import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/apple_auth_service.dart';

String _identityToken(Map<String, dynamic> payload) {
  final encodedPayload =
      base64Url.encode(utf8.encode(jsonEncode(payload))).replaceAll('=', '');
  return 'header.$encodedPayload.signature';
}

void main() {
  group('AppleAuthService.resolveEmailForDisplay', () {
    test('prefers and trims the email returned directly by Apple', () {
      final email = AppleAuthService.resolveEmailForDisplay(
        credentialEmail: '  first@example.com  ',
        identityToken: _identityToken({'email': 'token@example.com'}),
      );

      expect(email, 'first@example.com');
    });

    test('falls back to the identity-token email claim', () {
      final email = AppleAuthService.resolveEmailForDisplay(
        identityToken:
            _identityToken({'email': ' hidden@privaterelay.appleid.com '}),
      );

      expect(email, 'hidden@privaterelay.appleid.com');
    });

    test('returns null for malformed tokens', () {
      expect(
        AppleAuthService.resolveEmailForDisplay(
          identityToken: 'not-a-jwt',
        ),
        isNull,
      );
    });

    test('returns null when neither Apple response contains an email', () {
      expect(
        AppleAuthService.resolveEmailForDisplay(
          credentialEmail: '  ',
          identityToken: _identityToken({'sub': 'apple-user-id'}),
        ),
        isNull,
      );
    });
  });
}

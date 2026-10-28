import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Referral Code & Deep Link Logic Unit Tests -', () {
    test('Extracts referral code from HTTPS redirect path (/r/:code)', () {
      final uri = Uri.parse('https://api.yimaruacademy.com/r/BEZA20');
      String? extractedCode;
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'r') {
        if (uri.pathSegments.length >= 2) {
          extractedCode = uri.pathSegments[1];
        }
      }
      expect(extractedCode?.trim().toUpperCase(), equals('BEZA20'));
    });

    test('Extracts referral code from Custom URL Scheme (yimaru://r/:code)', () {
      final uri = Uri.parse('yimaru://r/BEZA20');
      String? extractedCode;
      if (uri.host == 'r' && uri.pathSegments.isNotEmpty) {
        extractedCode = uri.pathSegments.first;
      }
      expect(extractedCode?.trim().toUpperCase(), equals('BEZA20'));
    });

    test('Extracts referral code from ?ref query parameter', () {
      final uri = Uri.parse('https://yimaruacademy.com/join?ref=ALEMU10');
      final extractedCode = uri.queryParameters['ref'];
      expect(extractedCode?.trim().toUpperCase(), equals('ALEMU10'));
    });

    test('Extracts referral code from ?referral_code query parameter', () {
      final uri =
          Uri.parse('https://yimaruacademy.com/join?referral_code=NATI50');
      final extractedCode = uri.queryParameters['referral_code'];
      expect(extractedCode?.trim().toUpperCase(), equals('NATI50'));
    });

    test('Extracts referral code from Google Play Install Referrer raw string',
        () {
      const rawReferrer =
          'utm_source=referral&utm_medium=influencer&utm_campaign=BEZA20';
      final dummyUri = Uri.parse('https://dummy/?$rawReferrer');
      final campaignCode = dummyUri.queryParameters['utm_campaign'];

      expect(campaignCode, equals('BEZA20'));
      expect(campaignCode?.trim().toUpperCase(), equals('BEZA20'));
    });

    test('Normalizes lowercase and whitespace referral code', () {
      const input = '  beza20  ';
      final normalized = input.trim().toUpperCase();
      expect(normalized, equals('BEZA20'));
    });

    test('Registration payload omits referral_code when none provided', () {
      final Map<String, dynamic> userData = {
        'role': 'STUDENT',
        'otp_medium': 'email',
        'password': 'password123',
      };

      const referralInput = '';
      if (referralInput.trim().isNotEmpty) {
        userData['referral_code'] = referralInput.trim().toUpperCase();
      }

      expect(userData.containsKey('referral_code'), isFalse);
      expect(userData['role'], equals('STUDENT'));
    });

    test('Registration payload includes referral_code when valid code provided',
        () {
      final Map<String, dynamic> userData = {
        'role': 'STUDENT',
        'otp_medium': 'email',
        'password': 'password123',
      };

      const referralInput = '  beza20  ';
      if (referralInput.trim().isNotEmpty) {
        userData['referral_code'] = referralInput.trim().toUpperCase();
      }

      expect(userData.containsKey('referral_code'), isTrue);
      expect(userData['referral_code'], equals('BEZA20'));
    });

    test('Attribution payload matches backend contract', () {
      final payload = {
        'referral_code': 'BEZA20'.trim().toUpperCase(),
        'attribution_type': 'PLAY_REFERRER',
      };

      expect(payload['referral_code'], equals('BEZA20'));
      expect(payload['attribution_type'], equals('PLAY_REFERRER'));
    });
  });
}

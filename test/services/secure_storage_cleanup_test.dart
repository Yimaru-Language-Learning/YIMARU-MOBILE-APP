import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final pending in [true, false]) {
    test(
        'logout clears credentials and preserves only pending cleanup=$pending',
        () async {
      FlutterSecureStorage.setMockInitialValues({
        'userId': '7',
        'accessToken': 'old-access',
        'refreshToken': 'old-refresh',
        'email': 'tester@example.test',
        SecureStorageService.pendingPushTokenCleanupKey: '$pending',
      });
      final storage = SecureStorageService();
      await storage.clear();
      expect(
          await const FlutterSecureStorage().readAll(),
          pending
              ? {SecureStorageService.pendingPushTokenCleanupKey: 'true'}
              : isEmpty);
    });
  }
}

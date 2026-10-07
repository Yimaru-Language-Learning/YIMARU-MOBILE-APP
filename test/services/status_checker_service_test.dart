import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';

void main() {
  testWidgets('debug builds are unrestricted without checking the device',
      (tester) async {
    locator.registerSingleton<SecureStorageService>(SecureStorageService());
    addTearDown(() => locator.reset());

    const channel = MethodChannel('safe_device');
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (call) async {
      calls.add(call);
      return true;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));

    final service = StatusCheckerService();
    await service.checkDeveloperMode();

    expect(service.isDeveloperModeEnabled, isFalse);
    expect(await service.isRestricted(), isFalse);
    expect(calls, isEmpty);
  });
}

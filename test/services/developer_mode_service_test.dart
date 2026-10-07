import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/developer_mode_service.dart';

void main() {
  testWidgets('debug builds bypass developer-mode detection and polling',
      (tester) async {
    const channel = MethodChannel('safe_device');
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel,
        (call) async {
      calls.add(call);
      return true;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null));

    final service = DeveloperModeService();
    addTearDown(service.dispose);
    final statuses = <bool>[];
    final subscription = service.statusStream.listen(statuses.add);
    addTearDown(subscription.cancel);

    await service.checkNow();
    await tester.pump(const Duration(seconds: 10));

    expect(service.developerModeEnabled, isFalse);
    expect(statuses, isEmpty);
    expect(calls, isEmpty);
  });
}

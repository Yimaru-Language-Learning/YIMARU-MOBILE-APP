import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/reminder_activity_service.dart';

void main() {
  testWidgets('restored sessions and foreground heartbeats record activity',
      (tester) async {
    var now = DateTime(2026, 10, 12);
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () async => 7,
        sendActivity: (_) async => calls++,
        now: () => now);
    addTearDown(service.dispose);
    service.initialize();
    await tester.pump();
    expect(calls, 1);
    now = now.add(const Duration(minutes: 5));
    await tester.pump(const Duration(minutes: 5));
    expect(calls, 2);
    service.didChangeAppLifecycleState(AppLifecycleState.paused);
    now = now.add(const Duration(hours: 1));
    await tester.pump(const Duration(hours: 1));
    expect(calls, 2);
    service.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();
    expect(calls, 3);
    service.dispose();
  });
  testWidgets('logged-out and background sessions do not ping', (tester) async {
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () async => null, sendActivity: (_) async => calls++);
    addTearDown(service.dispose);
    service.initialize();
    await tester.pump();
    expect(calls, 0);
    service.didChangeAppLifecycleState(AppLifecycleState.paused);
    service.beginSession(7);
    await tester.pump(const Duration(minutes: 10));
    expect(calls, 0);
  });
  testWidgets('repeated triggers are single flight and logout cancels old work',
      (tester) async {
    final pending = Completer<void>();
    CancelToken? token;
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () async => 7,
        sendActivity: (cancellation) {
          token = cancellation;
          calls++;
          return pending.future;
        });
    addTearDown(service.dispose);
    service.beginSession(7);
    await tester.pump();
    service.beginSession(7);
    await service.ping();
    expect(calls, 1);
    service.endSession();
    expect(token!.isCancelled, isTrue);
    pending.complete();
    await tester.pump(const Duration(minutes: 10));
    expect(calls, 1);
  });
  testWidgets('failed activity retries without blocking the app',
      (tester) async {
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () async => 7,
        sendActivity: (_) async {
          calls++;
          if (calls == 1) throw StateError('offline');
        });
    addTearDown(service.dispose);
    service.beginSession(7);
    await tester.pump();
    expect(calls, 1);
    await tester.pump(const Duration(minutes: 1));
    expect(calls, 2);
    expect(tester.takeException(), isNull);
    service.dispose();
  });
  testWidgets('a late restored account cannot overwrite a new login',
      (tester) async {
    final restored = Completer<int?>();
    var lookups = 0;
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () {
          lookups++;
          return lookups == 1 ? restored.future : Future.value(8);
        },
        sendActivity: (_) async => calls++);
    addTearDown(service.dispose);
    service.initialize();
    service.beginSession(8);
    await tester.pump();
    expect(calls, 1);
    restored.complete(7);
    await tester.pump();
    expect(calls, 1);
    service.dispose();
  });
  testWidgets('a paused pending lookup cannot send after backgrounding',
      (tester) async {
    final lookup = Completer<int?>();
    var calls = 0;
    final service = ReminderActivityService(
        getUserId: () => lookup.future, sendActivity: (_) async => calls++);
    addTearDown(service.dispose);
    service.beginSession(7);
    service.didChangeAppLifecycleState(AppLifecycleState.paused);
    lookup.complete(7);
    await tester.pump();
    expect(calls, 0);
  });
}

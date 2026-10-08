import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/services/android_device_token_sync.dart';
import 'package:yimaru_app/services/push_notification_service.dart';

class TestMessaging extends Mock implements FirebaseMessaging {
  final refreshes = StreamController<String>.broadcast();
  int refreshSubscriptions = 0;
  int permissionRequests = 0;

  @override
  Stream<String> get onTokenRefresh {
    refreshSubscriptions++;
    return refreshes.stream;
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async => null;

  @override
  Future<void> subscribeToTopic(String topic) async {}

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
  }) async {
    permissionRequests++;
    throw Exception('Permission/plugin unavailable');
  }
}

void main() {
  testWidgets('logs listener attachment and refresh events without token values',
      (tester) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final messaging = TestMessaging();
    final sync = AndroidDeviceTokenSync(
      getToken: () async => null,
      getAuthenticatedUserId: () async => null,
      registerToken: (_, __) async {},
    );
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: true,
      androidTokenSync: sync,
      internetStatusChanges: const Stream<InternetStatus>.empty(),
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
    });
    final previous = debugPrint;
    final logs = <String>[];
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null) logs.add(message);
    };
    try {
      await service.updateFCMToken();
      await service.updateFCMToken();
      messaging.refreshes.add('private-fcm-token');
      messaging.refreshes.addError(StateError('private-error-details'));
      await tester.pump();
      expect(logs, containsAllInOrder([
        '[FCM Sync] Token-refresh listener attached',
        '[FCM Sync] Token-refresh listener already attached',
        '[FCM Sync] Refresh event received',
        '[FCM Sync] Token-refresh listener error (StateError)',
      ]));
      expect(logs.join('\n'), isNot(contains('private-fcm-token')));
      expect(logs.join('\n'), isNot(contains('private-error-details')));
      expect(messaging.refreshSubscriptions, 1);
    } finally {
      debugPrint = previous;
    }
  });

  testWidgets('initializing twice adds one listener and requests permission once',
      (tester) async {
    // Avoid starting Firebase's native Android background isolate in this unit
    // test; the service itself is explicitly configured as Android below.
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final messaging = TestMessaging();
    final sync = AndroidDeviceTokenSync(
      getToken: () async => 'android-token',
      getAuthenticatedUserId: () async => 7,
      registerToken: (_, __) async {},
    );
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: true,
      androidTokenSync: sync,
      internetStatusChanges: const Stream<InternetStatus>.empty(),
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
    });
    final first = service.initialize();
    final second = service.initialize();
    expect(identical(first, second), isTrue);
    await first; // Android permission/plugin errors must not escape startup.
    await second;
    expect(messaging.refreshSubscriptions, 1);
    expect(messaging.permissionRequests, 1);
  });

  testWidgets('Android refresh and connectivity recovery share the worker',
      (tester) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final messaging = TestMessaging();
    final connectivity = StreamController<InternetStatus>.broadcast();
    final tokens = <String>[];
    var fail = true;
    final sync = AndroidDeviceTokenSync(
      getToken: () async => 'android-token',
      getAuthenticatedUserId: () async => 7,
      registerToken: (token, _) async {
        tokens.add(token);
        if (fail) throw Exception('Offline');
      },
    );
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: true,
      androidTokenSync: sync,
      internetStatusChanges: connectivity.stream,
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
      await connectivity.close();
    });
    await service.updateFCMToken();
    service.syncDeviceTokenForSession(7);
    await tester.pump();
    expect(tokens, ['android-token']);
    fail = false;
    connectivity.add(InternetStatus.connected);
    await tester.pump();
    expect(tokens, ['android-token', 'android-token']);
    messaging.refreshes.add('replacement-token');
    await tester.pump();
    expect(tokens.last, 'replacement-token');
    expect(messaging.permissionRequests, 0);
  });

  testWidgets('iOS never starts the new Android synchronization', (tester) async {
    final messaging = TestMessaging();
    final tokens = <String>[];
    final sync = AndroidDeviceTokenSync(
      getToken: () async => 'ios-token',
      getAuthenticatedUserId: () async => 7,
      registerToken: (token, _) async {
        tokens.add(token);
      },
    );
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: false,
      androidTokenSync: sync,
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
    });
    await service.updateFCMToken();
    service.syncDeviceTokenForSession(7);
    messaging.refreshes.add('new-ios-token');
    await tester.pump();
    expect(tokens, isEmpty);
  });
}

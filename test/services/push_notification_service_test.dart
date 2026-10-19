import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/services/android_device_token_sync.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/push_notification_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:dio/dio.dart';

class TestMessaging extends Mock implements FirebaseMessaging {
  final refreshes = StreamController<String>.broadcast();
  int refreshSubscriptions = 0;
  int permissionRequests = 0;
  int tokenReads = 0;
  int subscriptions = 0;
  int presentations = 0;
  String? apnsToken = 'test-apns';
  String? fcmToken = 'test-fcm';
  FirebaseException? tokenError;
  bool failTopic = false;
  bool failPermission = true;
  bool failPresentation = false;
  bool failInitialMessage = false;
  bool failDeletion = false;
  int initialMessageReads = 0;
  int deletions = 0;
  Completer<void>? deletionGate;

  @override
  Future<String?> getAPNSToken() async => apnsToken;

  @override
  Future<String?> getToken({String? vapidKey}) async {
    tokenReads++;
    if (tokenError != null) throw tokenError!;
    return fcmToken;
  }

  @override
  Future<void> setForegroundNotificationPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  }) async {
    expectSync([alert, badge, sound], [true, true, true]);
    presentations++;
    if (failPresentation) throw StateError('temporary native failure');
  }

  @override
  Stream<String> get onTokenRefresh {
    refreshSubscriptions++;
    return refreshes.stream;
  }

  @override
  Future<RemoteMessage?> getInitialMessage() async {
    initialMessageReads++;
    if (failInitialMessage) {
      throw StateError('temporary initial-message failure');
    }
    return null;
  }

  @override
  Future<void> deleteToken() async {
    deletions++;
    if (deletionGate != null) await deletionGate!.future;
    if (failDeletion) throw StateError('offline');
    fcmToken = 'fresh-token-$deletions';
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    subscriptions++;
    if (failTopic) throw StateError('topic temporarily unavailable');
  }

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
    if (failPermission) throw Exception('Permission/plugin unavailable');
    return _NotificationSettings();
  }
}

class _NotificationSettings extends Mock implements NotificationSettings {}

class _Storage extends Mock implements SecureStorageService {
  final values = <String, bool>{};
  @override
  Future<bool?> getBool(String key) async => values[key];
  @override
  Future<void> setBool(String key, bool value) async {
    values[key] = value;
  }
}

class _LocalNotifications extends Mock
    implements FlutterLocalNotificationsPlugin {
  int shown = 0;
  @override
  Future<void> show({
    required int id,
    String? title,
    String? body,
    NotificationDetails? notificationDetails,
    String? payload,
  }) async {
    shown++;
  }
}

class _Auth extends Mock implements AuthenticationService {
  int id = 7;
  @override
  Future<int?> getUserId() async => id;
  @override
  Future<String?> getAccessToken() async => 'test-access';
}

class _Api extends Mock implements ApiService {
  final registrations = <Map<String, dynamic>>[];
  final backgroundFlags = <bool>[];
  final cancellations = <CancelToken?>[];
  final unregistrations = <String>[];
  final logoutCredentials = <String>[];
  bool failUnregister = false;
  @override
  Future<void> unregisterDevice(String token,
      {required String accessToken}) async {
    unregistrations.add(token);
    logoutCredentials.add(accessToken);
    if (failUnregister) throw StateError('offline');
  }

  @override
  Future<void> registerDevice(Map<String, dynamic> data,
      {CancelToken? cancelToken, bool backgroundSync = false}) async {
    registrations.add(data);
    backgroundFlags.add(backgroundSync);
    cancellations.add(cancelToken);
  }
}

void main() {
  testWidgets('iOS retries only failed initialization stages on resume',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final messaging = TestMessaging()
      ..failPermission = false
      ..failPresentation = true
      ..failInitialMessage = true;
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: false,
      isIOS: true,
      internetStatusChanges: const Stream<InternetStatus>.empty(),
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
    });
    try {
      await service.initialize();
      expect(messaging.presentations, 1);
      messaging
        ..failPresentation = false
        ..failInitialMessage = false;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(messaging.presentations, 2);
      expect(messaging.initialMessageReads, 2);
      expect(messaging.permissionRequests, 1);
      expect(messaging.refreshSubscriptions, 1);
      await service.initialize();
      expect(messaging.presentations, 2);
      expect(messaging.initialMessageReads, 2);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  testWidgets(
      'permission exceptions recover on reconnect without repeated prompts after success',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final messaging = TestMessaging();
    final connectivity = StreamController<InternetStatus>.broadcast();
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: false,
      isIOS: true,
      internetStatusChanges: connectivity.stream,
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
      await connectivity.close();
    });
    try {
      await service.initialize();
      messaging.failPermission = false;
      connectivity.add(InternetStatus.connected);
      await tester.pump();
      expect(messaging.permissionRequests, 2);
      connectivity.add(InternetStatus.connected);
      await tester.pump();
      expect(messaging.permissionRequests, 2);
      expect(messaging.presentations, 1);
      expect(messaging.refreshSubscriptions, 1);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });

  for (final restarting in [false, true]) {
    testWidgets(
        'offline logout cleanup blocks old-token registration; restart=$restarting',
        (tester) async {
      final storage = _Storage();
      final auth = _Auth();
      final api = _Api()..failUnregister = true;
      locator.registerSingleton<SecureStorageService>(storage);
      locator.registerSingleton<AuthenticationService>(auth);
      locator.registerSingleton<ApiService>(api);
      final messaging = TestMessaging()..failDeletion = true;
      final connectivity = StreamController<InternetStatus>.broadcast();
      PushNotificationService createService() => PushNotificationService(
            messaging: messaging,
            isAndroid: false,
            isIOS: true,
            internetStatusChanges: connectivity.stream,
          );
      var service = createService();
      addTearDown(() async {
        await service.dispose();
        await messaging.refreshes.close();
        await connectivity.close();
        await locator.reset();
      });
      await service.updateFCMToken();
      service.syncDeviceTokenForSession(7);
      await tester.pump();
      expect(api.registrations, hasLength(1));
      await service.prepareForLogout(accessToken: 'old-access');
      expect(api.unregistrations, ['test-fcm']);
      expect(api.logoutCredentials, ['old-access']);
      expect(storage.values[PushNotificationService.pendingTokenCleanupKey],
          isTrue);
      if (restarting) {
        await tester.runAsync(service.dispose);
        service = createService();
        await service.updateFCMToken();
      }
      auth.id = 8;
      service.syncDeviceTokenForSession(8);
      messaging.refreshes.add('test-fcm');
      await tester.pump();
      expect(api.registrations, hasLength(1));
      messaging.failDeletion = false;
      connectivity.add(InternetStatus.connected);
      await tester.pump();
      expect(api.registrations, hasLength(2));
      expect(
          api.registrations.last['device_token'], startsWith('fresh-token-'));
      expect(storage.values[PushNotificationService.pendingTokenCleanupKey],
          isFalse);
    });
  }

  testWidgets(
      'logout unregisters and invalidates; delayed invalidation cannot delete a new session token',
      (tester) async {
    final storage = _Storage();
    final auth = _Auth();
    final api = _Api();
    locator.registerSingleton<SecureStorageService>(storage);
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<ApiService>(api);
    final messaging = TestMessaging();
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: true,
      isIOS: false,
      internetStatusChanges: const Stream<InternetStatus>.empty(),
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
      await locator.reset();
    });
    await service.updateFCMToken();
    service.syncDeviceTokenForSession(7);
    await tester.pump();
    messaging.deletionGate = Completer<void>();
    var loggedOut = false;
    final logout = service
        .prepareForLogout(accessToken: 'old-access')
        .then((_) => loggedOut = true);
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await logout;
    expect(loggedOut, isTrue);
    expect(service.hasPendingTokenCleanup, isTrue);
    auth.id = 8;
    service.syncDeviceTokenForSession(8);
    messaging.refreshes.add('old-refresh-during-cleanup');
    await tester.pump();
    expect(api.registrations, hasLength(1));
    expect(messaging.deletions, 1);
    messaging.deletionGate!.complete();
    await tester.pump();
    expect(api.registrations, hasLength(2));
    expect(api.registrations.last['device_token'], 'fresh-token-1');
    expect(messaging.deletions, 1);
    expect(api.unregistrations, ['test-fcm']);
  });

  testWidgets(
      'logs listener attachment and refresh events without token values',
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
      expect(
          logs,
          containsAllInOrder([
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

  testWidgets(
      'initializing twice adds one listener and requests permission once',
      (tester) async {
    // Avoid starting Firebase's native Android background isolate in this unit
    // test; the service itself is explicitly configured as Android below.
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
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
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
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

  testWidgets('non-mobile platforms never start mobile synchronization',
      (tester) async {
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
      isIOS: false,
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

  testWidgets('iOS waits for APNs and retains the APNs-not-ready safeguard',
      (tester) async {
    final messaging = TestMessaging()..apnsToken = null;
    final service = PushNotificationService(
        messaging: messaging, isAndroid: false, isIOS: true);
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
    });
    expect(await service.getDeviceToken(), isNull);
    await service.subscribeToTopic('yimaru');
    expect(messaging.tokenReads, 0);
    expect(messaging.subscriptions, 0);
    messaging.apnsToken = 'ready';
    expect(await service.getDeviceToken(), 'test-fcm');
    messaging.tokenError = FirebaseException(
        plugin: 'firebase_messaging', code: 'apns-token-not-set');
    expect(await service.getDeviceToken(), isNull);
    messaging.tokenError = FirebaseException(
        plugin: 'firebase_messaging', code: 'service-unavailable');
    await expectLater(
        service.getDeviceToken(), throwsA(isA<FirebaseException>()));
  });

  testWidgets('iOS late APNs retries, rotates tokens, and resets on logout',
      (tester) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final messaging = TestMessaging()..apnsToken = null;
    final auth = _Auth();
    final api = _Api();
    locator.registerSingleton<AuthenticationService>(auth);
    locator.registerSingleton<ApiService>(api);
    final service = PushNotificationService(
      messaging: messaging,
      isAndroid: false,
      isIOS: true,
      internetStatusChanges: const Stream<InternetStatus>.empty(),
    );
    addTearDown(() async {
      await service.dispose();
      await messaging.refreshes.close();
      await locator.reset();
    });
    await service.updateFCMToken();
    service.syncDeviceTokenForSession(7);
    await tester.pump();
    expect(api.registrations, isEmpty);
    messaging.apnsToken = 'ready';
    await tester.pump(const Duration(seconds: 5));
    expect(api.registrations.single,
        {'device_token': 'test-fcm', 'platform': 'ios'});
    expect(api.backgroundFlags.single, isTrue);
    expect(api.cancellations.single, isNotNull);
    // APNs recovery must also subscribe without requiring a token-refresh event.
    expect(messaging.subscriptions, 1);
    service.syncDeviceTokenForSession(7);
    await tester.pump();
    expect(api.registrations, hasLength(1));
    messaging.refreshes.add('replacement-ios-token');
    await tester.pump();
    expect(api.registrations.last['device_token'], 'replacement-ios-token');
    expect(messaging.subscriptions, 2);
    service.resetDeviceTokenSync();
    messaging.refreshes.add('logged-out-token');
    await tester.pump();
    expect(api.registrations, hasLength(2));
    auth.id = 8;
    messaging.fcmToken = 'next-account-token';
    service.syncDeviceTokenForSession(8);
    await tester.pump();
    expect(api.registrations.last,
        {'device_token': 'next-account-token', 'platform': 'ios'});
    expect(messaging.permissionRequests, 0);
  });

  testWidgets(
      'iOS initialization presents natively and cannot duplicate banners',
      (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    try {
      final messaging = TestMessaging()..failTopic = true;
      final local = _LocalNotifications();
      final service = PushNotificationService(
        messaging: messaging,
        localNotifications: local,
        isAndroid: false,
        isIOS: true,
        internetStatusChanges: const Stream<InternetStatus>.empty(),
      );
      addTearDown(() async {
        await service.dispose();
        await messaging.refreshes.close();
      });
      final first = service.initialize();
      expect(identical(first, service.initialize()), isTrue);
      await first;
      await tester.pump();
      expect(messaging.presentations, 1);
      expect(messaging.permissionRequests, 1);
      expect(messaging.refreshSubscriptions, 1);
      await service.showNotification(const RemoteMessage(
          notification: RemoteNotification(title: 'Test', body: 'Only once')));
      expect(local.shown, 0);
      messaging.failTopic = false;
      messaging.refreshes.add('refreshed-ios-token');
      await tester.pump();
      expect(messaging.subscriptions, greaterThanOrEqualTo(2));
      expect(tester.takeException(), isNull);
    } finally {
      debugDefaultTargetPlatformOverride = null;
    }
  });
}

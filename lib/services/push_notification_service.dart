import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:yimaru_app/app/app.locator.dart';

import 'android_device_token_sync.dart';
import 'api_service.dart';
import 'authentication_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await locator<PushNotificationService>().setupFlutterNotifications();
  await locator<PushNotificationService>().showNotification(message);
}

class PushNotificationService {
  PushNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    bool? isAndroid,
    AndroidDeviceTokenSync? androidTokenSync,
    Stream<InternetStatus>? internetStatusChanges,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotifications =
            localNotifications ?? FlutterLocalNotificationsPlugin(),
        _isAndroid = isAndroid ?? Platform.isAndroid,
        _androidTokenSync = androidTokenSync,
        _internetStatusChanges = internetStatusChanges;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final bool _isAndroid;
  final Stream<InternetStatus>? _internetStatusChanges;
  AndroidDeviceTokenSync? _androidTokenSync;
  Future<void>? _initialization;
  bool _disposed = false;
  StreamSubscription<String>? _tokenSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _openedSubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;
  AppLifecycleListener? _lifecycleListener;

  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() {
    if (_disposed) return Future<void>.value();
    return _initialization ??= _initialize();
  }

  Future<void> _initialize() async {
    // Initialize FCM token
    await _initializationStep(updateFCMToken);
    if (_disposed) return;

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request permission
    await _initializationStep(_requestPermission);

    // setup message handle
    await _initializationStep(_setupMessageHandler);

    // Subscribe to all devices
    if (_isAndroid) {
      unawaited(_initializationStep(() => subscribeToTopic('yimaru')));
    } else {
      subscribeToTopic('yimaru');
    }
  }

  Future<void> _initializationStep(Future<void> Function() step) async {
    if (_disposed) return;
    try {
      await step();
    } catch (_) {
      if (!_isAndroid) rethrow;
      // Permission/token/plugin failures must not prevent Android app startup.
      _logTokenSync('Android notification initialization deferred');
    }
  }

  AndroidDeviceTokenSync get _androidSync => _androidTokenSync ??=
      AndroidDeviceTokenSync(
        getToken: getDeviceToken,
        getAuthenticatedUserId: () async {
          final auth = locator<AuthenticationService>();
          final userId = await auth.getUserId();
          final accessToken = await auth.getAccessToken();
          return accessToken == null || accessToken.trim().isEmpty
              ? null
              : userId;
        },
        registerToken: (token, cancellation) =>
            locator<ApiService>().registerDevice({
          'device_token': token,
          'platform': 'android',
        }, cancelToken: cancellation, backgroundSync: true),
      );

  void syncDeviceTokenForSession(int userId) {
    if (_disposed || !_isAndroid) return;
    _androidSync.beginSession(userId);
  }

  void resetDeviceTokenSync() {
    _androidTokenSync?.endSession();
  }

  void deviceTokenCredentialsUpdated() {
    if (!_disposed && _isAndroid) {
      _androidTokenSync?.credentialsUpdated();
    }
  }

  void _listenForAndroidRecovery() {
    if (_lifecycleListener != null) return;
    _androidSync.setForeground(
        WidgetsBinding.instance.lifecycleState == null ||
            WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed);
    _lifecycleListener = AppLifecycleListener(
      onStateChange: (state) =>
          _androidSync.setForeground(state == AppLifecycleState.resumed),
    );
    _internetSubscription = (_internetStatusChanges ??
            InternetConnection().onStatusChange)
        .listen((status) {
      if (status == InternetStatus.connected && _androidSync.hasPendingSync) {
        _androidSync.requestSync();
      }
    }, onError: (Object _) {
      // Retry timers and app resume remain available if monitoring fails.
    });
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        provisional: false,
        announcement: false,
        criticalAlert: false);
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    //  Android setup
    const channel = AndroidNotificationChannel(
      'yimaru', // id
      'Yimaru', // title
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // IOS setup
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    // Flutter notification setup
    await _localNotifications.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'Page') {
          // navigatorKey.currentState?.pushNamed('RouteName');
        }
      },
    );

    _isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails('yimaru', 'Yimaru',
                enableVibration: true,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
                importance: Importance.high),
            iOS: DarwinNotificationDetails(
                presentAlert: true, presentBadge: true, presentSound: true)),
      );
    }
  }

  Future<void> _setupMessageHandler() async {
    if (_disposed) return;
    // Foreground message
    _foregroundSubscription = FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => showNotification(message));

    // Background message
    _openedSubscription =
        FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Opened app
    final initialMessage = await _messaging.getInitialMessage();

    if (!_disposed && initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'Page') {
      // navigatorKey.currentState?.pushNamed('RouteName');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
  }

  Future<String?> getDeviceToken() async => await _messaging.getToken();

  void _logTokenSync(String message) {
    if (kDebugMode && _isAndroid) debugPrint('[FCM Sync] $message');
  }

  Future<void> updateFCMToken() async {
    if (_disposed) return;
    if (_tokenSubscription != null) {
      _logTokenSync('Token-refresh listener already attached');
      return;
    }
    _tokenSubscription = _messaging.onTokenRefresh.listen((newToken) {
      if (!_disposed && _isAndroid) {
        _logTokenSync('Refresh event received');
        _androidSync.receiveToken(newToken);
      }
    }, onError: (Object error) {
      if (!_disposed && _isAndroid) {
        _logTokenSync('Token-refresh listener error (${error.runtimeType})');
        _androidSync.requestSync();
      }
    });
    _logTokenSync('Token-refresh listener attached');
    if (_isAndroid) _listenForAndroidRecovery();
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _androidTokenSync?.dispose();
    _lifecycleListener?.dispose();
    await _tokenSubscription?.cancel();
    await _foregroundSubscription?.cancel();
    await _openedSubscription?.cancel();
    await _internetSubscription?.cancel();
  }
}

import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:yimaru_app/app/app.locator.dart';

import '../firebase_options.dart';
import 'device_token_sync.dart';
import 'api_service.dart';
import 'authentication_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // The OS displays notification payloads in the background. Do not depend on
  // the foreground service locator or show a duplicate local notification.
}

class PushNotificationService {
  PushNotificationService({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? localNotifications,
    bool? isAndroid,
    bool? isIOS,
    DeviceTokenSync? deviceTokenSync,
    DeviceTokenSync? androidTokenSync,
    Stream<InternetStatus>? internetStatusChanges,
  })  : _messaging = messaging ?? FirebaseMessaging.instance,
        _localNotifications =
            localNotifications ?? FlutterLocalNotificationsPlugin(),
        _isAndroid = isAndroid ?? Platform.isAndroid,
        _isIOS = isIOS ?? Platform.isIOS,
        _tokenSync = deviceTokenSync ?? androidTokenSync,
        _internetStatusChanges = internetStatusChanges;

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _localNotifications;
  final bool _isAndroid;
  final bool _isIOS;
  final Stream<InternetStatus>? _internetStatusChanges;
  DeviceTokenSync? _tokenSync;
  Future<void>? _initialization;
  Future<void>? _defaultTopicAttempt;
  bool _defaultTopicSubscribed = false;
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
    if (_isIOS) {
      // Native foreground presentation avoids duplicate local iOS banners.
      await _initializationStep(() =>
          _messaging.setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true));
    }

    // setup message handle
    await _initializationStep(_setupMessageHandler);

    // Subscribe to all devices
    unawaited(_subscribeToDefaultTopic());
  }

  Future<void> _initializationStep(Future<void> Function() step) async {
    if (_disposed) return;
    try {
      await step();
    } catch (_) {
      if (!_supportsDeviceSync) rethrow;
      // Permission/token/plugin failures must not prevent mobile app startup.
      _logTokenSync('Notification initialization deferred');
    }
  }

  bool get _supportsDeviceSync => _isAndroid || _isIOS;

  DeviceTokenSync get _deviceSync => _tokenSync ??= DeviceTokenSync(
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
          'platform': _isAndroid ? 'android' : 'ios',
        }, cancelToken: cancellation, backgroundSync: true),
      );

  void syncDeviceTokenForSession(int userId) {
    if (_disposed || !_supportsDeviceSync) return;
    _deviceSync.beginSession(userId);
  }

  void resetDeviceTokenSync() {
    _tokenSync?.endSession();
  }

  void deviceTokenCredentialsUpdated() {
    if (!_disposed && _supportsDeviceSync) {
      _tokenSync?.credentialsUpdated();
    }
  }

  void _listenForDeviceRecovery() {
    if (_lifecycleListener != null) return;
    _deviceSync.setForeground(WidgetsBinding.instance.lifecycleState == null ||
        WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed);
    _lifecycleListener = AppLifecycleListener(
      onStateChange: (state) {
        final resumed = state == AppLifecycleState.resumed;
        _deviceSync.setForeground(resumed);
        if (resumed && _isIOS) unawaited(_subscribeToDefaultTopic());
      },
    );
    _internetSubscription =
        (_internetStatusChanges ?? InternetConnection().onStatusChange).listen(
            (status) {
      if (status == InternetStatus.connected) {
        if (_deviceSync.hasPendingSync) _deviceSync.requestSync();
        if (_isIOS) unawaited(_subscribeToDefaultTopic());
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
    const initializationSettingsDarwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false);

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
    // iOS foreground notifications are presented by Firebase's native delegate.
    if (_disposed || !_isAndroid) return;
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await setupFlutterNotifications();
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
    await _trySubscribeToTopic(topic);
  }

  Future<bool> _trySubscribeToTopic(String topic) async {
    try {
      if (_disposed || (_isIOS && await _messaging.getAPNSToken() == null)) {
        return false;
      }

      await _messaging.subscribeToTopic(topic);
      return !_disposed;
    } on FirebaseException catch (error) {
      if (error.code == 'apns-token-not-set') return false;
      rethrow;
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      if (_disposed || (_isIOS && await _messaging.getAPNSToken() == null)) {
        return null;
      }

      final token = await _messaging.getToken();
      if (_isIOS && token != null && token.isNotEmpty) {
        // A cached FCM token may become usable after APNs without a refresh
        // event. Retry the initial topic subscription in that case as well.
        unawaited(_subscribeToDefaultTopic());
      }
      return token;
    } on FirebaseException catch (error) {
      if (error.code == 'apns-token-not-set') return null;
      rethrow;
    }
  }

  void _logTokenSync(String message) {
    if (kDebugMode && _supportsDeviceSync) debugPrint('[FCM Sync] $message');
  }

  Future<void> _subscribeToDefaultTopic() {
    if (_disposed || _defaultTopicSubscribed) return Future<void>.value();
    return _defaultTopicAttempt ??=
        _attemptDefaultTopic().whenComplete(() => _defaultTopicAttempt = null);
  }

  Future<void> _attemptDefaultTopic() async {
    try {
      _defaultTopicSubscribed = await _trySubscribeToTopic('yimaru');
    } catch (_) {
      // Token refresh, reconnect, or resume can retry without blocking startup.
      _logTokenSync('Topic subscription deferred');
    }
  }

  Future<void> updateFCMToken() async {
    if (_disposed) return;
    if (_tokenSubscription != null) {
      _logTokenSync('Token-refresh listener already attached');
      return;
    }
    _tokenSubscription = _messaging.onTokenRefresh.listen((newToken) {
      if (!_disposed && _supportsDeviceSync) {
        _logTokenSync('Refresh event received');
        _deviceSync.receiveToken(newToken);
        if (_isIOS) {
          _defaultTopicSubscribed = false;
          unawaited(_subscribeToDefaultTopic());
        }
      }
    }, onError: (Object error) {
      if (!_disposed && _supportsDeviceSync) {
        _logTokenSync('Token-refresh listener error (${error.runtimeType})');
        _deviceSync.requestSync();
      }
    });
    _logTokenSync('Token-refresh listener attached');
    if (_supportsDeviceSync) _listenForDeviceRecovery();
  }

  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _tokenSync?.dispose();
    _lifecycleListener?.dispose();
    await _tokenSubscription?.cancel();
    await _foregroundSubscription?.cancel();
    await _openedSubscription?.cancel();
    await _internetSubscription?.cancel();
  }
}

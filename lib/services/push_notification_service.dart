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
import 'secure_storage_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // The OS displays notification payloads in the background. Do not depend on
  // the foreground service locator or show a duplicate local notification.
}

class PushNotificationService {
  static const pendingTokenCleanupKey =
      SecureStorageService.pendingPushTokenCleanupKey;
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
  bool _initializationStarted = false;
  bool _permissionConfigured = false;
  bool _presentationConfigured = false;
  bool _handlersConfigured = false;
  bool _backgroundHandlerRegistered = false;
  bool _cleanupLoaded = false;
  bool _pendingTokenCleanup = false;
  bool _sessionEnded = false;
  int _pushSessionGeneration = 0;
  Future<void>? _cleanupLoad;
  Future<void>? _tokenCleanup;
  StreamSubscription<String>? _tokenSubscription;
  StreamSubscription<RemoteMessage>? _foregroundSubscription;
  StreamSubscription<RemoteMessage>? _openedSubscription;
  StreamSubscription<InternetStatus>? _internetSubscription;
  AppLifecycleListener? _lifecycleListener;

  bool _isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() {
    if (_disposed) return Future<void>.value();
    _initializationStarted = true;
    return _initialization ??=
        _initialize().whenComplete(() => _initialization = null);
  }

  Future<void> _initialize() async {
    // Initialize FCM token
    await _initializationStep(updateFCMToken);
    if (_disposed) return;

    if (!_backgroundHandlerRegistered) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      _backgroundHandlerRegistered = true;
    }

    // Request permission
    if (!_permissionConfigured) {
      _permissionConfigured = await _initializationStep(_requestPermission);
    }
    if (_isIOS && !_presentationConfigured) {
      // Native foreground presentation avoids duplicate local iOS banners.
      _presentationConfigured = await _initializationStep(() =>
          _messaging.setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true));
    }

    // setup message handle
    if (!_handlersConfigured) {
      _handlersConfigured = await _initializationStep(_setupMessageHandler);
    }

    // Subscribe to all devices
    unawaited(_subscribeToDefaultTopic());
    unawaited(_recoverTokenCleanup());
  }

  Future<bool> _initializationStep(Future<void> Function() step) async {
    if (_disposed) return false;
    try {
      await step();
      return true;
    } catch (error) {
      if (!_supportsDeviceSync) rethrow;
      // Permission/token/plugin failures must not prevent mobile app startup.
      _logTokenSync(
          'Notification initialization deferred (${error.runtimeType})');
      return false;
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
    _sessionEnded = false;
    _deviceSync.beginSession(userId);
  }

  bool get hasPendingTokenCleanup => _pendingTokenCleanup;

  SecureStorageService? get _storage =>
      locator.isRegistered<SecureStorageService>()
          ? locator<SecureStorageService>()
          : null;

  Future<void> _loadTokenCleanup() => _cleanupLoad ??= () async {
        if (_cleanupLoaded) return;
        _pendingTokenCleanup =
            await _storage?.getBool(pendingTokenCleanupKey) ?? false;
        _cleanupLoaded = true;
      }()
          .whenComplete(() => _cleanupLoad = null);

  /// Uses a credential snapshot: logout holds the credential-write queue, so
  /// ordinary authenticated requests would deadlock waiting for that queue.
  Future<void> prepareForLogout({String? accessToken}) async {
    if (_disposed || !_supportsDeviceSync) return;
    _pushSessionGeneration++;
    _sessionEnded = true;
    _defaultTopicSubscribed = false;
    resetDeviceTokenSync();
    // Finish a pre-existing read before setting the durable cleanup marker.
    try {
      await _loadTokenCleanup();
    } catch (_) {
      _logTokenSync('Could not read token cleanup marker');
    }
    _pendingTokenCleanup = true;
    _cleanupLoaded = true;
    try {
      await _storage?.setBool(pendingTokenCleanupKey, true);
    } catch (_) {
      _logTokenSync('Could not persist token cleanup marker');
    }
    try {
      final token = _tokenSync?.currentToken ??
          await _messaging.getToken().timeout(const Duration(seconds: 2));
      if (token != null &&
          accessToken != null &&
          locator.isRegistered<ApiService>()) {
        await locator<ApiService>()
            .unregisterDevice(token, accessToken: accessToken);
      }
    } catch (_) {
      _logTokenSync('Device unregistration deferred; invalidating token');
    }
    try {
      await _cleanupToken().timeout(const Duration(seconds: 3));
    } catch (_) {
      // Keep the marker, including after process restart. A new account must
      // not register this installation until token invalidation completes.
      _logTokenSync('Token invalidation deferred');
    }
  }

  Future<void> _cleanupToken() {
    if (!_pendingTokenCleanup) return Future<void>.value();
    return _tokenCleanup ??= () async {
      await _messaging.deleteToken();
      _pendingTokenCleanup = false;
      await _storage?.setBool(pendingTokenCleanupKey, false);
    }()
        .whenComplete(() => _tokenCleanup = null);
  }

  Future<void> _recoverTokenCleanup() async {
    if (_disposed || !_supportsDeviceSync) return;
    try {
      await _loadTokenCleanup();
      await _cleanupToken();
    } catch (_) {
      _logTokenSync('Token invalidation deferred');
    }
  }

  void _recoverNotifications() {
    if (_disposed) return;
    if (_initializationStarted) unawaited(initialize());
    unawaited(_recoverTokenCleanup());
    if (_isIOS) unawaited(_subscribeToDefaultTopic());
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
        if (resumed) _recoverNotifications();
      },
    );
    _internetSubscription =
        (_internetStatusChanges ?? InternetConnection().onStatusChange).listen(
            (status) {
      if (status == InternetStatus.connected) {
        if (_deviceSync.hasPendingSync) _deviceSync.requestSync();
        _recoverNotifications();
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
    _foregroundSubscription ??= FirebaseMessaging.onMessage
        .listen((RemoteMessage message) => showNotification(message));

    // Background message
    _openedSubscription ??=
        FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Opened app
    final initialMessage = await _messaging
        .getInitialMessage()
        .timeout(const Duration(seconds: 10));

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
      await _loadTokenCleanup();
      await _cleanupToken();
      if (_sessionEnded) return null;
      if (_disposed || (_isIOS && await _messaging.getAPNSToken() == null)) {
        return null;
      }

      final token = await _messaging.getToken();
      if (_supportsDeviceSync && token != null && token.isNotEmpty) {
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
    if (_disposed ||
        _sessionEnded ||
        _pendingTokenCleanup ||
        _defaultTopicSubscribed) {
      return Future<void>.value();
    }
    return _defaultTopicAttempt ??=
        _attemptDefaultTopic().whenComplete(() => _defaultTopicAttempt = null);
  }

  Future<void> _attemptDefaultTopic() async {
    final generation = _pushSessionGeneration;
    try {
      await _loadTokenCleanup();
      if (_pendingTokenCleanup || _sessionEnded) {
        return;
      }
      final subscribed = await _trySubscribeToTopic('yimaru');
      if (generation == _pushSessionGeneration) {
        _defaultTopicSubscribed = subscribed;
      }
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
      unawaited(_receiveRefreshedToken(newToken));
    }, onError: (Object error) {
      if (!_disposed && _supportsDeviceSync) {
        _logTokenSync('Token-refresh listener error (${error.runtimeType})');
        _deviceSync.requestSync();
      }
    });
    _logTokenSync('Token-refresh listener attached');
    if (_supportsDeviceSync) _listenForDeviceRecovery();
  }

  Future<void> _receiveRefreshedToken(String token) async {
    if (_disposed || !_supportsDeviceSync) return;
    final generation = _pushSessionGeneration;
    _logTokenSync('Refresh event received');
    try {
      await _loadTokenCleanup();
      if (_disposed || generation != _pushSessionGeneration || _sessionEnded) {
        return;
      }
      if (_pendingTokenCleanup) {
        await _recoverTokenCleanup();
        _deviceSync.requestSync();
        return;
      }
      _deviceSync.receiveToken(token);
      _defaultTopicSubscribed = false;
      unawaited(_subscribeToDefaultTopic());
    } catch (_) {
      _logTokenSync('Token-refresh handling deferred');
    }
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

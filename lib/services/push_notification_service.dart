import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yimaru_app/app/app.locator.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await locator<PushNotificationService>().setupFlutterNotifications();
  await locator<PushNotificationService>().showNotification(message);
}
class PushNotificationService { final _messaging = FirebaseMessaging.instance;

bool _isFlutterLocalNotificationInitialized = false;

final _localNotifications = FlutterLocalNotificationsPlugin();

Future<void> initialize() async {
  // Initialize FCM token
  await updateFCMToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Request permission
  await _requestPermission();

  // setup message handle
  await _setupMessageHandler();

  // Subscribe to all devices
  subscribeToTopic('yimaru');
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
  // Foreground message
  FirebaseMessaging.onMessage
      .listen((RemoteMessage message) => showNotification(message));

  // Background message
  FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

  // Opened app
  final initialMessage = await _messaging.getInitialMessage();

  if (initialMessage != null) {
    _handleBackgroundMessage(initialMessage);
  }
}

void _handleBackgroundMessage(RemoteMessage message) {
  if (message.data['type'] == 'Page') {
    // navigatorKey.currentState?.pushNamed('RouteName');
  }
}

Future<void> subscribeToTopic(String topic) async {
  await FirebaseMessaging.instance.subscribeToTopic(topic);
}

Future<void> updateFCMToken() async {
  // print('DEVICE TOKEN: ${await _messaging.getToken()}');
  _messaging.onTokenRefresh.listen((newToken) {
    // updateTokenOnServer(newToken);
  });
}
}

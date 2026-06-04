import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/in_app_notification.dart';

import '../app/app.locator.dart';
import 'api_service.dart';

class InAppNotificationService with ListenableServiceMixin {
  // Dependency injection
  final _apiService = locator<ApiService>();

  // Initialization
  learnService() {
    listenToReactiveValues([_unreadCount, _notifications]);
  }

  // Unread count
  int _unreadCount = 0;

  int get unreadCount => _unreadCount;

  // Notifications
  List<InAppNotification> _notifications = [];

  List<InAppNotification> get notifications => _notifications;

  // Unread notifications
  Future<void> markNotificationRead() async {
    await _apiService.markNotificationsRead();
    _unreadCount = await _apiService.getUnreadNotifications();
    notifyListeners();
  }

  // All notifications
  Future<void> getAllNotifications() async {
    _notifications = await _apiService.getAllNotifications();
    notifyListeners();
  }

  // Unread notifications
  Future<void> getUnreadNotifications() async {
    _unreadCount = await _apiService.getUnreadNotifications();
    notifyListeners();
  }
}

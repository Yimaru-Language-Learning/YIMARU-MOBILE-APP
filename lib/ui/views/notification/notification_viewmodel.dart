import 'package:stacked/stacked.dart';
import '../../common/retryable_load.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/in_app_notification.dart';
import '../../../services/in_app_notification_service.dart';
import '../../../services/localization_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class NotificationViewModel extends ReactiveViewModel {
  // Dependency injection
  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _localizationService = locator<LocalizationService>();

  final _inAppNotificationService = locator<InAppNotificationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_localizationService, _inAppNotificationService];

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // Notifications
  List<InAppNotification> get _notifications =>
      _inAppNotificationService.notifications;

  List<InAppNotification> get notifications => _notifications;

  // Notification count
  int get _unreadCount => _inAppNotificationService.unreadCount;

  int get unreadCount => _unreadCount;

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Notifications
  Future<void> getAllNotifications() async =>
      await runReadLoad(() => _getAllNotifications(),
          busyObject: StateObjects.notifications);

  Future<void> _getAllNotifications() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppNotificationService.getAllNotifications();
    } else {
      throw StateError('No internet connection');
    }
  }

  Future<void> getUnreadNotifications() async =>
      await runBusyFuture(_getUnreadNotifications());

  Future<void> _getUnreadNotifications() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppNotificationService.getUnreadNotifications();
    }
  }

  Future<void> markNotificationsRead() async {
    if (await _statusChecker.checkConnection()) {
      await _inAppNotificationService.markNotificationRead();
    }
  }
}

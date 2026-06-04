import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/in_app_notification_service.dart';

class CourseViewModel extends ReactiveViewModel {
  // Dependency injection

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  final _inAppNotificationService = locator<InAppNotificationService>();


  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService,_inAppNotificationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Notification count
  int get _unreadCount => _inAppNotificationService.unreadCount;

  int get unreadCount => _unreadCount;

  // Course
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'English Proficiency Exams',
      'description':
          'Prepare for IELTS, TOEFL, or Duolingo with structured practice.'
    },
    /*   {
      'title': 'Skill-Based Courses',
      'description':
          'Learn English for the workplace, travel, and real-life communication.'
    },*/
  ];

  List<Map<String, dynamic>> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToNotification() async =>
      await _navigationService.navigateToNotificationView();

  Future<void> navigateToCourseCatalog() async =>
      await _navigationService.navigateToCourseCatalogView();


}

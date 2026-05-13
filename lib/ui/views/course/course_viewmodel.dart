import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/course.dart';
import '../../../models/course_detail.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseViewModel extends ReactiveViewModel {
  // Dependency injection

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Course
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'English Proficiency Exams',
      'description':
          'Prepare for IELTS, TOEFL, or Duolingo with structured practice.'
    },
    {
      'title': 'Skill-Based Courses',
      'description':
          'Learn English for the workplace, travel, and real-life communication.'
    },
  ];

  List<Map<String, dynamic>> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCourseCatalog() async =>
      await _navigationService.navigateToCourseCatalogView();
}

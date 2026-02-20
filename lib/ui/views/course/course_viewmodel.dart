import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/authentication_service.dart';

class CourseViewModel extends ReactiveViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  UserModel? get _user => _authenticationService.user;

  UserModel? get user => _user;

  // Courses
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'English Proficiency Exams',
      'subtitle':
          'Prepare for IELTS, TOEFL, or Duolingo with structured practice.',
    },
    {
      'title': 'Skill-Based Courses',
      'subtitle':
          'Learn English for the workplace, travel, and real-life communication.',
    },
  ];

  List<Map<String, dynamic>> get courses => _courses;

  // Navigation
  Future<void> navigateToCourseModule() async =>
      _navigationService.navigateToCourseModuleView();
}

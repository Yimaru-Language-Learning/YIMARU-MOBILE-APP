import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_lesson.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseModuleViewModel extends ReactiveViewModel {
  // Dependency injection
  final _courseService = locator<CourseService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_courseService, _authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Course lessons
  List<CourseLesson> get _lessons => _courseService.lessons;

  List<CourseLesson> get lessons => _lessons;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCourseLessonDetail(CourseLesson lesson) async =>
      await _navigationService.navigateToCourseLessonDetailView(lesson: lesson);

  Future<void> navigateToCoursePractice(int id) async =>
      await _navigationService.navigateToCoursePracticeView(
          id: id, practice: CoursePractices.lesson);
  // Remote api call

  // Course modules
  Future<void> getCourseLessons(int id) async =>
      await runBusyFuture(_getCourseLessons(id),
          busyObject: StateObjects.courseLessons);

  Future<void> _getCourseLessons(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _courseService.getCourseLessons(id);
    }
  }
}

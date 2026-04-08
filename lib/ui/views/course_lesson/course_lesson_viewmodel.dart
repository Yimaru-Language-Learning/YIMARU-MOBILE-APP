import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/course_lesson.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseLessonViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Course lessons
  List<CourseLesson> _courseLessons = [];

  List<CourseLesson> get courseLessons => _courseLessons;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) =>
      _navigationService.navigateToCoursePracticeView(id: id);

  Future<void> navigateToCourseLessonDetail(CourseLesson lesson) async =>
      await _navigationService.navigateToCourseLessonDetailView(lesson: lesson);

  // Remote api call

  // Course lessons
  Future<void> getCourseLessons(int courseId) async =>
      await runBusyFuture(_getCourseLessons(courseId),
          busyObject: StateObjects.courseLessons);

  Future<void> _getCourseLessons(int courseId) async {
    if (await _statusChecker.checkConnection()) {
      _courseLessons = await _apiService.getCourseLessons(1);
    }
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_course.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnCourseViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn courses
  List<LearnCourse> _learnCourses = [];

  List<LearnCourse> get learnCourses => _learnCourses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnModule(LearnCourse course) async =>
      _navigationService.navigateToLearnModuleView(course: course);

  Future<void> navigateToLearnPractice(int id) async => await _navigationService
      .navigateToLearnPracticeView(id: id, practice: LearnPractices.course);

  // Remote api call

  // Learn courses
  Future<void> getLearnCourses(int id) async =>
      await runBusyFuture(_getLearnCourses(id),
          busyObject: StateObjects.learnCourses);

  Future<void> _getLearnCourses(int id) async {
    if (_learnCourses.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _learnCourses = await _apiService.getLearnCourse(id);
        _learnCourses
            .sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
      }
    }
  }
}

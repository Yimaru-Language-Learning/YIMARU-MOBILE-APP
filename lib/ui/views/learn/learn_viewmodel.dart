import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';

class LearnViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn courses
  List<Course> _courses = [];

  List<Course> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLevel(int id) async =>
      _navigationService.navigateToLearnLevelView(id: id);

  // Remote api call

  // Learn courses
  Future<void> getCourses(int id) async => await runBusyFuture(_getCourses(id),
      busyObject: StateObjects.learnCourses);

  Future<void> _getCourses(int id) async {
    if (_courses.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _courses = await _apiService.getCourses(id);
      }
    }
  }
}

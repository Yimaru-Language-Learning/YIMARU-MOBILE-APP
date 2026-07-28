import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/course_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class MyProgressViewModel extends BaseViewModel {
  // Dependency injection
  final _learnService = locator<LearnService>();

  final _courseService = locator<CourseService>();

  final _navigationService = locator<NavigationService>();

  final _statusCheckerService = locator<StatusCheckerService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_learnService, _courseService];

  // Total practice count
  int get _totalCount => _learnService.totalCount;

  int get totalCount => _totalCount;

  // Completed practice count
  int get _completedCount => _learnService.completedCount;

  int get completedCount => _completedCount;

  // Total progress
  int get _totalProgress => _learnService.totalProgress;

  int get totalProgress => _totalProgress;

  // Courses
  final List<Map<String, dynamic>> _courses = [
/*    {
      'title': 'IELTS Preparation',
    },*/
    {
      'title': 'Duolingo English Test',
    },
  ];

  List<Map<String, dynamic>> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  // Remote api

  // Learning progress

  Future<void> getProgressSummary() async =>
      runBusyFuture(_getProgressSummary(),
          busyObject: StateObjects.progressSummary);

  Future<void> _getProgressSummary() async {
    if (await _statusCheckerService.checkConnection()) {
      // await _courseService.getCourseProgress();
      await _learnService.getProgressSummary();
    }
  }
}

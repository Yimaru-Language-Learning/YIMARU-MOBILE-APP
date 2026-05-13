import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_course.dart';
import '../../../services/api_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnCourseViewModel extends ReactiveViewModel {
  // Dependency injection
  final _learnService = locator<LearnService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_learnService];

  // Learn lessons
  List<LearnCourse> get _courses => _learnService.courses;

  List<LearnCourse> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnModule(LearnCourse course) async =>
      _navigationService.navigateToLearnModuleView(course: course);

  Future<void> navigateToLearnPractice(
          {required int id, required String level}) async =>
      await _navigationService.navigateToLearnPracticeView(
        id: id,
        level: level,
        label: 'Begin Level Practice',
        practice: LearnPractices.course,
        title: 'Let’s Practice Course $level',
        subtitle: 'Let’s quickly review what you’ve learned in this level!',
      );

  // Remote api call

  // Learn courses
  Future<void> getLearnCourses(int id) async =>
      await runBusyFuture(_getLearnCourses(id),
          busyObject: StateObjects.learnCourses);

  Future<void> _getLearnCourses(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnCourses(id);
    }
  }
}

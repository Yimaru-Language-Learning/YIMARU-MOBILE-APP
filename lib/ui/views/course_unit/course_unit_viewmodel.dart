import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/course_catalog.dart';

import '../../../app/app.locator.dart';
import '../../../models/course_module.dart';
import '../../../models/course_unit.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseUnitViewModel extends ReactiveViewModel {
  // Dependency injection
  final _courseService = locator<CourseService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_courseService];

  // Course units
  List<CourseUnit> get _units => _courseService.units;

  List<CourseUnit> get units => _units;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCourseModule(
          {required bool first,
          required CourseModule? module,
          required SubscriptionType type,
          required CourseCatalog catalog}) async =>
      await _navigationService.navigateToCourseModuleView(
          first: first,type: type, module: module, catalog: catalog);

  Future<void> navigateToCoursePractice(
          {required int id, required SubscriptionType type}) async =>
      await _navigationService.navigateToCoursePracticeView(
          id: id, type: type, practice: CoursePractices.unit);

  // Remote api call

  // Course units
  Future<void> getCourseUnits(int id) async =>
      await runBusyFuture(_getCourseUnits(id),
          busyObject: StateObjects.courseUnits);

  Future<void> _getCourseUnits(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _courseService.getCourseUnits(id);
    }
  }

  Future<void> getCourseModules({required int id, required int index}) async =>
      await runBusyFuture(_getCourseModules(id: id, index: index),
          busyObject: index);

  Future<void> _getCourseModules({required int id, required int index}) async {
    if (await _statusChecker.checkConnection()) {
      await _courseService.getCourseModules(id: id, index: index);
    }
  }
}

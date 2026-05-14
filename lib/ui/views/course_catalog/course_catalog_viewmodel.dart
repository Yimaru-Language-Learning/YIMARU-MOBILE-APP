import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/models/course_catalog.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';
import '../../../services/course_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseCatalogViewModel extends ReactiveViewModel {
  // Dependency injection
  final _courseService = locator<CourseService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_courseService];

  // Learn lessons
  List<CourseCatalog> get _catalogs => _courseService.catalogs;

  List<CourseCatalog> get catalogs => _catalogs;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) async =>
      _navigationService.navigateToCoursePracticeView(id: id);

  Future<void> navigateToCourseUnit(CourseCatalog catalog) async =>
      await _navigationService.navigateToCourseUnitView(catalog: catalog);

  // Remote api call

  // Course catalogs
  Future<void> getCourseCatalogs() async =>
      await runBusyFuture(_getCourseCatalogs(),
          busyObject: StateObjects.courseCatalogs);

  Future<void> _getCourseCatalogs() async {
    if (await _statusChecker.checkConnection()) {
      await _courseService.getCourseCatalogs();
    }
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/models/course_catalog.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseCatalogViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Course catalogs
  List<CourseCatalog> _courseCatalogs = [];

  List<CourseCatalog> get courseCatalogs => _courseCatalogs;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) async =>
      _navigationService.navigateToCoursePracticeView(id: id);

  // Future<void> navigateToSubcourse(Subcategory subcategory) async =>
  //     _navigationService.navigateToCourseView(subcategory: subcategory);

  // Remote api call

  // Course catalogs
  Future<void> getCourseCatalogs() async =>
      await runBusyFuture(_getSubcategories(),
          busyObject: StateObjects.courseCatalogs);

  Future<void> _getSubcategories() async {
    if (await _statusChecker.checkConnection()) {
      _courseCatalogs = await _apiService.getCourseCatalogs();
    }
  }
}

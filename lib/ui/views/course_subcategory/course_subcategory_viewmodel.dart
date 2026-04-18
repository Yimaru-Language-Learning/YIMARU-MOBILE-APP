import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/subcategory.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseSubcategoryViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Course subcategories
  List<Subcategory> _subcategories = [];

  List<Subcategory> get subcategories => _subcategories;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice(int id) async =>
      _navigationService.navigateToCoursePracticeView(id: id);

  Future<void> navigateToSubcourse(Subcategory subcategory) async =>
      _navigationService.navigateToCourseView(subcategory: subcategory);

  // Remote api call

  // Course subcategories
  Future<void> getSubcategories(int id) async =>
      await runBusyFuture(_getSubcategories(id),
          busyObject: StateObjects.subcategories);

  Future<void> _getSubcategories(int id) async {
    if (await _statusChecker.checkConnection()) {
      _subcategories = await _apiService.getSubcategories(id);
    }
  }
}

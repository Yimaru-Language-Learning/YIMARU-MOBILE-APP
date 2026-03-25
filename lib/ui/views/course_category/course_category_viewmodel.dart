import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/course_category.dart';
import '../../../models/user_model.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class CourseCategoryViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  UserModel? get _user => _authenticationService.user;

  UserModel? get user => _user;

  // Course categories
  List<CourseCategory> _categories = [];

  List<CourseCategory> get categories => _categories;

  // Navigation
  Future<void> navigateToCourseCategory(CourseCategory category) async =>
      _navigationService.navigateToCourseSubcategoryView(category: category);

  // Remote api call

  // Course categories
  Future<void> getCourseCategories() async =>
      await runBusyFuture(_getCourseCategories(),
          busyObject: StateObjects.courseCategories);

  Future<void> _getCourseCategories() async {
    if (categories.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _categories = await _apiService.getCourseCategories();

          rebuildUi();

      }
    }
  }
}

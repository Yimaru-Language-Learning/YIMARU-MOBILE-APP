import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/subcategory.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnSubcategoryViewModel extends ReactiveViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn subcategories
  List<Subcategory> _subcategories = [];

  List<Subcategory> get subcategories => _subcategories;

  // Navigation
  Future<void> navigateToLearn(int id) async =>
      _navigationService.navigateToLearnView(id: id);

  // Remote api call

  // Learn subcategories
  Future<void> getLearnSubcategories() async =>
      await runBusyFuture(_getLearnSubcategories(),
          busyObject: StateObjects.learnSubcategories);

  Future<void> _getLearnSubcategories() async {
    if (_subcategories.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _subcategories = await _apiService.getLearnSubcategories();
      }
    }
  }
}

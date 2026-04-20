import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/submodule.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnSubmoduleViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn submodule
  List<Submodule> _submodules = [];

  List<Submodule> get submodules => _submodules;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLessons(Submodule submodule) async =>
      await _navigationService.navigateToLearnLessonView(submodule: submodule);

  // Remote api call

  // Learn modules
  Future<void> getSubmodules(int id) async =>
      await runBusyFuture(_getSubmodules(id),
          busyObject: StateObjects.learnSubmodules);

  Future<void> _getSubmodules(int id) async {
    if (_submodules.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _submodules = await _apiService.getSubmodules(id);
        _submodules.sort(
            (a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
      }
    }
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/level.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnLevelViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn levels
  List<Level> _levels = [];

  List<Level> get levels => _levels;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToModule(Level level) async =>
      _navigationService.navigateToLearnModuleView(level: level);

  // Remote api call

  // Learn levels
  Future<void> getLevels(int id) async =>
      await runBusyFuture(_getLevels(id), busyObject: StateObjects.learnLevels);

  Future<void> _getLevels(int id) async {
    if (_levels.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _levels = await _apiService.getLevels(id);
        _levels.sort(
            (a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
      }
    }
  }
}

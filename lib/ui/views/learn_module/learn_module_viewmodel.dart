import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/module.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class LearnModuleViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn module
  List<Module> _modules = [];

  List<Module> get modules => _modules;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnSubmodule(Module module) async =>
      await _navigationService.navigateToLearnSubmoduleView(module: module);

  // Remote api call

  // Learn modules
  Future<void> getModules(int id) async => await runBusyFuture(_getModules(id),
      busyObject: StateObjects.learnModules);

  Future<void> _getModules(int id) async {
    if (_modules.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _modules = await _apiService.getModules(id);
        _modules.sort(
            (a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
      }
    }
  }
}

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

  Future<void> navigateToLearnLesson(
          {required String title,
          required String topics,
          required String subtitle,
          required String description,
          required List<Map<String, dynamic>> practices}) async =>
      await _navigationService.navigateToLearnLessonView(
          title: title,
          topics: topics,
          subtitle: subtitle,
          practices: practices,
          description: description);

  Future<void> navigateToLearnPractice(
          List<Map<String, dynamic>> practices) async =>
      await _navigationService.navigateToLearnPracticeView(
        practices: practices,
        title: 'Let’s Practice',
        buttonLabel: 'Begin Lesson Practice',
        subtitle: 'Let’s quickly review what you’ve learned in this lesson!',
      );

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

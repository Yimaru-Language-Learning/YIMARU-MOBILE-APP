import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_module.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_course.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/helper_functions.dart';

class LearnModuleViewModel extends ReactiveViewModel {
  // Dependency injection
  final _learnService = locator<LearnService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_learnService];

  // Learn module
  final Map<int, String> _refreshedIcons = {};

  Map<int, String> get refreshedIcons => _refreshedIcons;

  List<LearnModule> get _modules => _learnService.modules;

  List<LearnModule> get modules => _modules;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLesson(LearnModule module) async =>
      await _navigationService.navigateToLearnLessonView(module: module);

  Future<void> navigateToLearnPractice(
          {required int id, required String module}) async =>
      await _navigationService.navigateToLearnPracticeView(
        id: id,
        practice: LearnPractices.module,
        label: LocaleKeys.begin_module_practice.tr(),
        subtitle: LocaleKeys.lets_quickly_review.tr(),
        title: '${LocaleKeys.lets_practice_module.tr()} $module',
      );

  // Remote api call

  // Learn modules
  Future<void> getLearnModules(int id) async =>
      await runBusyFuture(_getLearnModules(id),
          busyObject: StateObjects.learnModules);

  Future<void> _getLearnModules(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnModules(id);
      await refreshModuleImages(_modules);
    }
  }

  // Get course
  LearnCourse? getUpdatedLearnCourse(int id) {
    return _learnService.getLearnCourseById(id);
  }

  //Refresh image
  Future<void> refreshModuleImages(List<LearnModule> modules) async {
    for (final module in modules) {
      final icon = module.icon;

      if (module.id == null || icon == null || icon.isEmpty) {
        continue;
      }

      final String? refreshedUrl = await _learnService.refreshObject(icon);

      if (refreshedUrl != null) {
        _refreshedIcons[module.id!] = refreshedUrl;
      }
    }
  }

  String getModuleImage(LearnModule module) =>
     getReadableUrl(_refreshedIcons[module.id] ?? '') ?? '';

}

import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_course.dart';
import '../../../models/learn_program.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';

class LearnCourseViewModel extends ReactiveViewModel {
  // Dependency injection
  final _learnService = locator<LearnService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_learnService, _authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // Learn lessons
  List<LearnCourse> get _courses => _learnService.courses;

  List<LearnCourse> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnSubscription() async => await _navigationService
      .navigateToSubscriptionView(type: SubscriptionType.learn);

  Future<void> navigateToLearnModule(
          {required bool first, required LearnCourse course}) async =>
      _navigationService.navigateToLearnModuleView(
          first: first, course: course);

  Future<void> navigateToLearnPractice(
          {required int id, required String level}) async =>
      await _navigationService.navigateToLearnPracticeView(
        id: id,
        level: level,
        practice: LearnPractices.course,
        label: LocaleKeys.begin_level_practice.tr(),
        subtitle: LocaleKeys.lets_quick_review.tr(),
        title: '${LocaleKeys.lets_practice_course.tr()} $level',
      );

  // Remote api call

  // Program and stage detection
  int? _programId;
  int? get programId => _programId;

  void setProgramId(int id) {
    _programId = id;
  }

  LearnProgram? get currentProgram =>
      _learnService.getLearnProgramById(_programId ?? 0);

  int getStageIndex([int? programId]) {
    final pId = programId ?? _programId;
    final program =
        pId != null ? _learnService.getLearnProgramById(pId) : currentProgram;
    if (program != null) {
      final name = (program.name ?? '').toLowerCase();
      if (name.contains('intermediate') ||
          name.contains('b1') ||
          name.contains('b2')) {
        return 1;
      }
      if (name.contains('advanced') ||
          name.contains('c1') ||
          name.contains('c2')) {
        return 2;
      }
      if (name.contains('beginner') ||
          name.contains('a1') ||
          name.contains('a2')) {
        return 0;
      }
      if (program.sortOrder != null) {
        return (program.sortOrder! % 3);
      }
    }

    if (pId != null) {
      final idx = _learnService.programs.indexWhere((p) => p.id == pId);
      if (idx != -1) {
        return idx % 3;
      }
    }

    // Fallback to checking loaded courses
    for (final c in courses) {
      final cName = (c.name ?? '').toUpperCase();
      if (cName.contains('B1') || cName.contains('B2')) return 1;
      if (cName.contains('C1') || cName.contains('C2')) return 2;
      if (cName.contains('A1') || cName.contains('A2')) return 0;
    }

    return 0;
  }

  int get stageIndex => getStageIndex();

  String getStageTitle([int? programId]) {
    switch (getStageIndex(programId)) {
      case 1:
        return LocaleKeys.intermediate.tr();
      case 2:
        return LocaleKeys.advanced.tr();
      default:
        return LocaleKeys.beginner.tr();
    }
  }

  String get stageTitle => getStageTitle();

  String getMotivationMessage([int? programId]) {
    switch (getStageIndex(programId)) {
      case 1:
        return LocaleKeys.finish_intermediate_stage_motivation.tr();
      case 2:
        return LocaleKeys.finish_advanced_stage_motivation.tr();
      default:
        return LocaleKeys.finish_beginner_stage_motivation.tr();
    }
  }

  String get motivationMessage => getMotivationMessage();

  // Learn courses
  Future<void> getLearnCourses(int id) async {
    _programId = id;
    await runBusyFuture(_getLearnCourses(id),
        busyObject: StateObjects.learnCourses);
  }

  Future<void> _getLearnCourses(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnCourses(id);
    }
  }
}

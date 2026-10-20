import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/widgets.dart';
import '../../common/retryable_load.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_course.dart';
import '../../../models/user.dart';
import '../../../services/authentication_service.dart';
import '../../../services/premium_purchase_service.dart';
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

  Future<void> navigateToLearnSubscription({required BuildContext context}) =>
      locator<PremiumPurchaseService>()
          .open(SubscriptionType.learn, context: context);

  Future<void> navigateToLearnModule(
      {required bool first,
      required LearnCourse course,
      BuildContext? context}) async {
    if (await interceptIosPremium(SubscriptionType.learn,
        effectiveAccessTier: course.effectiveAccessTier,
        access: course.access,
        context: context)) {
      return;
    }
    await _navigationService.navigateToLearnModuleView(
        first: first, course: course);
  }

  Future<void> navigateToLearnPractice(
      {required int id, required String level, BuildContext? context}) async {
    final course = courses.where((item) => item.id == id).firstOrNull;
    if (await interceptIosPremium(SubscriptionType.learn,
        effectiveAccessTier: course?.effectiveAccessTier,
        access: course?.access,
        context: context)) {
      return;
    }
    await _navigationService.navigateToLearnPracticeView(
      id: id,
      level: level,
      practice: LearnPractices.course,
      label: LocaleKeys.begin_level_practice.tr(),
      subtitle: LocaleKeys.lets_quick_review.tr(),
      title: '${LocaleKeys.lets_practice_course.tr()} $level',
    );
  }

  // Remote api call

  // Learn courses
  Future<void> getLearnCourses(int id) async =>
      await runReadLoad(() => _getLearnCourses(id),
          busyObject: StateObjects.learnCourses);

  Future<void> _getLearnCourses(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnCourses(id);
    } else {
      throw StateError('No internet connection');
    }
  }
}

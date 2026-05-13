import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../models/learn_module.dart';
import '../../../services/learn_service.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonViewModel extends ReactiveViewModel {
  // Dependency injection
  final _learnService = locator<LearnService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_learnService];

  // Learn lessons
  List<LearnLesson> get _lessons => _learnService.lessons;

  List<LearnLesson> get lessons => _lessons;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnPractice(int id) async =>
      await _navigationService.navigateToLearnPracticeView(
        id: id,
        label: 'Start Practice',
        practice: LearnPractices.lesson,
        title: 'Let\'s practice what you just learnt!',
        subtitle:
            'I’ll ask you a few questions, and you can respond naturally.',
      );

  Future<void> navigateToLearnLessonDetail(
          {required bool hasPractice,
          required LearnLesson lesson,
          required LearnModule module}) async =>
      await _navigationService.navigateToLearnLessonDetailView(
          lesson: lesson, module: module, hasPractice: hasPractice);

  // Remote api call

  // Learn lessons
  Future<void> getLessons(int id) async => await runBusyFuture(_getLessons(id),
      busyObject: StateObjects.learnLessons);

  Future<void> _getLessons(int id) async {
    if (await _statusChecker.checkConnection()) {
      await _learnService.getLearnLessons(id);
    }
  }
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/models/learn_lesson.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn lessons
  List<LearnLesson> _lessons = [];

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
          {required bool hasPractice, required LearnLesson lesson}) async =>
      await _navigationService.navigateToLearnLessonDetailView(
          lesson: lesson, hasPractice: hasPractice);

  // Remote api call

  // Learn lessons
  Future<void> getLessons(int id) async => await runBusyFuture(_getLessons(id),
      busyObject: StateObjects.learnLessons);

  Future<void> _getLessons(int id) async {
    if (_lessons.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _lessons = await _apiService.getLearnLessons(id);
        _lessons.sort((a, b) => (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0));
      }
    }
  }
}

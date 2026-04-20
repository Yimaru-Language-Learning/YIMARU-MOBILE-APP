import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../models/lesson.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Learn lessons
  List<Lesson> _lessons = [];

  List<Lesson> get lessons => _lessons;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLessonDetail(Lesson lesson) async =>
      await _navigationService.navigateToLearnLessonDetailView(lesson: lesson);

  // Remote api call

  // Learn modules
  Future<void> getLessons(int id) async => await runBusyFuture(_getLessons(id),
      busyObject: StateObjects.learnLessons);

  Future<void> _getLessons(int id) async {
    if (_lessons.isEmpty) {
      if (await _statusChecker.checkConnection()) {
        _lessons = await _apiService.getLessons(id);
        _lessons.sort(
            (a, b) => (a.displayOrder ?? 0).compareTo(b.displayOrder ?? 0));
      }
    }
  }
}

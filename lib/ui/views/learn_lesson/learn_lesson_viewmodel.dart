import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';

class LearnLessonViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Lessons
  final List<Map<String, dynamic>> _lessons = [
    {
      'title': '1.1 Introducing Yourself',
      'status': ProgressStatuses.completed,
      'thumbnail': 'assets/images/image_1.png',
    },
    {
      'status': ProgressStatuses.completed,
      'thumbnail': 'assets/images/image_1.png',
      'title': '1.2 Talking About Your Surroundings',
    },
    {
      'status': ProgressStatuses.pending,
      'title': '1.1 Introducing Yourself',
      'thumbnail': 'assets/images/image_1.png',
    },
  ];

  List<Map<String, dynamic>> get lessons => _lessons;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnLessonDetail(
          {required String title,
          required List<Map<String, dynamic>> practices,
          required String description}) async =>
      await _navigationService.navigateToLearnLessonDetailView(
          title: title, practices: practices, description: description);

  Future<void> navigateToLearnPractice(
          List<Map<String, dynamic>> practices) async =>
      await _navigationService.navigateToLearnPracticeView(
        practices: practices,
        title: 'Let’s Practice',
        buttonLabel: 'Begin Lesson Practice',
        subtitle: 'Let’s quickly review what you’ve learned in this lesson!',
      );
}

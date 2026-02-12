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

  Future<void> navigateToLearnLessonDetail() async =>
      await _navigationService.navigateToLearnLessonDetailView();
}

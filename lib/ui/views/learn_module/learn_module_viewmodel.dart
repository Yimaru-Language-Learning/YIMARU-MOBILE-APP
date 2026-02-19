import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';
import '../../common/enmus.dart';

class LearnModuleViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Map<String, dynamic>> _modules = [
    {
      'status': ProgressStatuses.completed,
      'title': 'Module 1: Greetings & Introductions',
      'subtitle':
          'Learn how to introduce yourself, talk about your surroundings, and start simple conversations.',
    },
    {
      'status': ProgressStatuses.started,
      'title': 'Module 2: Everyday Basics',
      'subtitle': 'Learn numbers, colors, and common objects.',
    },
    {
      'title': 'Module 3: At the Cafe',
      'status': ProgressStatuses.pending,
      'subtitle': 'Practice ordering food and drinks confidently.',
    },
    {
      'progress': 0,
      'status': ProgressStatuses.pending,
      'title': 'Module 4: Asking for Directions',
      'subtitle': 'Learn numbers, colors, and common objects.',
    },
  ];

  List<Map<String, dynamic>> get modules => _modules;

  void pop() => _navigationService.back();

  Future<void> navigateToLearnLesson() async =>
      await _navigationService.navigateToLearnLessonView();

  Future<void> navigateToLearnPractice() async =>
      await _navigationService.navigateToLearnPracticeView(
        title: 'Let’s Practice Module 1',
        buttonLabel: 'Begin Module Practice',
        subtitle:
        'Let’s quickly review what you’ve learned in this module! ',
      );
}

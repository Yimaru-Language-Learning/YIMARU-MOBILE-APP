import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';

class LearnLevelViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Map<String, dynamic>> _learnSubLevels = [
    {
      'title': 'A1',
      'current': true,
      'subtitle': 'Start your journey with the basics of English.',
    },
    {
      'title': 'A2',
      'current': false,
      'subtitle': 'Build upon your foundational knowledge.',
    },
  ];

  List<Map<String, dynamic>> get learnSubLevels => _learnSubLevels;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnModule() async =>
      _navigationService.navigateToLearnModuleView();

  Future<void> navigateToLearnPractice() async =>
      await _navigationService.navigateToLearnPracticeView(
        title: 'Let’s Practice Level 1',
        buttonLabel: 'Begin Level Practice',
        subtitle: 'Let’s quickly review what you’ve learned in this level! ',
      );
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';

class LearnViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Map<String, dynamic>> _learnLevels = [
    {
      'title': 'Beginner',
      'status': ProgressStatuses.completed,
      'subtitle': 'Start your journey with the basics of English.',
    },
    {
      'title': 'Intermediate',
      'status': ProgressStatuses.started,
      'subtitle': 'Practice real conversations and expand vocabulary.',
    },
    {
      'title': 'Advanced',
      'status': ProgressStatuses.pending,
      'subtitle': 'Achieve fluency and master complex topics.',
    },
  ];

  List<Map<String, dynamic>> get learnLevels => _learnLevels;

  Future<void> navigateToLearnLevel() async =>
      _navigationService.navigateToLearnLevelView();
}

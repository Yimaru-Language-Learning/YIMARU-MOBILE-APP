import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../../../app/app.locator.dart';

class ProgressViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Map<String, dynamic>> _progresses = [
    {
      'color': kcGreen,
      'title': 'Beginner',
      'isCompleted': true,
      'status': 'Completed',
      'icon': 'assets/icons/b1.svg',
      'subTitle': 'You’ve mastered everyday English basics!',
    },
    {
      'title': 'Elementary',
      'isCompleted': false,
      'status': 'In Progress',
      'color': kcPrimaryColor,
      'icon': 'assets/icons/b1.svg',
      'subTitle': 'Continue improving your conversations and fluency.',
    },
    {
      'title': 'Beginner',
      'isCompleted': true,
      'status': 'In Progress',
      'color': kcPrimaryColor,
      'icon': 'assets/icons/b1.svg',
      'subTitle': 'You’ve mastered everyday English basics!',
    },
  ];

  List<Map<String, dynamic>> get progresses => _progresses;

  final List<Map<String, dynamic>> _skillsLevel = [
    {
      'progress': 0.8,
      'skill': 'Speaking',
    },
    {
      'progress': 0.95,
      'skill': 'Listening',
    },
    {
      'progress': 0.75,
      'skill': 'Writing',
    },
    {
      'progress': 0.8,
      'skill': 'Reading',
    },
  ];

  List<Map<String, dynamic>> get skillsLevel => _skillsLevel;

  Future<void> navigateToOngoingProgress() async =>
      await _navigationService.navigateToOngoingProgressView();

  void pop() => _navigationService.back();
}

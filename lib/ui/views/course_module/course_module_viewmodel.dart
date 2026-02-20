import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';

import '../../../app/app.locator.dart';

class CourseModuleViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  // Course modules
  final List<Map<String, dynamic>> _modules = [
    {
      'title': 'Duolingo English Test',
    },
    {
      'title': 'IELTS',
    },
  ];

  List<Map<String, dynamic>> get modules => _modules;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToCoursePractice() async =>
      _navigationService.navigateToCoursePracticeView();

  Future<void> navigateToCoursePayment() async =>
      _navigationService.navigateToCoursePaymentView();
}

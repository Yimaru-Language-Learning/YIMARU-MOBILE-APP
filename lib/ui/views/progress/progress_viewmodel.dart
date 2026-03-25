import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class ProgressViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  // Courses
  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'IELTS Preparation',
    },
    {
      'title': 'Duolingo English Test',
    },
  ];

  List<Map<String, dynamic>> get courses => _courses;

  // Navigation
  void pop() => _navigationService.back();
}

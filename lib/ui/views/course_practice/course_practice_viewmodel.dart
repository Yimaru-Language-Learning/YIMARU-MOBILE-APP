import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class CoursePracticeViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  // Practices
  final List<Map<String, dynamic>> _practices = [
    {
      'title': 'Test 01',
    },
    {
      'title': 'Test 02',
    },
    {
      'title': 'Test 03',
    },
    {
      'title': 'Test 04',
    },
    {
      'title': 'Test 05',
    },
    {
      'title': 'Test 06',
    },
  ];

  List<Map<String, dynamic>> get practices => _practices;

  // Navigation
  void pop() => _navigationService.back();
}

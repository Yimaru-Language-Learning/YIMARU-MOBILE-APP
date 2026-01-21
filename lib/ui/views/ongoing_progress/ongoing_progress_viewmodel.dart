import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class OngoingProgressViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'IELTS Preparation',
    },
    {
      'title': 'Duolingo English Test',
    },
  ];

  List<Map<String, dynamic>> get courses => _courses;

  void pop() => _navigationService.back();
}

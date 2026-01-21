import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class PrivacyPolicyViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // Privacy policy
  final List<Map<String, dynamic>> _privacyPolicies = [
    {'title': 'Introduction'},
    {'title': 'Information We Collect'},
    {'title': 'How We Use Your Information'},
    {'title': 'Data Sharing and Disclosure'},
    {'title': 'Your Rights and Choices'},
    {'title': 'Data Security'}
  ];

  List<Map<String, dynamic>> get privacyPolicies => _privacyPolicies;

  // Navigation
  void pop() => _navigationService.back();
}

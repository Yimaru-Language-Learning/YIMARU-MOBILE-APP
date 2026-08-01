import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/faq.dart';
import '../../../services/api_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';

class FaqsViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Faqs
  List<Faq> _faqs = [];

  List<Faq> get faqs => _faqs;

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Profile detail fields
  Future<void> getFAQs() async =>
      await runBusyFuture(_getFAQs(), busyObject: StateObjects.faqs);

  Future<void> _getFAQs() async {
    if (await _statusChecker.checkConnection()) {
      _faqs = await _apiService.getFaqs();
    }
  }
}

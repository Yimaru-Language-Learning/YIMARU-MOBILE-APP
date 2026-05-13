import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/url_launcher_service.dart';
import '../../common/app_constants.dart';

class TelegramSupportViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  final _urlLauncherService = locator<UrlLauncherService>();

  // Launch telegram
  Future<void> launchTelegram() =>
      _urlLauncherService.launchUri(kTelegramSupportLink);

  // Navigation
  void pop() => _navigationService.back();
}

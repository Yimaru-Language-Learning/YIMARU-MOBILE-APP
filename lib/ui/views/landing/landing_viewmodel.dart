import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/authentication_service.dart';

class LandingViewModel extends BaseViewModel {
  // Dependency Injection
  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  // Controller
  final FlutterCarouselController _controller = FlutterCarouselController();

  FlutterCarouselController get controller => _controller;

  // In-app navigation
  void next() {
    _controller.nextPage();
  }

  // Navigation
  Future<void> navigateToLogin() async =>
      await _navigationService.replaceWithLoginView();

  // Remote api call

  // First time install

  Future<void> setFirstTimeInstall() async {
    await runBusyFuture(_setFirstTimeInstall());
  }

  Future<void> _setFirstTimeInstall() async {
    await _authenticationService.setFirstTimeInstall(false);
    await navigateToLogin();
  }
}

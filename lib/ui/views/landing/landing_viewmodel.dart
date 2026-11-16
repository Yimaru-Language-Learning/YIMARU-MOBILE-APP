import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/localization_service.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/authentication_service.dart';

class LandingViewModel extends ReactiveViewModel {
  // Dependency Injection
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];

  // Controller (kept for backwards compatibility if needed)
  final FlutterCarouselController _controller = FlutterCarouselController();
  FlutterCarouselController get controller => _controller;

  String get currentLanguageCode =>
      _localizationService.selectedLanguage['code'] ?? 'en';

  Future<void> toggleLanguage(BuildContext context) async {
    if (currentLanguageCode == 'en') {
      await _localizationService.setSelectedLanguage(
        context: context,
        title: {'code': 'am', 'language': 'አማርኛ'},
      );
    } else {
      await _localizationService.setSelectedLanguage(
        context: context,
        title: {'code': 'en', 'language': 'English'},
      );
    }
    rebuildUi();
  }

  // In-app navigation
  void next() {
    _controller.nextPage();
  }

  // Navigation
  Future<void> navigateToLogin() async =>
      await _navigationService.replaceWithLoginView();

  // First time install
  Future<void> setFirstTimeInstall() async {
    await runBusyFuture(_setFirstTimeInstall());
  }

  Future<void> _setFirstTimeInstall() async {
    await _authenticationService.setFirstTimeInstall(false);
    await navigateToLogin();
  }
}

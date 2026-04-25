import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonDetailViewModel extends BaseViewModel {
  // Dependency injection
  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Video player config
  InAppWebViewController? _webViewController;

  InAppWebViewController? get webViewController => _webViewController;

  // Video player
  void close() {
    webViewController?.dispose();
  }

  Future<void> pause() async {
    await webViewController?.pause();
  }

  void initializePlayer(InAppWebViewController controller) {
    _webViewController = controller;
    rebuildUi();
  }

  void onLoadVideoStart() {
    setBusyForObject(StateObjects.loadLessonVideo, true);
    rebuildUi();
  }

  void onLoadVideoComplete() {
    setBusyForObject(StateObjects.loadLessonVideo, false);
    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnPractice() async {}
  //   await _navigationService.navigateToLearnPracticeView();
}

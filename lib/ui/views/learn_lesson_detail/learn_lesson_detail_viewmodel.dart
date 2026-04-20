import 'package:chewie/chewie.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../services/status_checker_service.dart';

class LearnLessonDetailViewModel extends BaseViewModel {
  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  // Video player config
  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  InAppWebViewController? _webViewController;

  InAppWebViewController? get webViewController => _webViewController;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  // Video player
  void close() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
  }

  Future<void> pause() async {
    await _chewieController?.pause();
  }

  void initializePlayer(InAppWebViewController controller){
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

  Future<void> navigateToLearnPractice(
          List<Map<String, dynamic>> practices) async =>
      await _navigationService.navigateToLearnPracticeView(
        practices: practices,
        buttonLabel: 'Start Practice',
        title: 'Let \'s practice what you just learnt!',
        subtitle:
            'I’ll ask you a few questions, and you can respond naturally.',
      );
}

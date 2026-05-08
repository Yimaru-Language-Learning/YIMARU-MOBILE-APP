import 'package:chewie/chewie.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/status_checker_service.dart';
import '../../../services/vimeo_service.dart';
import '../../common/app_constants.dart';
import '../../common/helper_functions.dart';
import '../../common/ui_helpers.dart';

class LearnLessonDetailViewModel extends BaseViewModel {
  // Dependency injection
  final _vimeoService = locator<VimeoService>();

  final _navigationService = locator<NavigationService>();

  // Video player config
  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

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

  Future<void> initializePlayer(String url) async =>
      await runBusyFuture(_initializePlayer(url),
          busyObject: StateObjects.loadLessonVideo);

  Future<void> _initializePlayer(String url) async {
    final playableUrl = await _vimeoService.getVideoUrl(url);

    if (playableUrl == null) {
      throw Exception("Unable to load video");
    }

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(playableUrl));

    await _videoPlayerController?.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
    );

    notifyListeners();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToLearnPractice(int id) async =>
      await _navigationService.navigateToLearnPracticeView(
        id: id,
        label: 'Start Practice',
        practice: LearnPractices.lesson,
        title: 'Let\'s practice what you just learnt!',
        subtitle:
            'I’ll ask you a few questions, and you can respond naturally.',
      );
}

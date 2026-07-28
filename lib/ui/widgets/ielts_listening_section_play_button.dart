import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../views/course_practice/course_practice_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';

class IeltsListeningSectionPlayButton
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsListeningSectionPlayButton({super.key});
  Future<void> _play(CoursePracticeViewModel viewModel) async {
    viewModel.setPlayCount(count: 0);
    await viewModel.playVoicePrompt(viewModel
        .questions[viewModel.currentQuestion]
        .sharedStimulus
        ?.first
        .stimulus
        ?.first
        .value);
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildPlayButton(viewModel);

  Widget _buildPlayButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        onPressed: () async => viewModel.player.state == PlayerState.playing ||
                viewModel.playCount == 0
            ? null
            : await _play(viewModel),
        style: ButtonStyle(
          shape: const WidgetStatePropertyAll(CircleBorder()),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
          shadowColor: WidgetStatePropertyAll(
              viewModel.playCount == 0 ? kcLightGrey : kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(
              viewModel.playCount == 0 ? kcLightGrey : kcPrimaryColor),
        ),
        child: _buildButtonState(viewModel),
      );

  Widget _buildButtonState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? _buildCircularProgressIndicator()
          : viewModel.player.state == PlayerState.playing
              ? _buildPauseIcon()
              : _buildPlayIcon();

  Widget _buildCircularProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow_rounded,
        size: 35,
        color: kcWhite,
      );

  Widget _buildPauseIcon() => const Icon(
        Icons.pause,
        size: 35,
        color: kcWhite,
      );
}

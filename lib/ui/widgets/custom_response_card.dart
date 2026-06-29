import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';

import '../common/enmus.dart';
import 'custom_circular_progress_indicator.dart';

class CustomResponseCard extends ViewModelWidget<CoursePracticeViewModel> {
  final Voice voice;
  final String title;
  final String? response;

  const CustomResponseCard({
    super.key,
    this.response,
    required this.voice,
    required this.title,
  });

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(CoursePracticeViewModel viewModel) => Container(
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        children: [_buildPlayButton(viewModel), _buildColumnWrapper()],
      );

  Widget _buildPlayButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        onPressed: () async => viewModel.player.state == PlayerState.playing
            ? await viewModel.pauseAudio()
            : await viewModel.playResult(voice:voice,response: response),
        child: _buildButtonState(viewModel),
      );

  Widget _buildButtonState(CoursePracticeViewModel viewModel) =>
      viewModel.playing == voice
          ? viewModel.busy(StateObjects.coursePracticeReview)
              ? _buildProgressIndicatorWrapper()
              : viewModel.player.state == PlayerState.playing
                  ? _buildPauseIcon()
                  : _buildPlayIcon()
          : _buildPlayIcon();

  Widget _buildProgressIndicatorWrapper() => Center(
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildPlayIcon() => const Icon(
        Icons.play_arrow_rounded,
        size: 25,
        color: kcWhite,
      );

  Widget _buildPauseIcon() => const Icon(
        Icons.pause,
        size: 25,
        color: kcWhite,
      );

  Widget _buildColumnWrapper() => Expanded(child: _buildTitle());

  Widget _buildTitle() => Text(
        title,
        maxLines: 1,
        softWrap: false,
        style: style12RP600,
      );
}

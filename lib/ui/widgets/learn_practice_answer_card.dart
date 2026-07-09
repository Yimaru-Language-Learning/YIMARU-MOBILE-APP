import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import '../views/learn_practice/learn_practice_viewmodel.dart';

class LearnPracticeAnswerCard extends ViewModelWidget<LearnPracticeViewModel> {
  final Voice voice;
  final String title;
  final Map<String, dynamic> answer;

  const LearnPracticeAnswerCard(
      {super.key,
      required this.voice,
      required this.title,
      required this.answer});

  Widget _getButtonState(LearnPracticeViewModel viewModel) {
    if (answer['busy_object'] == viewModel.busyObject) {
      if (viewModel.playing == voice) {
        if (viewModel.busy(answer['busy_object'])) {
          return _buildProgressIndicatorWrapper();
        } else if (viewModel.player.state == PlayerState.playing) {
          return _buildPauseIcon();
        }
      } else {
        return _buildPlayIcon();
      }

      return _buildPlayIcon();
    } else {
      return _buildPlayIcon();
    }
  }

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnPracticeViewModel viewModel) => Container(
        decoration: BoxDecoration(
          color: kcWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: _buildRow(viewModel),
      );

  Widget _buildRow(LearnPracticeViewModel viewModel) => Row(
        children: [_buildPlayButton(viewModel), _buildColumnWrapper()],
      );

  Widget _buildPlayButton(LearnPracticeViewModel viewModel) => ElevatedButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
          shadowColor: WidgetStatePropertyAll(kcPrimaryColor),
          backgroundColor: WidgetStatePropertyAll(kcPrimaryColor),
        ),
        onPressed: () async => viewModel.player.state == PlayerState.playing
            ? await viewModel.pauseAudio()
            : await viewModel.playResult(answer: answer, voice: voice),
        child: _buildButtonState(viewModel),
      );

  Widget _buildButtonState(LearnPracticeViewModel viewModel) =>
      _getButtonState(viewModel);

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

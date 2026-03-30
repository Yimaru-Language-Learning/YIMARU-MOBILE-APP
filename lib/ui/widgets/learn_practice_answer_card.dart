import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import '../common/ui_helpers.dart';
import '../views/learn_practice/learn_practice_viewmodel.dart';

class LearnPracticeAnswerCard extends ViewModelWidget<LearnPracticeViewModel> {
  final String title;
  final StateObjects object;

  const LearnPracticeAnswerCard(
      {super.key, required this.title, required this.object});

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
            ? viewModel.busyObject == StateObjects.learnPracticeSample
                ? await viewModel.pauseSampleAudio()
                : await viewModel.pauseRecordedAudio()
            : object == StateObjects.learnPracticeSample
                ? await viewModel.playSampleAudio()
                : await viewModel.playRecordedAudio(),
        child: _buildButtonState(viewModel),
      );

  Widget _buildButtonState(LearnPracticeViewModel viewModel) =>
      viewModel.busy(object)
          ? viewModel.busyObject == object
              ? _buildPauseIcon()
              : _buildPlayIcon()
          : viewModel.busyObject == object &&
                  viewModel.player.state == PlayerState.playing
              ? _buildPauseIcon()
              : _buildPlayIcon();

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

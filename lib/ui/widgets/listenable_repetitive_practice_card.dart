import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/helper_functions.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/enmus.dart';
import 'custom_circular_progress_indicator.dart';

class ListenableRepetitivePracticeCard
    extends ViewModelWidget<CoursePracticeViewModel> {
  const ListenableRepetitivePracticeCard({super.key});

  Future<void> _play(CoursePracticeViewModel viewModel) async {
    viewModel.setPlayCount();
    await viewModel.playVoicePrompt(viewModel
            .questions[viewModel.currentQuestion]
            .dynamicPayload
            ?.stimulus
            ?.first
            .value ??
        '');
  }

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildRow(viewModel);

  Widget _buildRow(CoursePracticeViewModel viewModel) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRowChildren(viewModel),
      );

  List<Widget> _buildRowChildren(CoursePracticeViewModel viewModel) => [
        _buildPlayButton(viewModel),
        horizontalSpaceSmall,
        _buildColumnWrapper(viewModel)
      ];

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

  Widget _buildColumnWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildColumn(viewModel));

  Widget _buildColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildLinearProgressIndicator(viewModel),
        verticalSpaceTiny,
        _buildTitle(viewModel),
        _buildSubtitle(viewModel)
      ];

  Widget _buildLinearProgressIndicator(CoursePracticeViewModel viewModel) =>
      CustomLinearProgressIndicator(
          activeColor: kcPrimaryColor,
          progress: viewModel.progress,
          backgroundColor: kcVeryLightGrey);

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        getSecondsToMinutes(viewModel.duration.inSeconds),
        style: style14MG400,
      );

  Widget _buildSubtitle(CoursePracticeViewModel viewModel) => Text(
        '${viewModel.playCount} reply left',
        style: style14P400,
      );
}

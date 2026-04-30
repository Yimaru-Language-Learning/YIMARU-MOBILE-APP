import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/cancel_learn_practice_sheet.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';
import 'package:yimaru_app/ui/widgets/wave_wrapper.dart';

import '../../../../models/learn_question.dart';
import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_column_button.dart';
import '../../../widgets/small_app_bar.dart';

class InteractLearnPracticeScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  final int index;
  final LearnQuestion question;

  const InteractLearnPracticeScreen(
      {super.key, required this.index, required this.question});

  Future<void> _cancel(LearnPracticeViewModel viewModel) async {
    viewModel.pop();
    viewModel.pop();
    viewModel.stopRecording();
  }

  void _reply(LearnPracticeViewModel viewModel) =>
      viewModel.replayVoicePrompt(question);

  Future<void> _stop(LearnPracticeViewModel viewModel) async =>
      await viewModel.nextQuestion(index: index, question: question);

  Future<void> _showSheet(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SafeArea(child: _buildBodyStack(context: context, viewModel: viewModel));

  Widget _buildBodyStack(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildBodyColumnWrapper(context: context, viewModel: viewModel),
          _buildProgressIndicatorState(viewModel),
        ],
      );

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SmallAppBar(
          showBackButton: true,
          onPop: () async =>
              await _showSheet(context: context, viewModel: viewModel),
          title: 'Practice Speaking ($index/${viewModel.questions.length})');

  Widget _buildSpeakingIndicatorWrapper(LearnPracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildSpeakerLabelState(viewModel),
        verticalSpaceMedium,
        _buildSpeakingIndicator(viewModel)
      ];

  Widget _buildSpeakerLabelState(LearnPracticeViewModel viewModel) =>
      viewModel.player.state == PlayerState.playing
          ? _buildListeningLabel()
          : VoiceRecordingState.recording == viewModel.recordingState
              ? viewModel.busy(StateObjects.finishLearnPracticeQuestion)
                  ? const SizedBox(height: 20)
                  : _buildSpeakingLabel()
              : const SizedBox(height: 20);

  Widget _buildListeningLabel() => Text(
        'Daniel is speaking...',
        style: style14P400,
        textAlign: TextAlign.center,
      );

  Widget _buildSpeakingLabel() => Text(
        'You\'re speaking...',
        style: style14P400,
        textAlign: TextAlign.center,
      );

  Widget _buildSpeakingIndicator(LearnPracticeViewModel viewModel) =>
      WaveWrapper(height: 200, child: _buildSpinnerState(viewModel));

  Widget _buildSpinnerState(LearnPracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.recordLearnPracticeAnswer) ||
              viewModel.busy(StateObjects.finishLearnPracticeQuestion)
          ? Container()
          : viewModel.player.state == PlayerState.playing
              ? _buildSpinner()
          : VoiceRecordingState.recording == viewModel.recordingState &&
                  viewModel.waveController.isRecording
              ? _buildSpeakingSpinnerColumn(viewModel)
              : Container();

  Widget _buildSpeakingSpinnerColumn(LearnPracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildSpeakingSpinnerColumnChildren(viewModel),
      );

  List<Widget> _buildSpeakingSpinnerColumnChildren(
          LearnPracticeViewModel viewModel) =>
      [_buildSpinner(), _buildSpeakingSpinnerContainer(viewModel)];

  Widget _buildSpeakingSpinnerContainer(LearnPracticeViewModel viewModel) =>
      SizedBox(
        width: 65,
        child: _buildSpeakingSpinner(viewModel),
      );

  Widget _buildSpeakingSpinner(LearnPracticeViewModel viewModel) =>
      WaveformRecorder(
        height: 35,
        waveColor: kcPrimaryColor,
        durationTextStyle: style14P600,
        controller: viewModel.waveController,
      );

  Widget _buildSpinner() => const SpinKitWave(
        size: 20,
        color: kcPrimaryColor,
        type: SpinKitWaveType.center,
      );

  Widget _buildLowerButtonsSectionWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child:
            _buildLowerButtonsSection(context: context, viewModel: viewModel),
      );

  Widget _buildLowerButtonsSection(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildActionLabel(),
        verticalSpaceMedium,
        _buildButtonRowContainer(context: context, viewModel: viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildActionLabel() => Text(
        'Tap the microphone to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildButtonRowContainer(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      SizedBox(
        height: 75,
        width: double.maxFinite,
        child: _buildButtonRowState(context: context, viewModel: viewModel),
      );

  Widget _buildButtonRowState(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      viewModel.busy(StateObjects.learnPracticeQuestion) ||
              viewModel.busy(StateObjects.finishLearnPracticeQuestion)
          ? _buildProgressIndicator(kcPrimaryColor)
          : _buildButtonsRowWrapper(context: context, viewModel: viewModel);

  Widget _buildProgressIndicator(Color color) => Center(
        child: CustomCircularProgressIndicator(color: color),
      );

  Widget _buildButtonsRowWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildButtonsRowChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildButtonsRowChildren(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      [
        _buildReplyButtonWrapper(viewModel),
        _buildMicButtonWrapper(viewModel),
        _buildCancelButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildReplyButtonWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildReplyButton(viewModel));

  Widget _buildReplyButton(LearnPracticeViewModel viewModel) =>
      CustomColumnButton(
        icon: Icons.replay,
        label: 'Reply',
        color: viewModel.recordingState == VoiceRecordingState.pending &&
                viewModel.player.state != PlayerState.playing
            ? kcPrimaryColor
            : kcLightGrey,
        onTap: viewModel.recordingState == VoiceRecordingState.pending &&
                viewModel.player.state != PlayerState.playing
            ? () => _reply(viewModel)
            : null,
      );

  Widget _buildMicButtonWrapper(LearnPracticeViewModel viewModel) =>
      Expanded(child: _buildMicButtonState(viewModel));

  Widget _buildMicButtonState(LearnPracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.recordLearnPracticeAnswer)
          ? _buildProgressIndicator(kcPrimaryColor)
          : _buildMicButton(viewModel);

  Widget _buildMicButton(LearnPracticeViewModel viewModel) => ElevatedButton(
        style: ButtonStyle(
          shadowColor: const WidgetStatePropertyAll(kcWhite),
          shape: const WidgetStatePropertyAll(CircleBorder()),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(15)),
          backgroundColor: WidgetStatePropertyAll(
            viewModel.player.state == PlayerState.playing ||
                    viewModel.busy(StateObjects.recordLearnPracticeAnswer)
                ? kcVeryLightGrey
                : kcPrimaryColor,
          ),
        ),
        onPressed: () async => viewModel.player.state == PlayerState.playing ||
                viewModel.busy(StateObjects.recordLearnPracticeAnswer)
            ? null
            : viewModel.recordingState == VoiceRecordingState.pending
                ? await viewModel.startRecording()
                : await _stop(viewModel),
        child: _buildMicState(viewModel),
      );

  Widget _buildMicState(LearnPracticeViewModel viewModel) =>
      viewModel.recordingState == VoiceRecordingState.pending
          ? _buildMicIcon()
          : _buildCheckIcon();

  Widget _buildCheckIcon() => const Icon(
        Icons.check,
        size: 35,
        color: kcWhite,
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 35,
        color: kcWhite,
      );

  Widget _buildCancelButtonWrapper(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      Expanded(
          child: _buildCancelButton(context: context, viewModel: viewModel));

  Widget _buildCancelButton(
          {required BuildContext context,
          required LearnPracticeViewModel viewModel}) =>
      CustomColumnButton(
        color: kcRed,
        label: 'Cancel',
        icon: Icons.close,
        onTap: () async =>
            await _showSheet(context: context, viewModel: viewModel),
      );

  Widget _buildSheet(LearnPracticeViewModel viewModel) =>
      CancelLearnPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildProgressIndicatorState(LearnPracticeViewModel viewModel) =>
      viewModel.recordingState == VoiceRecordingState.pending
          ? viewModel.busy(StateObjects.finishLearnPracticeQuestion) ||
                  viewModel.busy(StateObjects.learnPracticeQuestion) ||
                  viewModel.busy(StateObjects.recordLearnPracticeAnswer)
              ? Container()
              : _buildProgressIndicatorWrapper(viewModel)
          : Container();

  Widget _buildProgressIndicatorWrapper(LearnPracticeViewModel viewModel) =>
      Positioned(
        top: 75,
        left: 0,
        right: 0,
        child: _buildProgressIndicatorSpacer(viewModel),
      );

  Widget _buildProgressIndicatorSpacer(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLinearProgressIndicator(viewModel),
      );

  Widget _buildLinearProgressIndicator(LearnPracticeViewModel viewModel) =>
      CustomLinearProgressIndicator(
          activeColor: kcPrimaryColor,
          progress: viewModel.progress,
          backgroundColor: kcVeryLightGrey);
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/ui/widgets/wave_wrapper.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../../../widgets/speaking_label.dart';
import '../course_practice_viewmodel.dart';

class DuolingoSpeakingPractice4Answer
    extends ViewModelWidget<CoursePracticeViewModel> {
  final int duration;
  final String audio;
  final String response;

  const DuolingoSpeakingPractice4Answer(
      {super.key,
      required this.audio,
      required this.response,
      required this.duration});

  Future<void> _startRecording(CoursePracticeViewModel viewModel) async {
    viewModel.setCountdown(duration);
    await viewModel.startRecording();
  }

  Future<void> _stopRecording(CoursePracticeViewModel viewModel) async {
    await viewModel.setSpeakingAnswer4(
      audio: audio,
      sample: response,
      duration: duration,
    );
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.pop();
    viewModel.goBack();
  }

  Future<void> _showSheet(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) async =>
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: kcTransparent,
        builder: (cxt) => _buildSheet(viewModel),
      );

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldStack(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Stack(
        children: [
          _buildScaffold(context: context, viewModel: viewModel),
          _buildBodyState(viewModel)
        ],
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SafeArea(
          child:
              _buildBodyColumnWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyColumnWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(context: context, viewModel: viewModel),
      );

  Widget _buildBodyColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildAnswerSectionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdownState(viewModel));

  Widget _buildCountdownState(CoursePracticeViewModel viewModel) =>
      VoiceRecordingState.recording == viewModel.recordingState
          ? _buildCountdown(viewModel)
          : Container();

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        onEnd: () async => await _stopRecording(viewModel),
      );

  Widget _buildAnswerSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildAnswerSectionChildren(viewModel),
      );

  List<Widget> _buildAnswerSectionChildren(CoursePracticeViewModel viewModel) =>
      [
        if (VoiceRecordingState.recording != viewModel.recordingState)
          _buildDwarf(),
        _buildSpeakerLabelState(viewModel),
        verticalSpaceSmall,
        _buildSpeakingIndicatorState(viewModel),
        verticalSpaceMedium,
        _buildActionLabelState(viewModel),
        verticalSpaceMedium,
        _buildMicButtonWrapper(viewModel)
      ];

  Widget _buildDwarf() => Image.asset('assets/icons/dwarf.png');

  Widget _buildActionLabelState(CoursePracticeViewModel viewModel) =>
      VoiceRecordingState.recording == viewModel.recordingState ||
              viewModel.showAnswer
          ? _buildResponseLabel()
          : _buildActionLabel();

  Widget _buildResponseLabel() => Text(
        'Thank you for the response',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildActionLabel() => Text(
        'Tap the microphone to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildSpeakerLabelState(CoursePracticeViewModel viewModel) =>
      VoiceRecordingState.recording == viewModel.recordingState
          ? _buildSpeakerLabel()
          : const SizedBox(height: 20);

  Widget _buildSpeakerLabel() =>
      const SpeakingLabel(label: 'You are speaking...');

  Widget _buildSpeakingIndicatorState(CoursePracticeViewModel viewModel) =>
      VoiceRecordingState.recording == viewModel.recordingState
          ? _buildSpeakingIndicatorWrapper(viewModel)
          : Container();

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Container(
        width: 100,
        padding: const EdgeInsets.only(right: 15),
        child: _buildSpeakingIndicator(viewModel),
      );

  Widget _buildSpeakingIndicator(CoursePracticeViewModel viewModel) =>
      WaveformRecorder(
        height: 35,
        waveColor: kcPrimaryColor,
        durationTextStyle: style0Ts,
        controller: viewModel.waveController,
      );

  Widget _buildMicButtonWrapper(CoursePracticeViewModel viewModel) =>
      WaveWrapper(height: 125, child: _buildMicButton(viewModel));

  Widget _buildMicButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        style: ButtonStyle(
          shadowColor: const WidgetStatePropertyAll(kcWhite),
          shape: const WidgetStatePropertyAll(CircleBorder()),
          padding: const WidgetStatePropertyAll(EdgeInsets.all(15)),
          backgroundColor: WidgetStatePropertyAll(
            viewModel.showAnswer ||
                    VoiceRecordingState.recording == viewModel.recordingState ||
                    viewModel.busy(StateObjects.recordCoursePracticeAnswer)
                ? kcPrimaryColor.withValues(alpha: 0.5)
                : kcPrimaryColor,
          ),
        ),
        onPressed: () async => viewModel.showAnswer ||
                VoiceRecordingState.recording == viewModel.recordingState ||
                viewModel.busy(StateObjects.recordCoursePracticeAnswer)
            ? null
            : await _startRecording(viewModel),
        child: _buildMicIcon(),
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 50,
        color: kcWhite,
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _stopRecording(viewModel),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.speaking4Variant)
          ? const PageLoadingIndicator()
          : Container();
}

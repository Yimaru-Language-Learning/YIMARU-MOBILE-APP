import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/ui/widgets/wave_wrapper.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/circular_countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../../../widgets/speaking_label.dart';
import '../course_practice_viewmodel.dart';

class IeltsSpeakingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice2Question({super.key});

  Future<void> _startRecording(CoursePracticeViewModel viewModel) async {
    int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
        .dynamicPayload?.response?.first.value['seconds'];
    await viewModel.startRecording();
    viewModel.nextScreen();
    viewModel.setCountdown(responseFirstSec);
  }

  Future<void> _stopRecording(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.nextScreen();
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
        body: _buildScaffold(context: context, viewModel: viewModel),
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
        children:
            _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        _buildAppBarWrapper(context: context, viewModel: viewModel),
        _buildAnswerSectionWrapper(viewModel),
        verticalSpaceMassive
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
          verticalSpaceMedium,
          _buildTitle(),
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

  Widget _buildTitle() => Text(
        'Part 1: Cue Card',
        style: style18DG700,
        textAlign: TextAlign.center,
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
        _buildQuestion(viewModel),
        verticalSpaceLarge,
        _buildTimerStackWrapper(viewModel),
        verticalSpaceSmall,
        _buildSubtitle(),
        verticalSpaceLarge,
        _buildActionLabel(),
        verticalSpaceMedium,
        _buildMicButton(viewModel)
      ];

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeQuestionCard(
        title: '',
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value,
      );

  Widget _buildTimerStackWrapper(CoursePracticeViewModel viewModel) =>
      CircularCountdownTimer(
        onEnd: () async => await _startRecording(viewModel),
      );

  Widget _buildSubtitle() => Text(
        'Prep time',
        style: style16DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildActionLabel() => Text(
        'Tap the microphone to speak',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildMicButton(CoursePracticeViewModel viewModel) => ElevatedButton(
        style: const ButtonStyle(
          shadowColor: WidgetStatePropertyAll(kcWhite),
          shape: WidgetStatePropertyAll(CircleBorder()),
          padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
          backgroundColor: WidgetStatePropertyAll(
            kcPrimaryColor,
          ),
        ),
        onPressed: () async => await _startRecording(viewModel),
        child: _buildMicIcon(),
      );

  Widget _buildMicIcon() => const Icon(
        Icons.mic,
        size: 50,
        color: kcWhite,
      );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:waveform_recorder/waveform_recorder.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/countdown_timer.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/speaking_label.dart';
import '../../course_practice_viewmodel.dart';

class IeltsSpeakingPractice3Answer
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice3Answer({super.key});

  Future<void> _stopRecording(CoursePracticeViewModel viewModel) async =>
      await viewModel.setSpeakingAnswer(
        number: '1',
        sample: viewModel.questions[viewModel.currentQuestion].dynamicPayload
                ?.response?.last.value ??
            '',
      );
  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    // viewModel.resetValues();

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
        resizeToAvoidBottomInset: true,
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
            '${LocaleKeys.speaking_practice.tr()} (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.part2_follow_up.tr(),
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
        _buildSpeakerLabelState(viewModel),
        verticalSpaceSmall,
        _buildSpeakingIndicatorState(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildSpeakerLabelState(CoursePracticeViewModel viewModel) =>
      VoiceRecordingState.recording == viewModel.recordingState
          ? _buildSpeakerLabel()
          : const SizedBox(height: 20);

  Widget _buildSpeakerLabel() =>
       SpeakingLabel(label: LocaleKeys.you_are_speaking_status.tr());

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

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: LocaleKeys.submit.tr(),
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _stopRecording(viewModel),
      );
}

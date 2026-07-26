import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/course_practice_app_bar.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/custom_circular_progress_indicator.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/page_loading_indicator.dart';
import '../../course_practice_viewmodel.dart';

class IeltsIntroScreen extends ViewModelWidget<CoursePracticeViewModel> {
  final String title;
  final String subtitle;
  final String instructionTitle;
  final String instructionSubtitle;
  final TextEditingController practiceController;

  const IeltsIntroScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.instructionTitle,
    required this.practiceController,
    required this.instructionSubtitle,
  });

  Future<void> _nextScreen(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    viewModel.resetValues();
    practiceController.clear();

    int id = viewModel
            .questions[viewModel.currentQuestion].questionTypeDefinitionId ??
        0;
    if (id == 17 /*IELTS Speaking – Interview*/) {
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 18 /*IELTS Speaking – Cue Card Part 1*/) {
      int stimulusFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value['seconds'];
      viewModel.setCountdown(stimulusFirstSec);
    } else if (id == 20 /*IELTS Speaking – Cue Card Part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 21 /*IELTS Speaking – Discussion*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String stimulus = viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value ??
          '';
      viewModel.setSpeakingState();
      viewModel.setCountdown(responseFirstSec);
      await viewModel.playVoicePrompt(stimulus);
    } else if (id == 26 /*IELTS Writing – Part 1*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      String image = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.stimulus?.first.value;
      await viewModel.cacheNetworkImage(image: image, context: context);
      viewModel.setCountdown(responseFirstSec);
    } else if (id == 27 /*IELTS Writing – Part 2*/) {
      int responseFirstSec = viewModel.questions[viewModel.currentQuestion]
          .dynamicPayload?.response?.first.value['seconds'];
      viewModel.setCountdown(responseFirstSec);
    }
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
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildContinueButtonWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceMedium,
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

  Widget _buildSpeakingIndicatorWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(),
      );

  List<Widget> _buildSpeakingIndicatorChildren() => [
        _buildTitle(),
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildInstructionTitle(),
        _buildInstructionSubtitle()
      ];

  Widget _buildTitle() => Text(
        title,
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        subtitle,
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildInstructionTitle() => Text(
        instructionTitle,
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildInstructionSubtitle() => Text(
        instructionSubtitle,
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
            _buildContinueButtonState(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonState(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      viewModel.busy(StateObjects.cacheImage)
          ? const CustomCircularProgressIndicator(color: kcPrimaryColor)
          : _buildContinueButton(context: context, viewModel: viewModel);

  Widget _buildContinueButton(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async =>
            await _nextScreen(context: context, viewModel: viewModel),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : Container();
}

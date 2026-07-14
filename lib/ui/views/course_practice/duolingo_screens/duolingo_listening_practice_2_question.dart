import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/listenable_repetitive_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/custom_circular_progress_indicator.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoListeningPractice2Question({super.key});

  Future<void> _next(CoursePracticeViewModel viewModel) async {
    await viewModel.stopAudio();
    for (int i = 0; i < 3; i++) {
      await viewModel.setListeningAnswer(
        response: viewModel.controllers['$i'] ?? '',
        sample: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[i + 1].value,
      );
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
        _buildQuestionWrapper(viewModel),
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBarIndenter(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBarIndenter(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBar(context: context, viewModel: viewModel),
      );

  Widget _buildAppBar(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CoursePracticeAppBar(
        onClose: () async =>
            await _showSheet(context: context, viewModel: viewModel),
        title:
            'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        onEnd: () async => await _next(viewModel),
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildLabel(
          viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?[1].value),
        verticalSpaceTiny,
        _buildTextField(value: '0', viewModel: viewModel),
        verticalSpaceMedium,
        _buildLabel(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?[2].value),
        verticalSpaceTiny,
        _buildTextField(value: '1', viewModel: viewModel),
        verticalSpaceMedium,
        _buildLabel(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus?[3].value),
        verticalSpaceTiny,
        _buildTextField(value: '2', viewModel: viewModel),
        verticalSpaceSmall,
      ];

  Widget _buildTitle() => Text(
        'Listen to the audio message and type your response.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      ListenableRepetitivePracticeCard(
          question: viewModel.questions[viewModel.currentQuestion]
                  .dynamicPayload?.stimulus?.first.value ??
              '');

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildTextField(
          {required String value,
          required CoursePracticeViewModel viewModel}) =>
      TextField(
        style: style14MG400,
        decoration: inputDecoration(
            focus: true, filled: true, hint: 'Start writing here...'),
        onChanged: (change) => viewModel.updateAnswer(value, change),
      );

  Widget _buildContinueButtonWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButtonState(viewModel),
      );

  Widget _buildContinueButtonState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.stopAudio)
          ? _buildProgressIndicatorWrapper()
          : _buildContinueButton(viewModel);

  Widget _buildProgressIndicatorWrapper() => SizedBox(
        height: 55,
        child: _buildProgressIndicator(),
      );

  Widget _buildProgressIndicator() =>
      const CustomCircularProgressIndicator(color: kcPrimaryColor);

  Widget _buildContinueButton(CoursePracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(viewModel),
      );
}

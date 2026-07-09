import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/paragraph_option_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/countdown_timer.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../course_practice_viewmodel.dart';

class IeltsReadingPractice1Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsReadingPractice1Question({super.key});

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
        _buildQuestionExpandedWrapper(viewModel),
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
            'Reading practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildCountdownWrapper(CoursePracticeViewModel viewModel) => Align(
      alignment: Alignment.centerRight, child: _buildCountdown(viewModel));

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        onEnd: viewModel.nextScreen,
        duration: viewModel.countdown,
      );

  Widget _buildTitle() => Text(
        'Paragraph Choice',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionScrollerWrapper(viewModel));

  Widget _buildQuestionScrollerWrapper(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildQuestionWrapper(viewModel));

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildInstruction(viewModel),
        verticalSpaceMedium,
        _buildQuestion1(viewModel),
        verticalSpaceMedium,
        _buildQuestion2(viewModel),
        verticalSpaceMedium,
        _buildQuestion3(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonWrapper(viewModel)
      ];

  Widget _buildInstruction(CoursePracticeViewModel viewModel) => Text(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus
            ?.first.value,
        style: style14MG400,
      );

  Widget _buildQuestion1(CoursePracticeViewModel viewModel) =>
      ParagraphOptionCard(
        number: '1',
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[1].value['options'],
      );

  Widget _buildQuestion2(CoursePracticeViewModel viewModel) =>
      ParagraphOptionCard(
        number: '2',
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[2].value['options'],
      );

  Widget _buildQuestion3(CoursePracticeViewModel viewModel) =>
      ParagraphOptionCard(
        number: '3',
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?[3].value['options'],
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
        onTap: () async => await viewModel.nextQuestion(),
      );
}

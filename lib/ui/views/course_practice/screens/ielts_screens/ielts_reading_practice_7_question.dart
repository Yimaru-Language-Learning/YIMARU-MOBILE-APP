import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/true_false_option_card.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/countdown_timer.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/ielts_practice_review_section.dart';
import '../../../../widgets/page_loading_indicator.dart';
import '../../course_practice_viewmodel.dart';

class IeltsReadingPractice7Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsReadingPractice7Question({super.key});


  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }

  Future<void> _nextScreen(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.showAnswer) {
      viewModel.clearAnswer();
      if (viewModel.currentQuestion == viewModel.questions.length - 1) {
        viewModel.setSectionEnd(true);
        viewModel.pop();
      } else {
        if (viewModel.questions[viewModel.currentQuestion + 1].stimulusBlockKey ==
            null) {
          viewModel.setSectionEnd(true);
          viewModel.nextScreen();
        } else {
          viewModel.nextQuestion(context);
        }
      }
    } else {
      _setShowAnswer(viewModel);
      for (int i = 0; i < 3; i++) {
        await viewModel.setListeningAnswer(
          sample: (viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.response?[i+1].value['options'] as List)
              .firstWhere((e) =>
          e['is_correct'])['text'],
        );
      }
    }
  }


  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
  //  viewModel.resetValues();
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
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
      ];

  Widget _buildAppBarWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildCountdownWrapper(context: context, viewModel: viewModel),
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
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Yes / No / Not Given',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildCountdownWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Align(
          alignment: Alignment.centerRight,
          child: _buildCountdownState(context: context, viewModel: viewModel));

  Widget _buildCountdownState(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      viewModel.busy(StateObjects.coursePractice)
          ? const CountdownTimer(time: '00:00')
          : _buildCountdown(context: context, viewModel: viewModel);

  Widget _buildCountdown(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      CountdownTimer(
        duration: viewModel.countdown,
        key: ValueKey(viewModel.countdown),
        onEnd: () => _nextScreen(context: context, viewModel: viewModel),
      );

  Widget _buildQuestionExpandedWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
          child: _buildQuestionScrollerWrapper(
              context: context, viewModel: viewModel));

  Widget _buildQuestionScrollerWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
          child: _buildQuestionColumn(context: context, viewModel: viewModel));

  Widget _buildQuestionColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildQuestionColumnChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionColumnChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceSmall,
        _buildQuestionContainerWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButtonState(context: context, viewModel: viewModel),
      ];

  Widget _buildQuestionContainerWrapper(CoursePracticeViewModel viewModel) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kcDarkGrey.withValues(alpha: 0.1)),
        ),
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        verticalSpaceMedium,
        _buildInstructionWrapper(viewModel),
        verticalSpaceMedium,
        _buildQuestion1(viewModel),
        verticalSpaceSmall,
        _buildQuestion2(viewModel),
        verticalSpaceSmall,
        _buildQuestion3(viewModel),
        verticalSpaceSmall,
      ];

  Widget _buildInstructionWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildInstruction(viewModel),
      );

  Widget _buildInstruction(CoursePracticeViewModel viewModel) => Text(
        viewModel.questions[viewModel.currentQuestion].dynamicPayload?.stimulus
            ?.first.value,
        textAlign: TextAlign.start,
        style: style14MG400,
      );

  Widget _buildQuestion1(CoursePracticeViewModel viewModel) =>
      TrueFalseOptionCard(
        number: '1',
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?.last.value['options'] as List,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[1].value,
      );

  Widget _buildQuestion2(CoursePracticeViewModel viewModel) =>
      TrueFalseOptionCard(
        number: '2',
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?.last.value['options'] as List,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[2].value,
      );

  Widget _buildQuestion3(CoursePracticeViewModel viewModel) =>
      TrueFalseOptionCard(
        number: '3',
        choice: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?.last.value['options'] as List,
        question: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?[3].value,
      );

  Widget _buildContinueButtonState(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      viewModel.showAnswer
          ? _buildReviewSection(context: context,viewModel: viewModel)
          : _buildContinueButtonWrapper(context: context, viewModel: viewModel);

  Widget _buildReviewSection(       {required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      IeltsPracticeReviewSection(review: viewModel.answers,onTap: ()async =>await  _nextScreen(context: context, viewModel: viewModel),);

  Widget _buildContinueButtonWrapper(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButton(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      CustomElevatedButton(
        height: 55,
        text: 'Submit',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: ()async =>await  _nextScreen(context: context, viewModel: viewModel),
      );

  Widget _buildBodyState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.coursePracticePrompt)
          ? const PageLoadingIndicator()
          : Container();
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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

class IeltsListeningPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsListeningPractice2Question({super.key});

  void _reset(CoursePracticeViewModel viewModel) {
   // viewModel.resetValues();
  }

  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }


  Future<void> _nextScreen(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) async{
    FocusManager.instance.primaryFocus?.unfocus();
    _reset(viewModel);

    if (viewModel.showAnswer) {
      viewModel.clearAnswer();
      if (viewModel.currentQuestion == viewModel.questions.length - 1) {
        viewModel.setSectionEnd(true);
        viewModel.nextScreen();
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
      for (int i = 0; i < 4; i++) {
        await viewModel.setListeningAnswer(
          sample: viewModel.questions[viewModel.currentQuestion].dynamicPayload
              ?.response?[i + 1].value,
        );
      }
    }
  }

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    _reset(viewModel);
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
            'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Note Completion',
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
        onEnd: ()async =>await _nextScreen(context: context, viewModel: viewModel),
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
          child: _buildQuestionWrapper(context: context, viewModel: viewModel));

  Widget _buildQuestionWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _buildQuestionChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceMedium,
        _buildInstruction(),
        verticalSpaceMedium,
        _buildLabel(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[0].value),
        verticalSpaceTiny,
        _buildTextField(value: '0', viewModel: viewModel),
        verticalSpaceMedium,
        _buildLabel(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[1].value),
        verticalSpaceTiny,
        _buildTextField(value: '1', viewModel: viewModel),
        verticalSpaceMedium,
        _buildLabel(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[2].value),
        verticalSpaceTiny,
        _buildTextField(value: '2', viewModel: viewModel),
        verticalSpaceMedium,
        _buildLabel(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[3].value),
        verticalSpaceTiny,
        _buildTextField(value: '3', viewModel: viewModel),
        verticalSpaceLarge,
        _buildContinueButtonState(context: context, viewModel: viewModel)
      ];

  Widget _buildInstruction() => Text(
        'Complete the following note',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

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

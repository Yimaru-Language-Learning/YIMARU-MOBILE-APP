import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/course_missing_word_question.dart';
import 'package:yimaru_app/ui/widgets/duolingo_fill_in_the_blank_question.dart';
import 'package:yimaru_app/ui/widgets/ielts_fill_in_the_blanks_question.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/enmus.dart';
import '../../../../common/ui_helpers.dart';
import '../../../../widgets/cancel_practice_sheet.dart';
import '../../../../widgets/countdown_timer.dart';
import '../../../../widgets/course_practice_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/duolingo_practice_review_section.dart';
import '../../../../widgets/reading_practice_option_card.dart';
import '../../course_practice_viewmodel.dart';

class DuolingoReadingPractice2Question
    extends ViewModelWidget<CoursePracticeViewModel> {
  final int duration;
  final List options;
  final List response;

  final dynamic question;

  const DuolingoReadingPractice2Question({
    super.key,
    required this.options,
    required this.question,
    required this.duration,
    required this.response,
  });

  void _setShowAnswer(CoursePracticeViewModel viewModel) {
    viewModel.setShowAnswer();
  }

  Future<void> _next(
      {required BuildContext context,
      required CoursePracticeViewModel viewModel}) async {
    if (viewModel.showAnswer) {
      await viewModel.setReadingAnswer2(
        duration: duration,
        question: question,
        sample: response.first['text'],
        answer: viewModel.selectedOption.toString(),
      );
    } else {
      _setShowAnswer(viewModel);
    }
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
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

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
        _buildAppBarPaddingWrapper(context: context, viewModel: viewModel),
        _buildQuestionExpandedWrapper(context: context, viewModel: viewModel),
        if (viewModel.showAnswer)
          _buildContainerWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildAppBarPaddingWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(context: context, viewModel: viewModel),
      );

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
            'Reading practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
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
      viewModel.busy(StateObjects.reading8Variant)
          ? const CountdownTimer(time: '00:00')
          : _buildCountdown(viewModel);

  Widget _buildCountdown(CoursePracticeViewModel viewModel) => CountdownTimer(
        duration: viewModel.countdown,
        key: ValueKey(viewModel.countdown),
        onEnd: () => _setShowAnswer(viewModel),
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
          child: _buildQuestionPaddingWrapper(
              context: context, viewModel: viewModel));

  Widget _buildQuestionPaddingWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionWrapper(context: context, viewModel: viewModel),
      );

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
        _buildTitle(viewModel),
        verticalSpaceSmall,
        _buildQuestion(viewModel),
        verticalSpaceMedium,
        _buildPracticeOptions(viewModel),
        verticalSpaceLarge,
        if (!viewModel.showAnswer)
          _buildContainerWrapper(context: context, viewModel: viewModel)
      ];

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Complete the sentence with correct word',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      DuolingoFillInTheBlankQuestion(
        showNumber: true,
        segment: question,
        blanks: response.first['text'].toString().length,
      );

  Widget _buildPracticeOptions(CoursePracticeViewModel viewModel) =>
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: response.length,
        itemBuilder: (context, index) => _buildPracticeCard(
          index,
        ),
      );

  Widget _buildPracticeCard(int index) => ReadingPracticeOptionCard(
        enabled: true,
        options: options,
        number: (index + 1).toString(),
      );

  Widget _buildContainerWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Container(
        width: double.maxFinite,
        color: viewModel.showAnswer
            ? kcDeepGreen.withValues(alpha: 0.1)
            : kcTransparent,
        padding:
            EdgeInsets.symmetric(horizontal: viewModel.showAnswer ? 15 : 0),
        child:
            _buildContinueButtonWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child:
            _buildContinueButtonColumn(context: context, viewModel: viewModel),
      );

  Widget _buildContinueButtonColumn(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildContinueButtonChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildContinueButtonChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceSmall,
        if (viewModel.showAnswer) _buildCorrectAnswer(),
        verticalSpaceSmall,
        _buildContinueButton(context: context, viewModel: viewModel)
      ];

  Widget _buildCorrectAnswer() => Text(
        'Correct Answer: ${response.first['text']} ',
        style: style16DG400,
        textAlign: TextAlign.center,
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
        onTap: () async => await _next(context: context, viewModel: viewModel),
      );
}

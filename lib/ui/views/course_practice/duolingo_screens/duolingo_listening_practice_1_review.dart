import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';
import 'package:yimaru_app/ui/widgets/listenable_review_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../../../widgets/listenable_repetitive_practice_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice1Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoListeningPractice1Review(
      {super.key, required this.practiceController});

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
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarIndenter(
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

  Widget _buildExpandedBody(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionSectionWrapper(viewModel),
      );

  Widget _buildQuestionSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionQuestionSectionChildren(viewModel),
      );

  List<Widget> _buildQuestionQuestionSectionChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '1', question: viewModel.answers[0]['question']),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '2', question: viewModel.answers[1]['question']),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '3', question: viewModel.answers[2]['question']),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '4', question: viewModel.answers[3]['question']),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '5', question: viewModel.answers[4]['question']),
        verticalSpaceLarge,
        _buildLabelWrapper(),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '1', answer: viewModel.answers[0]['response']),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '2', answer: viewModel.answers[1]['response']),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '3', answer: viewModel.answers[2]['response']),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '4', answer: viewModel.answers[3]['response']),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '5', answer: viewModel.answers[4]['response']),
        verticalSpaceMedium,
        _buildPracticeReviewSection(viewModel)
      ];

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        'Type what you hear',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionRowWrapper(
          {required String question, required String number}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionRow(question: question, number: number),
      );

  Widget _buildQuestionRow(
          {required String question, required String number}) =>
      Row(
        children: [
          _buildQuestionNumber(number),
          horizontalSpaceSmall,
          _buildQuestionWrapper(number: number,question: question)
        ],
      );

  Widget _buildQuestionNumber(String number) => Text(
        '$number.',
        style: style16DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionWrapper(
          {required String question, required String number}) =>
      Expanded(
        child: _buildQuestion(number: number, question: question),
      );

  Widget _buildQuestion({required String question, required String number}) =>
      ListenableReviewPracticeCard(
        audio: question,
        busyObject: number,
      );

  Widget _buildLabelWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLabel(),
      );

  Widget _buildLabel() => Text(
        'Your Answer',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildPracticeResponsesWrapper({
    required String number,
    required String answer,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeResponses(number: number, answer: answer),
      );

  Widget _buildPracticeResponses({
    required String number,
    required String answer,
  }) =>
      CoursePracticeQuestionCard(
        subtitle: '$number. $answer',
      );

  Widget _buildPracticeReviewSection(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeReviewSection(
        review: viewModel.answers,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(),
      );
}

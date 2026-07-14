import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoReadingPractice7Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoReadingPractice7Review({super.key});

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
        _buildExpandedBody(context: context, viewModel: viewModel),
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
            'Reading practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildExpandedBody(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Expanded(
          child: _buildBodyScroller(context: context, viewModel: viewModel));

  Widget _buildBodyScroller(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildQuestionSectionWrapper(
            context: context, viewModel: viewModel),
      );

  Widget _buildQuestionSectionWrapper(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionQuestionSectionChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildQuestionQuestionSectionChildren(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      [
        verticalSpaceLarge,
        _buildTitleWrapper(viewModel),
        verticalSpaceMedium,
        _buildQuestionWrapper(
            '1. ${viewModel.answers.elementAt(0)['question']}'),
        verticalSpaceTiny,
        _buildAnswerWrapper(
          start: viewModel.answers
              .elementAt(0)['question']
              .substring(0, viewModel.answers.elementAt(0)['response_start']),
          middle: viewModel.answers.elementAt(0)['question'].substring(
              viewModel.answers.elementAt(0)['response_start'],
              viewModel.answers.elementAt(0)['response_end']),
          end: viewModel.answers
              .elementAt(0)['question']
              .substring(viewModel.answers.elementAt(0)['response_end']),
        ),
        verticalSpaceMedium,
        _buildQuestionWrapper(
            '2. ${viewModel.answers.elementAt(1)['question']}'),
        verticalSpaceTiny,
        _buildAnswerWrapper(
          start: viewModel.answers
              .elementAt(1)['question']
              .substring(0, viewModel.answers.elementAt(1)['response_start']),
          middle: viewModel.answers.elementAt(1)['question'].substring(
              viewModel.answers.elementAt(1)['response_start'],
              viewModel.answers.elementAt(1)['response_end']),
          end: viewModel.answers
              .elementAt(1)['question']
              .substring(viewModel.answers.elementAt(1)['response_end']),
        ),
        verticalSpaceLarge,
        _buildPracticeReviewSection(context: context, viewModel: viewModel)
      ];

  Widget _buildTitleWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(viewModel),
      );

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Passage',
        style: style16DG600,
      );

  Widget _buildQuestionWrapper(String question) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(question),
      );

  Widget _buildQuestion(String question) => Text(
        question,
        style: style14DG400,
      );

  Widget _buildAnswerWrapper(
          {required String start,
          required String middle,
          required String end}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAnswer(end: end, start: start, middle: middle),
      );

  Widget _buildAnswer({
    required String end,
    required String start,
    required String middle,
  }) =>
      RichText(
        text: TextSpan(
          style: style14DG400,
          children: [
            //TextSpan(text: start),
            TextSpan(
              text: 'Your Answer: $middle',
              // style: style14P400,
            ),
            //TextSpan(text: end),
          ],
        ),
      );

  Widget _buildPracticeReviewSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeReviewSection(
        review: viewModel.answers,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(context),
      );
}

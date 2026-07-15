import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';
import 'package:yimaru_app/ui/widgets/listenable_review_practice_card.dart';

import '../../../common/app_colors.dart';
import '../../../common/enmus.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/course_practice_text_card.dart';
import '../../../widgets/page_loading_indicator.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice1Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoListeningPractice1Review({super.key});

  String getQuestion(
      {required int index, required CoursePracticeViewModel viewModel}) {
    if (index >= viewModel.answers.length) return '';
    return viewModel.answers[index]['question']?.toString() ?? '';
  }


  String getResponse(
      {required int index, required CoursePracticeViewModel viewModel}) {
    if (index >= viewModel.answers.length) return '';
    return viewModel.answers[index]['response']?.toString() ?? '';
  }

  Future<void> _next(CoursePracticeViewModel viewModel) async {
    await viewModel.stopAudio();
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
          _buildStopRecState(viewModel)
        ],
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
            'Listening practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
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
        child: _buildBodyScroller(context: context, viewModel: viewModel),
      );

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
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '1', question:getQuestion(index: 0, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '2', question:getQuestion(index: 1, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '3', question: getQuestion(index: 2, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '4', question: getQuestion(index: 3, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildQuestionRowWrapper(
            number: '5', question: getQuestion(index: 4, viewModel: viewModel)),
        verticalSpaceLarge,
        _buildLabelWrapper(),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '1', answer:getResponse(index: 0, viewModel: viewModel)),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '2', answer:getResponse(index: 1, viewModel: viewModel)),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '3', answer:getResponse(index: 2, viewModel: viewModel)),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '4', answer: getResponse(index: 3, viewModel: viewModel)),
        verticalSpaceSmall,
        _buildPracticeResponsesWrapper(
            number: '5', answer: viewModel.answers[4]['response']),
        verticalSpaceMedium,
        _buildPracticeReviewSection(context: context, viewModel: viewModel)
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
          _buildQuestionWrapper(number: number, question: question)
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
      CoursePracticeTextCard(
        subtitle: '$number. $answer',
      );

  Widget _buildPracticeReviewSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeReviewSection(
        review: viewModel.answers,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? () async => await _next(viewModel)
            : () async => await viewModel.nextQuestion(context),
      );

  Widget _buildStopRecState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.stopAudio)
          ? const PageLoadingIndicator()
          : Container();
}

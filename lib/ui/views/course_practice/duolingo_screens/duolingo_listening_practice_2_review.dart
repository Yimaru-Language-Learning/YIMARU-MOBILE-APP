import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/course_practice_text_card.dart';
import '../../../widgets/listenable_repetitive_practice_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice2Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const DuolingoListeningPractice2Review({super.key});

  String getQuestion(
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
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      SafeArea(
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
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionWrapper(viewModel),
        verticalSpaceLarge,
        _buildLabelWrapper(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[1].value),
        verticalSpaceTiny,
        _buildPracticeResponsesWrapper(
            getQuestion(index: 0, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildLabelWrapper(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[2].value),
        verticalSpaceTiny,
        _buildPracticeResponsesWrapper(
            getQuestion(index: 1, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildLabelWrapper(viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.stimulus?[2].value),
        verticalSpaceTiny,
        _buildPracticeResponsesWrapper(
            getQuestion(index: 2, viewModel: viewModel)),
        verticalSpaceMedium,
        _buildPracticeReviewSection(context: context, viewModel: viewModel),
      ];

  Widget _buildTitleWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        'Listen to the audio message and type your response.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(viewModel),
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      ListenableRepetitivePracticeCard(
          question: viewModel.questions[viewModel.currentQuestion]
                  .dynamicPayload?.stimulus?.first.value ??
              '');

  Widget _buildLabelWrapper(String question) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLabel(question),
      );

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildPracticeResponsesWrapper(String answer) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeResponses(answer),
      );

  Widget _buildPracticeResponses(
    String answer,
  ) =>
      CoursePracticeTextCard(subtitle: answer);

  Widget _buildPracticeReviewSection(
          {required BuildContext context,
          required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeReviewSection(
        review: viewModel.answers,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? () async => await _next(viewModel)
            : () async => await viewModel.nextQuestion(context),
      );
}

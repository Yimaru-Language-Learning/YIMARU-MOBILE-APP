import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../../../widgets/speaking_practice_review_section.dart';
import '../course_practice_viewmodel.dart';

class IeltsSpeakingPractice2Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  const IeltsSpeakingPractice2Review({super.key});

  Future<void> _cancel(CoursePracticeViewModel viewModel) async {
    await viewModel.stopRecording();
    viewModel.resetValues();

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
        _buildQuestionExpandedWrapper(viewModel),
        _buildPracticeReviewSection(viewModel)
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
            'Speaking practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildTitle() => Text(
        'Part 1: Cue Card',
        style: style18DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionExpandedWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionScrollerWrapper(viewModel));

  Widget _buildQuestionScrollerWrapper(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(child: _buildQuestionColumn(viewModel));

  Widget _buildQuestionColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(viewModel),
      );

  List<Widget> _buildSpeakingIndicatorChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildQuestionPaddingWrapper(viewModel),
      ];

  Widget _buildQuestionPaddingWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestionAlignmentWrapper(viewModel),
      );

  Widget _buildQuestionAlignmentWrapper(CoursePracticeViewModel viewModel) =>
      Center(child: _buildQuestion(viewModel));

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeQuestionCard(
        title: '',
        subtitle: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.stimulus?.last.value,
      );

  Widget _buildPracticeReviewSection(CoursePracticeViewModel viewModel) =>
      SpeakingPracticeReviewSection(
          onTap: viewModel.currentQuestion == viewModel.questions.length - 1
              ? viewModel.nextScreen
              : () async => await viewModel.nextQuestion(),
          answers: viewModel.questions[viewModel.currentQuestion].dynamicPayload
                  ?.response?.last.value ??
              '');
}

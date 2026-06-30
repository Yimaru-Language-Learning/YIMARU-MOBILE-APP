import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/helper_functions.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/course_practice_app_bar.dart';
import '../../../widgets/course_practice_question_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoWritingPractice3Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice3Review(
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
        _buildQuestionSectionExpandedWrapper(viewModel),
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
            'Writing practice (${viewModel.currentQuestion + 1}/${viewModel.questions.length})',
      );

  Widget _buildSheet(CoursePracticeViewModel viewModel) => CancelPracticeSheet(
        onClose: viewModel.pop,
        onContinue: viewModel.pop,
        user: viewModel.user?.firstName ?? '',
        onCancel: () async => await _cancel(viewModel),
      );

  Widget _buildQuestionSectionExpandedWrapper(
          CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildQuestionSectionScrollerWrapper(viewModel));

  Widget _buildQuestionSectionScrollerWrapper(
          CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionSectionWrapper(viewModel),
      );

  Widget _buildQuestionSectionWrapper(CoursePracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionQuestionSectionChildren(viewModel),
      );

  List<Widget> _buildQuestionQuestionSectionChildren(
          CoursePracticeViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildQuestionWrapper(viewModel),
        verticalSpaceLarge,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceLarge,
        _buildPracticeReviewSection(viewModel)
      ];

  Widget _buildTitle(CoursePracticeViewModel viewModel) => Text(
        'Write about the topic below for ${getMinutes(viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.last.value['seconds'])} minutes ${getSeconds(viewModel.questions[viewModel.currentQuestion].dynamicPayload?.response?.last.value['seconds'])} seconds.',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(viewModel),
      );

  Widget _buildQuestion(CoursePracticeViewModel viewModel) =>
      CoursePracticeQuestionCard(
          subtitle: viewModel.questions[viewModel.currentQuestion]
              .dynamicPayload?.stimulus?.first.value);

  Widget _buildPracticeFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessmentFormField(viewModel),
      );

  Widget _buildAssessmentFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        enabled: false,
        maxLength: 250,
        controller: practiceController,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildPracticeReviewSection(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeReviewSection(
        review: viewModel.questions[viewModel.currentQuestion].dynamicPayload
            ?.response?.first.value,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(),
      );
}

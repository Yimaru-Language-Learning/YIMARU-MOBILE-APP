import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_assessment_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../../../widgets/listenable_assessment_card.dart';
import '../duolingo_viewmodel.dart';

class DuolingoListeningAssessment2Review
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoListeningAssessment2Review(
      {super.key, required this.assessmentController});

  @override
  Widget build(BuildContext context, DuolingoViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(DuolingoViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(DuolingoViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(DuolingoViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(DuolingoViewModel viewModel) => [
        _buildAppBarIndenter(viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarIndenter(DuolingoViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(viewModel),
      );

  Widget _buildAppBarWrapper(DuolingoViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(DuolingoViewModel viewModel) => DuolingoAssessmentAppBar(
        title: 'Feedback',
        onClose: () => viewModel.goTo(0),
      );

  Widget _buildExpandedBody(DuolingoViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(DuolingoViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionSectionWrapper(viewModel),
      );

  Widget _buildQuestionSectionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildQuestionQuestionSectionChildren(viewModel),
      );

  List<Widget> _buildQuestionQuestionSectionChildren(
          DuolingoViewModel viewModel) =>
      [
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionWrapper(),
        verticalSpaceLarge,
        _buildLabelWrapper('1. Focus of the conference:'),
        verticalSpaceTiny,
        _buildAssessmentFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabelWrapper('2. Number of presentations:'),
        verticalSpaceTiny,
        _buildAssessmentFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabelWrapper('3. Keynote speaker’s field:'),
        verticalSpaceTiny,
        _buildAssessmentFormFieldWrapper(viewModel),
        verticalSpaceLarge,
        _buildAssessmentReviewSection(viewModel)
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

  Widget _buildQuestionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(),
      );

  Widget _buildQuestion() => const ListenableAssessmentCard();

  Widget _buildLabelWrapper(String question) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLabel(question),
      );

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildAssessmentFormFieldWrapper(DuolingoViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessmentFormField(viewModel),
      );

  Widget _buildAssessmentFormField(DuolingoViewModel viewModel) =>
      TextFormField(
        controller: assessmentController,
        onTap: viewModel.setAssessmentFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: assessmentController.text.isNotEmpty),
      );

  Widget _buildAssessmentReviewSection(DuolingoViewModel viewModel) =>
      DuolingoAssessmentReviewSection(onTap: () => viewModel.goTo(5));
}

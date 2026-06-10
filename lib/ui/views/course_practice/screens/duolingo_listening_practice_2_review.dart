import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../../../widgets/listenable_practice_card.dart';
import '../course_practice_viewmodel.dart';

class DuolingoListeningPractice2Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoListeningPractice2Review(
      {super.key, required this.practiceController});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumn(viewModel));

  Widget _buildBodyColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(CoursePracticeViewModel viewModel) => [
        _buildAppBarIndenter(viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarIndenter(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(viewModel),
      );

  Widget _buildAppBarWrapper(CoursePracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceSmall,
        ],
      );

  Widget _buildAppBar(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeAppBar(
        title: 'Feedback',
        onClose: () => viewModel.goTo(0),
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
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionWrapper(),
        verticalSpaceLarge,
        _buildLabelWrapper('1. Focus of the conference:'),
        verticalSpaceTiny,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabelWrapper('2. Number of presentations:'),
        verticalSpaceTiny,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceSmall,
        _buildLabelWrapper('3. Keynote speaker’s field:'),
        verticalSpaceTiny,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceLarge,
        _buildPracticeReviewSection(viewModel)
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

  Widget _buildQuestion() => const ListenablePracticeCard();

  Widget _buildLabelWrapper(String question) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLabel(question),
      );

  Widget _buildLabel(String question) => Text(
        question,
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildPracticeFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeFormField(viewModel),
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        controller: practiceController,
        onTap: viewModel.setPracticeFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildPracticeReviewSection(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeReviewSection(onTap: () => viewModel.goTo(5));
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/cancel_practice_sheet.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
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
    viewModel.pop();
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

  Widget _buildScaffoldWrapper(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) =>
      SafeArea(child: _buildBodyColumn(context: context, viewModel: viewModel));

  Widget _buildBodyColumn(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(context: context, viewModel: viewModel),
      );

  List<Widget> _buildBodyColumnChildren(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => [
        _buildAppBarIndenter(context: context, viewModel: viewModel),
        _buildExpandedBody(viewModel),
      ];

  Widget _buildAppBarIndenter(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppBarWrapper(context: context, viewModel: viewModel),
      );

  Widget _buildAppBarWrapper(     {required BuildContext context,
    required CoursePracticeViewModel viewModel}) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(context: context, viewModel: viewModel),
          verticalSpaceSmall,
        ],
      );
  Widget _buildAppBar(
      {required BuildContext context,
        required CoursePracticeViewModel viewModel}) =>
      DuolingoPracticeAppBar(
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
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildQuestionWrapper(),
        verticalSpaceLarge,
        _buildLabelWrapper(),
        verticalSpaceSmall,
        _buildAssessmentFormFieldWrapper(viewModel),
        verticalSpaceLarge,
        _buildAssessmentReviewSection(viewModel)
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

  Widget _buildQuestionWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildQuestion(),
      );

  Widget _buildQuestion() => const ListenableRepetitivePracticeCard();

  Widget _buildLabelWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildLabel(),
      );

  Widget _buildLabel() => Text(
        'Your Answer',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildAssessmentFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessmentFormField(viewModel),
      );

  Widget _buildAssessmentFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        maxLength: 250,
        enabled: false,
        controller: practiceController,
        onTap: viewModel.setPracticeFocus,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: practiceController.text.isNotEmpty),
      );

  Widget _buildAssessmentReviewSection(CoursePracticeViewModel viewModel) =>
      DuolingoPracticeReviewSection(
        review: viewModel.questions[viewModel.currentQuestion]
            .dynamicPayload?.response?.last.value,
        onTap: viewModel.currentQuestion == viewModel.questions.length - 1
            ? viewModel.nextScreen
            : () async => await viewModel.nextQuestion(),);
}

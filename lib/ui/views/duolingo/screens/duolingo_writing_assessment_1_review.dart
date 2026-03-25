import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_assessment_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_assessment_app_bar.dart';
import '../duolingo_viewmodel.dart';

class DuolingoWritingAssessment1Review
    extends ViewModelWidget<DuolingoViewModel> {
  final TextEditingController assessmentController;

  const DuolingoWritingAssessment1Review(
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
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(DuolingoViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(DuolingoViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceSmall,
        _buildImageContainer(),
        verticalSpaceMedium,
        _buildAssessmentFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildAssessmentReviewSection(viewModel)
      ];

  Widget _buildTitle() => Text(
        'Write a description of the image below for 1 minute',
        style: style18DG700,
        textAlign: TextAlign.center,
      );

  Widget _buildImageContainer() => SizedBox(
        width: 250,
        height: 300,
        child: _buildImageWrapper(),
      );

  Widget _buildImageWrapper() => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: _buildImage(),
      );

  Widget _buildImage() => Image.asset(
        'assets/images/image_1.png',
        fit: BoxFit.fill,
        width: double.maxFinite,
      );

  Widget _buildAssessmentFormFieldWrapper(DuolingoViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAssessmentFormField(viewModel),
      );

  Widget _buildAssessmentFormField(DuolingoViewModel viewModel) =>
      TextFormField(
        maxLines: 5,
        enabled: false,
        maxLength: 250,
        controller: assessmentController,
        decoration: inputDecoration(
            focus: true,
            hint: 'Start writing here...',
            filled: assessmentController.text.isNotEmpty),
      );

  Widget _buildAssessmentReviewSection(DuolingoViewModel viewModel) =>
      DuolingoAssessmentReviewSection(onTap: () => viewModel.goTo(5));
}

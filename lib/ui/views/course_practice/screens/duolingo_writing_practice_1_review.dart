import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/duolingo_practice_review_section.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/duolingo_practice_app_bar.dart';
import '../course_practice_viewmodel.dart';

class DuolingoWritingPractice1Review
    extends ViewModelWidget<CoursePracticeViewModel> {
  final TextEditingController practiceController;

  const DuolingoWritingPractice1Review(
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

  Widget _buildAppBar(CoursePracticeViewModel viewModel) => const DuolingoPracticeAppBar(
        title: 'Feedback',
       // onClose: () => viewModel.goTo(0),
      );

  Widget _buildExpandedBody(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(CoursePracticeViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildQuestionWrapper(viewModel),
      );

  Widget _buildQuestionWrapper(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildQuestionChildren(viewModel),
      );

  List<Widget> _buildQuestionChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceSmall,
        _buildImageContainer(),
        verticalSpaceMedium,
        _buildPracticeFormFieldWrapper(viewModel),
        verticalSpaceMedium,
        _buildPracticeReviewSection(viewModel)
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

  Widget _buildPracticeFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildPracticeFormField(viewModel),
      );

  Widget _buildPracticeFormField(CoursePracticeViewModel viewModel) =>
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
          review: '',

          onTap: (){});
}

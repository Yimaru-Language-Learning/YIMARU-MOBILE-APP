import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/course_practice/course_practice_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';
import 'custom_elevated_button.dart';

class IeltsPracticeReviewSection
    extends ViewModelWidget<CoursePracticeViewModel> {
  final List review;
  final GestureTapCallback? onTap;
  const IeltsPracticeReviewSection(
      {super.key, this.onTap, required this.review});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildReviewContainer(viewModel);

  Widget _buildReviewContainer(CoursePracticeViewModel viewModel) => Container(
    width: double.maxFinite,
    color: kcDeepGreen.withValues(alpha: 0.1),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: _buildReviewColumn(viewModel),
  );

  Widget _buildReviewColumn(CoursePracticeViewModel viewModel) => Column(
        children: [
          _buildTitle(),
          verticalSpaceMedium,
          _buildSampleAnswers(),
          verticalSpaceMedium,
          _buildContinueButton(),
          verticalSpaceMedium,
        ],
      );
  Widget _buildTitle() => Text(
        'Review Sample Answer:',
        style: style18G700,
        textAlign: TextAlign.center,
      );

  Widget _buildSampleAnswers() => ListView.separated(
        shrinkWrap: true,
        itemCount: review.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildSampleAnswer(
            number: index + 1, answer: review[index]['sample']),
      );

  Widget _buildSampleAnswer({
    required int number,
    required String answer,
  }) =>
      Text(
        '$number. $answer',
        style: style14DG400,
        textAlign: TextAlign.center,
      );




  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

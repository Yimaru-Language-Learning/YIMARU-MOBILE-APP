import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'course_practice_result_card.dart';
import 'custom_elevated_button.dart';

class SpeakingPracticeReviewSection
    extends ViewModelWidget<CoursePracticeViewModel> {
  final List answers;
  final GestureTapCallback? onTap;

  const SpeakingPracticeReviewSection(
      {super.key, this.onTap, required this.answers});

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildReviewContainer(viewModel);

  Widget _buildReviewContainer(CoursePracticeViewModel viewModel) => Container(
        width: double.maxFinite,
        color: kcDeepGreen.withValues(alpha: 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: _buildReview(viewModel),
      );

  Widget _buildReview(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(CoursePracticeViewModel viewModel) => [
        _buildTitle(),
        verticalSpaceMedium,
        _buildResults(viewModel),
        verticalSpaceLarge,
    _buildContinueButtonState(viewModel),
        verticalSpaceMedium
      ];

  Widget _buildTitle() => Text(
        'Review Sample Answer:',
        style: style18G700,
        textAlign: TextAlign.center,
      );

  Widget _buildResults(CoursePracticeViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: answers.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildResult(
            question: (index + 1).toString(), answer: viewModel.answers[index]),
      );

  Widget _buildResult(
          {required String question, required Map<String, dynamic> answer}) =>
      CoursePracticeResultCard(
        answer: answer,
        question: question,
      );

  Widget _buildContinueButtonState(CoursePracticeViewModel viewModel) =>
      viewModel.busy(StateObjects.stopAudio)
          ? _buildProgressIndicatorWrapper()
          : _buildContinueButton();

  Widget _buildProgressIndicatorWrapper()=> SizedBox(
    height: 55,
    child: _buildProgressIndicator(),
  );

  Widget _buildProgressIndicator()=> const CustomCircularProgressIndicator(color: kcPrimaryColor);

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 55,
        onTap: onTap,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

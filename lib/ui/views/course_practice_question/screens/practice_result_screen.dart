import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice_question/course_practice_question_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/large_app_bar.dart';

class PracticeResultScreen
    extends ViewModelWidget<CoursePracticeQuestionViewModel> {
  const PracticeResultScreen({super.key});

  void _retake(CoursePracticeQuestionViewModel viewModel) {
    viewModel.reset();
    viewModel.goTo(0);
  }

  @override
  Widget build(
          BuildContext context, CoursePracticeQuestionViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CoursePracticeQuestionViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CoursePracticeQuestionViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(
          CoursePracticeQuestionViewModel viewModel) =>
      [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(CoursePracticeQuestionViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(CoursePracticeQuestionViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(CoursePracticeQuestionViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(CoursePracticeQuestionViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildUpperColumn(CoursePracticeQuestionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(
          CoursePracticeQuestionViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildAppBar(CoursePracticeQuestionViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: false,
        onPop: () => viewModel.pop(),
      );

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/complete.svg',
      );

  Widget _buildTitle() => Text(
        'Practice Completed',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You’ve finished this practice. Great work!',
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildLowerColumn(CoursePracticeQuestionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(
          CoursePracticeQuestionViewModel viewModel) =>
      [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildSkipButtonWrapper(viewModel)
      ];

  Widget _buildContinueButton(CoursePracticeQuestionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        safe: false,
        borderRadius: 12,
        text: 'Practice Again',
        foregroundColor: kcWhite,
        onTap: () => _retake(viewModel),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSkipButtonWrapper(CoursePracticeQuestionViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildSkipButton(viewModel),
      );

  Widget _buildSkipButton(CoursePracticeQuestionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        onTap: viewModel.pop,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
      );
}

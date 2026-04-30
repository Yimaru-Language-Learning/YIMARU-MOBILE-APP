import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../assessment_viewmodel.dart';

class AssessmentIntroScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentIntroScreen({super.key});

  Future<void> _next(AssessmentViewModel viewModel) async =>
      viewModel.setFirstAssessment();

  @override
  Widget build(BuildContext context, AssessmentViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(AssessmentViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(AssessmentViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(AssessmentViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(AssessmentViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(AssessmentViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildUpperColumn(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(AssessmentViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildAppBar(AssessmentViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle() => Text(
        'Want a quick assessment to know your English level?',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'Answer a few quick questions to help us understand your English proficiency.',
        style: style14MG400,
      );

  Widget _buildLowerColumn(AssessmentViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(AssessmentViewModel viewModel) => [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildSkipButtonWrapper(viewModel)
      ];

  Widget _buildContinueButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        safe: false,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await _next(viewModel),
      );

  Widget _buildSkipButtonWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildSkipButton(viewModel),
      );

  Widget _buildSkipButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Skip',
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () => viewModel.next(page: 3),
      );
}

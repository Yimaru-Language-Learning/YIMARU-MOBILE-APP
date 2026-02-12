import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

import '../assessment_viewmodel.dart';

class AssessmentResultScreen extends ViewModelWidget<AssessmentViewModel> {
  const AssessmentResultScreen({super.key});

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

  List<Widget> _buildScaffoldChildren(AssessmentViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildAppBar(AssessmentViewModel viewModel) => LargeAppBar(
        showBackButton: false,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(AssessmentViewModel viewModel) => [
        verticalSpaceLarge,
        _buildTitle(viewModel),
        verticalSpaceSmall,
        _buildPrimarySubtitle(),
        verticalSpaceMedium,
        _buildIconWrapper(viewModel),
        verticalSpaceMedium,
        _buildSecondarySubtitle()
      ];

  Widget _buildTitle(AssessmentViewModel viewModel) => Text(
        'You’re likely a ${viewModel.proficiencyLevel.name.toUpperCase()} speaker!',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildPrimarySubtitle() => Text(
        'Great Job! Here’s your next step to keep improving.',
        textAlign: TextAlign.center,
        style: style14MG400,
      );

  Widget _buildIconWrapper(AssessmentViewModel viewModel) =>
      viewModel.proficiencyLevel != ProficiencyLevels.none
          ? _buildIcon(viewModel)
          : Container();

  Widget _buildIcon(AssessmentViewModel viewModel) => SvgPicture.asset(
      'assets/icons/${viewModel.proficiencyLevel.name.substring(0, 1)}_${viewModel.proficiencyLevel.name.substring(1)}.svg');

  Widget _buildSecondarySubtitle() => Text(
        'Let\'s start your practice',
        style: style14DG400,
        textAlign: TextAlign.center,
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
        onTap: () => viewModel.next(),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSkipButtonWrapper(AssessmentViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildSkipButton(viewModel),
      );

  Widget _buildSkipButton(AssessmentViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        backgroundColor: kcWhite,
        text: 'Practice Speaking',
        borderColor: kcPrimaryColor,
        onTap: () => viewModel.next(),
        foregroundColor: kcPrimaryColor,
      );
}

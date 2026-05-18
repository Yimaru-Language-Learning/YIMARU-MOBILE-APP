import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_practice/learn_practice_viewmodel.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/small_app_bar.dart';

class LearnPracticeFinishScreen
    extends ViewModelWidget<LearnPracticeViewModel> {
  const LearnPracticeFinishScreen({super.key});

  Future<void> _reset(LearnPracticeViewModel viewModel) async =>
      await viewModel.reset();

  @override
  Widget build(BuildContext context, LearnPracticeViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnPracticeViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnPracticeViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnPracticeViewModel viewModel) =>
      SafeArea(child: _buildBodyColumnWrapper(viewModel));

  Widget _buildBodyColumnWrapper(LearnPracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBodyColumn(viewModel),
      );

  Widget _buildBodyColumn(viewModel) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyColumnChildren(viewModel),
      );

  List<Widget> _buildBodyColumnChildren(LearnPracticeViewModel viewModel) => [
        _buildAppBarWrapper(viewModel),
        _buildSpeakingIndicatorWrapper(viewModel),
        _buildLowerButtonsSectionWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(LearnPracticeViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          verticalSpaceMedium,
        ],
      );

  Widget _buildAppBar(LearnPracticeViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
        title: 'Practice Speaking',
      );

  Widget _buildSpeakingIndicatorWrapper(LearnPracticeViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _buildSpeakingIndicatorChildren(),
      );

  List<Widget> _buildSpeakingIndicatorChildren() => [
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        _buildSubtitle(),
      ];

  Widget _buildIcon() => SvgPicture.asset('assets/icons/success.svg');

  Widget _buildTitle() => Text(
        'Practice Completed!',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        'You sound more confident this time - great improvement!',
        style: style14DG400,
        textAlign: TextAlign.center,
      );

  Widget _buildLowerButtonsSectionWrapper(LearnPracticeViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildLowerButtonsSection(viewModel),
      );

  Widget _buildLowerButtonsSection(LearnPracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildLowerButtonsSectionChildren(viewModel),
      );

  List<Widget> _buildLowerButtonsSectionChildren(
          LearnPracticeViewModel viewModel) =>
      [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildPracticeAgainButton(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildContinueButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        onTap: viewModel.pop,
        foregroundColor: kcWhite,
        text: 'Continue Practice',
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildPracticeAgainButton(LearnPracticeViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Practice Again',
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
        onTap: () async => await _reset(viewModel),
      );
}

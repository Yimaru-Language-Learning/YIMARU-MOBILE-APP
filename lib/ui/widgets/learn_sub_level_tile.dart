import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_level/learn_level_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnSubLevelTile extends ViewModelWidget<LearnLevelViewModel> {
  final bool current;
  final String title;
  final String subtitle;

  const LearnSubLevelTile({
    super.key,
    required this.title,
    required this.current,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, LearnLevelViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnLevelViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color:
                  current ? kcPrimaryColor.withOpacity(0.2) : kcVeryLightGrey),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnLevelViewModel viewModel) => ExpansionTile(
        enabled: current,
        textColor: kcDarkGrey,
        title: _buildTitleRow(),
        showTrailingIcon: current,
        subtitle: _buildContent(),
        initiallyExpanded: current,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(15),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        backgroundColor:
            current ? kcPrimaryColor.withOpacity(0.1) : kcBackgroundColor,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        collapsedBackgroundColor:
            current ? kcPrimaryColor.withOpacity(0.1) : kcBackgroundColor,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnLevelViewModel viewModel) =>
      [_buildActionButtonWrapper(viewModel)];

  Widget _buildTitleRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTitleChildren(),
      );

  List<Widget> _buildTitleChildren() => [
        _buildTitle(),
        if (current) horizontalSpaceSmall,
        if (current) _buildProgressStatus()
      ];

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildProgressStatus() => const ProgressStatus(
        color: kcPrimaryColor,
        status: 'Current Level',
      );

  Widget _buildContent() => Text(
        subtitle,
        style: const TextStyle(
          color: kcDarkGrey,
        ),
      );

  Widget _buildActionButtonWrapper(LearnLevelViewModel viewModel) => SizedBox(
        height: 40,
        child: _buildActionButtons(viewModel),
      );

  Widget _buildActionButtons(LearnLevelViewModel viewModel) => Row(
        children: [
          _buildViewButtonWrapper(viewModel),
          horizontalSpaceSmall,
          _buildPracticeButtonWrapper(viewModel)
        ],
      );

  Widget _buildViewButtonWrapper(LearnLevelViewModel viewModel) => Expanded(
        child: _buildViewButton(viewModel),
      );

  Widget _buildViewButton(LearnLevelViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'View Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        onTap: () async => await viewModel.navigateToLearnModule(),
      );

  Widget _buildPracticeButtonWrapper(LearnLevelViewModel viewModel) => Expanded(
        child: _buildPracticeButton(viewModel),
      );

  Widget _buildPracticeButton(LearnLevelViewModel viewModel) =>
       CustomElevatedButton(
        height: 15,
        text: 'Practice',
        borderRadius: 12,
        backgroundColor: kcWhite,
        borderColor: kcPrimaryColor,
        foregroundColor: kcPrimaryColor,
         onTap: () async =>  await viewModel.navigateToLearnPractice()
        // onTap: () async => await viewModel.navigateToLearnLevel(),
      );
}

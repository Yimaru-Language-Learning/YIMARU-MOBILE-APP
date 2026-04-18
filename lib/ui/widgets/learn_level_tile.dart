import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_level/learn_level_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../../models/level.dart';
import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_elevated_button.dart';

class LearnLevelTile extends ViewModelWidget<LearnLevelViewModel> {
  final Level level;
  final GestureTapCallback? onTap;

  const LearnLevelTile({
    super.key,
    this.onTap,
    required this.level,
  });

  @override
  Widget build(BuildContext context, LearnLevelViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnLevelViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: kcPrimaryColor.withOpacity(0.2),
            // color:
            //     current ? kcPrimaryColor.withOpacity(0.2) : kcVeryLightGrey,
          ),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnLevelViewModel viewModel) => ExpansionTile(
        enabled: true,
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        title: _buildTitleRow(),
        initiallyExpanded: false,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        childrenPadding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),

        //enabled: current,
        // showTrailingIcon: current,
        //initiallyExpanded: current,
        // collapsedBackgroundColor:
        //     current ? kcPrimaryColor.withOpacity(0.1) : kcBackgroundColor,
        // backgroundColor:
        //     current ? kcPrimaryColor.withOpacity(0.1) : kcBackgroundColor,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnLevelViewModel viewModel) =>
      [_buildViewButton(viewModel)];

  Widget _buildTitleRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTitleChildren(),
      );

  List<Widget> _buildTitleChildren() => [
        _buildTitle(),
        // if (current) horizontalSpaceSmall,
        // if (current) _buildProgressStatus()
      ];

  Widget _buildTitle() => Text(
        level.title ?? '',
        style: style16P600,
      );

  Widget _buildProgressStatus() => const ProgressStatus(
        color: kcPrimaryColor,
        status: 'Current Level',
      );

  Widget _buildViewButton(LearnLevelViewModel viewModel) =>
      CustomElevatedButton(
        height: 15,
        onTap: onTap,
        borderRadius: 12,
        text: 'View Level',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

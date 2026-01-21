import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn/learn_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/progress_status.dart';

import '../common/app_colors.dart';
import 'custom_elevated_button.dart';

class LearnLevelTile extends ViewModelWidget<LearnViewModel> {
  final String title;
  final String subtitle;
  final ProgressStatuses status;

  const LearnLevelTile({
    super.key,
    required this.title,
    required this.status,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
              color: status == ProgressStatuses.started
                  ? kcPrimaryColor.withOpacity(0.2)
                  : kcVeryLightGrey),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnViewModel viewModel) => ExpansionTile(
        textColor: kcDarkGrey,
        title: _buildTitleRow(),
        subtitle: _buildContent(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(15),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        backgroundColor: status != ProgressStatuses.pending
            ? kcPrimaryColor.withOpacity(0.1)
            : kcBackgroundColor,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        enabled: status != ProgressStatuses.pending ? true : false,
        collapsedBackgroundColor: status != ProgressStatuses.pending
            ? kcPrimaryColor.withOpacity(0.1)
            : kcBackgroundColor,
        showTrailingIcon: status != ProgressStatuses.pending ? true : false,
        initiallyExpanded: status == ProgressStatuses.started ? true : false,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnViewModel viewModel) =>
      [_buildActionButton(viewModel)];

  Widget _buildTitleRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTitleChildren(),
      );

  List<Widget> _buildTitleChildren() => [
        _buildTitle(),
        if (status != ProgressStatuses.pending) horizontalSpaceSmall,
        if (status != ProgressStatuses.pending) _buildProgressStatus()
      ];

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildProgressStatus() => ProgressStatus(
        status: status.name.substring(0, 1).toUpperCase() +
            status.name.substring(1, status.name.length),
        color: kcPrimaryColor,
      );

  Widget _buildContent() => Text(
        subtitle,
        style: const TextStyle(
          color: kcDarkGrey,
        ),
      );

  Widget _buildActionButton(LearnViewModel viewModel) => CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        text: status == ProgressStatuses.completed
            ? 'Review Course'
            : status == ProgressStatuses.pending
                ? 'Start Learning'
                : 'Continue Learning',
        onTap: () async => await viewModel.navigateToLearnLevel(),
      );
}

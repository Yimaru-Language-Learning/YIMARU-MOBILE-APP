import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/course.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/views/learn/learn_viewmodel.dart';

import '../common/app_colors.dart';
import 'custom_elevated_button.dart';

class LearnTile extends ViewModelWidget<LearnViewModel> {
  final Course course;
  final GestureTapCallback? onTap;

  const LearnTile({
    super.key,
    this.onTap,
    required this.course,
  });

  @override
  Widget build(BuildContext context, LearnViewModel viewModel) =>
      _buildExpansionTileCard(viewModel);

  Widget _buildExpansionTileCard(LearnViewModel viewModel) => Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withOpacity(0.2)
              // color: status == ProgressStatuses.started
              //     ? kcPrimaryColor.withOpacity(0.2)
              //     : kcVeryLightGrey,
              ),
        ),
        child: _buildExpansionTile(viewModel),
      );

  Widget _buildExpansionTile(LearnViewModel viewModel) => ExpansionTile(
        enabled: true,
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        title: _buildTitleRow(),
        initiallyExpanded: false,
        subtitle: _buildContent(),
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        shape: Border.all(color: kcTransparent),
        expandedAlignment: Alignment.centerLeft,
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        childrenPadding: const EdgeInsets.only(bottom: 15),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        // enabled: status != ProgressStatuses.pending ? true : false,
        // status != ProgressStatuses.pending
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcBackgroundColor,
        // collapsedBackgroundColor: status != ProgressStatuses.pending
        //     ? kcPrimaryColor.withOpacity(0.1)
        //     : kcBackgroundColor,
        //  showTrailingIcon: status != ProgressStatuses.pending ? true : false,
        // initiallyExpanded: status == ProgressStatuses.started ? true : false,
        children: _buildExpansionTileChildren(viewModel),
      );

  List<Widget> _buildExpansionTileChildren(LearnViewModel viewModel) => [
        _buildDivider(),
        verticalSpaceTiny,
        _buildActionButtonWrapper(viewModel)
      ];

  Widget _buildTitleRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildTitleChildren(),
      );

  List<Widget> _buildTitleChildren() => [
        _buildTitle(),
        // if (status != ProgressStatuses.pending) horizontalSpaceSmall,
        // if (status != ProgressStatuses.pending) _buildProgressStatus()
      ];

  Widget _buildTitle() => Text(
        course.title ?? '',
        style: const TextStyle(
          fontSize: 16,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );

  // Widget _buildProgressStatus() => ProgressStatus(
  //       status: status.name.substring(0, 1).toUpperCase() +
  //           status.name.substring(1, status.name.length),
  //       color: kcPrimaryColor,
  //     );

  Widget _buildContent() => Text(
        course.description ?? '',
        style: style14DG400,
      );

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildActionButtonWrapper(LearnViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildActionButton(viewModel),
      );

  Widget _buildActionButton(LearnViewModel viewModel) => CustomElevatedButton(
        height: 15,
        onTap: onTap,
        borderRadius: 12,
        text: 'Start Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
        // text: status == ProgressStatuses.completed
        //     ? 'Review Course'
        //     : status == ProgressStatuses.pending
        //         ? 'Start Learning'
        //         : 'Continue Learning',
      );
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/ongoing_progress/ongoing_progress_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_column.dart';
import 'custom_elevated_button.dart';

class CourseProgressSection extends ViewModelWidget<OngoingProgressViewModel> {
  const CourseProgressSection({super.key});

  @override
  Widget build(BuildContext context, OngoingProgressViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(OngoingProgressViewModel viewModel) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(OngoingProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(OngoingProgressViewModel viewModel) => [
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle('Course'),
        verticalSpaceMedium,
        _buildExpansionTileWrapper(viewModel)
      ];

  Widget _buildIcon() => const Icon(
        Icons.book,
        size: 50,
        color: kcPrimaryColor,
      );

  Widget _buildExpansionTileWrapper(OngoingProgressViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: viewModel.courses
            .map(
              (course) => _buildExpansionTileCard(course['title']),
            )
            .toList(),
      );

  Widget _buildExpansionTileCard(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _buildExpansionTile(title),
      );

  Widget _buildExpansionTile(String title) => ExpansionTile(
        showTrailingIcon: true,
        initiallyExpanded: true,
        title: _buildTitle(title),
        iconColor: kcDarkGrey,
        textColor: kcDarkGrey,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        subtitle: _buildProgressIndicator(),
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(15),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        shape: Border.all(color: kcPrimaryColor.withOpacity(0.2)),
        children: _buildExpansionTileChildren(),
      );

  List<Widget> _buildExpansionTileChildren() => [_buildTileWrapper()];

  Widget _buildTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildTileWrapper() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildTileChildren(),
      );

  List<Widget> _buildTileChildren() =>
      [_buildLearningStatus(), verticalSpaceSmall, _buildActionButton()];

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
        progress: 0.5,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildLearningStatus() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildLearningStatusChildren(),
      );

  List<Widget> _buildLearningStatusChildren() => [
        horizontalSpaceMedium,
        _buildWatchedVideos(),
        horizontalSpaceSmall,
        _buildCompletedPractices(),
        horizontalSpaceMedium,
      ];

  Widget _buildWatchedVideos() =>
      const CustomColumn(title: '15/25', subtitle: 'Videos');

  Widget _buildCompletedPractices() =>
      const CustomColumn(title: '8/12', subtitle: 'Practices');

  Widget _buildActionButton() => const CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'Continue Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

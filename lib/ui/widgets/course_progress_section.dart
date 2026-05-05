import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/progress/progress_viewmodel.dart';
import 'custom_column.dart';
import 'custom_elevated_button.dart';

class CourseProgressSection extends ViewModelWidget<ProgressViewModel> {
  const CourseProgressSection({super.key});

  @override
  Widget build(BuildContext context, ProgressViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(ProgressViewModel viewModel) => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withOpacity(0.1),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(ProgressViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(ProgressViewModel viewModel) => [
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

  Widget _buildExpansionTileWrapper(ProgressViewModel viewModel) => Column(
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
        iconColor: kcDarkGrey,
        textColor: kcDarkGrey,
        showTrailingIcon: true,
        initiallyExpanded: true,
        title: _buildTitle(title),
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
        style: style16DG600,
      );

  Widget _buildTileWrapper() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildTileChildren(),
      );

  List<Widget> _buildTileChildren() =>
      [_buildLearningStatus(), verticalSpaceSmall, _buildActionButton()];

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
        progress: 0,
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
      const CustomColumn(title: '0/0', subtitle: 'Videos');

  Widget _buildCompletedPractices() =>
      const CustomColumn(title: '0/0', subtitle: 'Practices');

  Widget _buildActionButton() => const CustomElevatedButton(
        height: 15,
        borderRadius: 12,
        text: 'Continue Course',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

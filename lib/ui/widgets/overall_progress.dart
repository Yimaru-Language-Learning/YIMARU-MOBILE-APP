import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_linear_progress_indicator.dart';

class OverallProgress extends StatelessWidget {
  final int progress;
  final Color backgroundColor;
  final Color indicatorBackgroundColor;
  const OverallProgress(
      {super.key,
      required this.progress,
      required this.backgroundColor,
      required this.indicatorBackgroundColor});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: _buildProgressSection(),
      );

  Widget _buildProgressSection() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildProgressSectionChildren(),
      );

  List<Widget> _buildProgressSectionChildren() => [
        _buildProgressInfoWrapper(),
        verticalSpaceSmall,
        _buildProgressIndicator(),
        verticalSpaceSmall,
        _buildSubtitle()
      ];

  Widget _buildProgressInfoWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildProgressInfoChildren(),
      );

  List<Widget> _buildProgressInfoChildren() =>
      [_buildProgressInfo(), _buildProgress()];

  Widget _buildProgressInfo() => Text(
        'Overall Progress',
        style: style16DG600,
      );

  Widget _buildProgress() => Text(
        '$progress%',
        style: style14P400,
      );

  Widget _buildProgressIndicator() => CustomLinearProgressIndicator(
        progress: progress / 100,
        activeColor: kcPrimaryColor,
        backgroundColor: indicatorBackgroundColor,
      );

  Widget _buildSubtitle() => Text(
        'Keep up the great work! You\'re doing amazing.',
        style: style14DG500,
      );
}

import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_linear_progress_indicator.dart';

class OverallProgressWrapper extends StatelessWidget {
  const OverallProgressWrapper({super.key});

  @override
  Widget build(BuildContext context) => _buildProgressSection();

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
        '35%',
        style: style14P400,
      );

  Widget _buildProgressIndicator() => const CustomLinearProgressIndicator(
        progress: 0.75,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );

  Widget _buildSubtitle() => const Text(
        'Keep up the great work! You\'re doing amazing.',
        style: TextStyle(color: kcDarkGrey),
      );
}

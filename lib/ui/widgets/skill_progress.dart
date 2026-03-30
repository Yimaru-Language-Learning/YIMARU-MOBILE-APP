import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import 'custom_linear_progress_indicator.dart';

class SkillProgress extends StatelessWidget {
  final String skill;
  final double progress;

  const SkillProgress({super.key, required this.skill, required this.progress});

  Color _getColor() {
    if (skill == 'Speaking') {
      return kcOrange;
    } else if (skill == 'Listening') {
      return kcGreen;
    } else if (skill == 'Reading') {
      return kcAquamarine;
    } else {
      return kcIndigo;
    }
  }

  IconData _getIcon() {
    if (skill == 'Speaking') {
      return Icons.mic_none;
    } else if (skill == 'Listening') {
      return Icons.headphones_outlined;
    } else if (skill == 'Reading') {
      return Icons.chrome_reader_mode_outlined;
    } else {
      return Iconsax.pen_add;
    }
  }

  @override
  Widget build(BuildContext context) => _buildSkillSection();

  Widget _buildSkillSection() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildStorageSectionChildren(),
      );

  List<Widget> _buildStorageSectionChildren() => [
        verticalSpaceSmall,
        _buildSkillInfoWrapper(),
        verticalSpaceSmall,
        _buildProgressIndicator(),
        verticalSpaceMedium
      ];

  Widget _buildSkillInfoWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildSkillInfoChildren(),
      );

  List<Widget> _buildSkillInfoChildren() =>
      [_buildSkillRow(), _buildProgress()];

  Widget _buildSkillRow() => Row(
        children: [_buildIcon(), horizontalSpaceTiny, _buildSkill()],
      );

  Widget _buildIcon() => Icon(
        _getIcon(),
        color: _getColor(),
      );

  Widget _buildSkill() => Text(
        skill,
        style: style18DG600,
      );

  Widget _buildProgress() => Text(
        '${(progress * 100).toInt()}%',
        style: style16DG600,
      );

  Widget _buildProgressIndicator() => CustomLinearProgressIndicator(
        progress: progress,
        activeColor: _getColor(),
        backgroundColor: kcVeryLightGrey,
      );
}

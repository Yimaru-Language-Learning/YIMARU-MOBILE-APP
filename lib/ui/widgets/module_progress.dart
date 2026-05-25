import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import 'custom_linear_progress_indicator.dart';

class ModuleProgress extends StatelessWidget {
  final int total;
  final int progress;
  final int completed;

  const ModuleProgress(
      {super.key,
      required this.total,
      required this.progress,
      required this.completed});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
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
      ];

  Widget _buildProgressInfoWrapper() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildProgressInfoChildren(),
      );

  List<Widget> _buildProgressInfoChildren() =>
      [_buildProgressInfo(), _buildProgress()];

  Widget _buildProgressInfo() => Text(
        '$progress% ${LocaleKeys.progress.tr()}',
        style: style16DG400,
      );

  Widget _buildProgress() => Text(
        '$completed/$total',
        style: style14P400,
      );

  Widget _buildProgressIndicator() => CustomLinearProgressIndicator(
        progress: progress / 100,
        activeColor: kcPrimaryColor,
        backgroundColor: kcVeryLightGrey,
      );
}

import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CoursePracticeTextCard extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const CoursePracticeTextCard({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.1)),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        if (title != null) _buildTitle(),
        if (title != null) verticalSpaceTiny,
        if (subtitle != null) _buildSubtitle()
      ];

  Widget _buildTitle() => Text(
        title ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        subtitle ?? '',
        style: style14DG400,
      );
}

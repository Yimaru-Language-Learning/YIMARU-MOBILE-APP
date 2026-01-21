import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class CustomColumn extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomColumn({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => _buildColumn();

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildTitle(), verticalSpaceTiny, _buildSubtitle()];

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      );
  Widget _buildSubtitle() => Text(
        subtitle,
        maxLines: 1,
        softWrap: false,
        style: const TextStyle(color: kcMediumGrey),
      );
}

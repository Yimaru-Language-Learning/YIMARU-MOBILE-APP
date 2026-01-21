import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ValidatorListTile extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  const ValidatorListTile(
      {super.key, required this.label, required this.backgroundColor});

  @override
  Widget build(BuildContext context) => _buildRowWrapper();

  Widget _buildRowWrapper() => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _buildRow(),
      );

  Widget _buildRow() => Row(
        children: [_buildIconWrapper(), horizontalSpaceSmall, _buildLabel()],
      );

  Widget _buildIconWrapper() => CircleAvatar(
        radius: 8,
        backgroundColor: backgroundColor,
        child: _buildIcon(),
      );

  Widget _buildIcon() => const Icon(
        Icons.check,
        size: 14,
        color: kcWhite,
      );

  Widget _buildLabel() => Text(
        label,
        style: style16DG400,
      );
}

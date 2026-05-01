import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';

class NoDataIndicator extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;

  const NoDataIndicator({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) => _buildColumn();

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() => [
        _buildIconWrapper(),
        verticalSpaceMedium,
        _buildTitle(),
      ];

  Widget _buildTitle() => Text(
        title,
        style: style16P600,
      );

  Widget _buildIconWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildIcon(),
      );

  Widget _buildIcon() => const Icon(
        Icons.replay,
        size: 75,
        color: kcPrimaryColor,
      );
}

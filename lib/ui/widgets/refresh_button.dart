import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class RefreshButton extends StatelessWidget {
  final GestureTapCallback? onTap;

  const RefreshButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => Center(child: _buildButton());

  Widget _buildButton() => IconButton(onPressed: onTap, icon: _buildIcon());

  Widget _buildIcon() => const Icon(
        Icons.refresh,
        size: 100,
        color: kcPrimaryColor,
      );
}

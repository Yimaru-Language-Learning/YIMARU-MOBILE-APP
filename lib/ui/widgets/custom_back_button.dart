import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildBackButtonWrapper();

  Widget _buildBackButtonWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildBackIcon(),
      );

  Widget _buildBackIcon() => const Icon(
        Icons.arrow_back,
        color: kcPrimaryColor,
      );
}

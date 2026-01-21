import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

class ObscurePassword extends StatelessWidget {
  final bool focus;
  final bool obscure;
  final GestureTapCallback? onTap;
  const ObscurePassword(
      {super.key, this.onTap, required this.focus, required this.obscure});

  @override
  Widget build(BuildContext context) => _buildButton();

  Widget _buildButton() => GestureDetector(
        onTap: onTap,
        child: _buildIconWrapper(),
      );

  Widget _buildIconWrapper() =>
      obscure ? _buildObscuredIcon() : _buildUnObscuredIcon();

  Widget _buildObscuredIcon() => Icon(
        Icons.visibility,
        color: focus ? kcPrimaryColor : kcLightGrey,
      );

  Widget _buildUnObscuredIcon() => Icon(
        Icons.visibility_off,
        color: focus ? kcPrimaryColor : kcLightGrey,
      );
}

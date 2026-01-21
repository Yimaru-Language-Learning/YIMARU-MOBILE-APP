import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class LoginAccount extends StatelessWidget {
  final GestureTapCallback? onTap;
  const LoginAccount({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildRow();

  Widget _buildRow() => Row(
        children: [
          _buildLeadingText(),
          horizontalSpaceTiny,
          _buildRegisterTextButton()
        ],
      );

  Widget _buildLeadingText() => const Text(
        'Already have an account? ',
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildRegisterTextButton() => TextButton(
        onPressed: onTap,
        style: const ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
        child: _buildRegisterText(),
      );

  Widget _buildRegisterText() => const Text(
        'Login',
        style: TextStyle(color: kcPrimaryColor),
      );
}

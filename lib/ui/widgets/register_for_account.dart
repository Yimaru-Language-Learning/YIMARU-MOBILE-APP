import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class RegisterForAccount extends StatelessWidget {
  final GestureTapCallback? onTap;
  const RegisterForAccount({super.key, this.onTap});

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
        'Don’t have an account? ',
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
        'Register',
        style: TextStyle(color: kcPrimaryColor),
      );
}

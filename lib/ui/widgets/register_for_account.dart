import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

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

  Widget _buildLeadingText() => Text(
        '${LocaleKeys.dont_have_account.tr()} ',
        style: style14MG400,
      );

  Widget _buildRegisterTextButton() => TextButton(
        onPressed: onTap,
        style: const ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: WidgetStatePropertyAll(EdgeInsets.zero)),
        child: _buildRegisterText(),
      );

  Widget _buildRegisterText() => Text(
        LocaleKeys.register.tr(),
        style: style14P400,
      );
}

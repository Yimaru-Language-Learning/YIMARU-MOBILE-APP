import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';
import '../common/ui_helpers.dart';

class OptionTextDivider extends StatelessWidget {
  const OptionTextDivider({super.key});

  @override
  Widget build(BuildContext context) => _buildOrTextWrapper();

  Widget _buildOrTextWrapper() => Row(
        children: [
          _buildDividerWrapper(),
          horizontalSpaceSmall,
          _buildOrText(),
          horizontalSpaceSmall,
          _buildDividerWrapper()
        ],
      );
  Widget _buildDividerWrapper() => Expanded(child: _buildDivider());

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildOrText() => Text(
        LocaleKeys.or.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
      );
}

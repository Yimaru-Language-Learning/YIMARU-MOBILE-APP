import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

class ViewProfileButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  const ViewProfileButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) => _buildButtonWrapper();

  Widget _buildButtonWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildButtonRow(),
      );

  Widget _buildButtonRow() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildButtonText(), const SizedBox(width: 10), _buildButtonIcon()];

  Widget _buildButtonText() => Text(
        LocaleKeys.view_profile.tr(),
        style: style16P900,
      );

  Widget _buildButtonIcon() => const Icon(
        Icons.arrow_forward,
        size: 16,
        color: kcPrimaryColor,
      );
}

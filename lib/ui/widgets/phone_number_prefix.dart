import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class PhoneNumberPrefix extends StatelessWidget {
  final bool selected;
  const PhoneNumberPrefix({
    super.key,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) => _buildButtonWrapper();

  Widget _buildButtonWrapper() => Container(
        height: 57,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: selected ? kcPrimaryColor.withValues(alpha: 0.1) : kcWhite,
          border: Border.all(
            color: selected ? kcPrimaryColor : kcPrimaryColor.withValues(alpha: 0.75),
          ),
        ),
        child: _buildContainerWrapper(),
      );

  Widget _buildContainerWrapper() => Row(
        children: _buildButtonRowChildren(),
      );

  List<Widget> _buildButtonRowChildren() =>
      [_buildIcon(), horizontalSpaceSmall, _buildText()];

  Widget _buildText() => const Text(
        '+251',
        style: TextStyle(color: kcDarkGrey),
      );

  Widget _buildIcon() => Image.asset(
        'assets/icons/flag.png',
      );
}

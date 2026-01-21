import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';

import '../common/app_colors.dart';

class PrivacyPolicyTile extends StatelessWidget {
  final String title;

  const PrivacyPolicyTile({super.key, required this.title});

  IconData _getIcon() {
    if (title == 'Introduction') {
      return Icons.list_alt;
    } else if (title == 'Information We Collect') {
      return Icons.all_inbox;
    } else if (title == 'How We Use Your Information') {
      return Icons.lightbulb_outline;
    } else if (title == 'Data Sharing and Disclosure') {
      return Icons.share;
    } else if (title == 'Your Rights and Choices') {
      return Icons.confirmation_num;
    } else if (title == 'Data Security') {
      return Icons.shield_moon_outlined;
    } else {
      return Iconsax.pen_add;
    }
  }

  @override
  Widget build(BuildContext context) => _buildExpansionTileCard();

  Widget _buildExpansionTileCard() => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: _buildExpansionTile(),
      );

  Widget _buildExpansionTile() => ExpansionTile(
        title: _buildTitle(),
        iconColor: kcDarkGrey,
        textColor: kcDarkGrey,
        leading: _buildIcon(),
        showTrailingIcon: true,
        initiallyExpanded: false,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(15),
        backgroundColor: kcPrimaryColor.withOpacity(0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        collapsedBackgroundColor: kcPrimaryColor.withOpacity(0.1),
        shape: Border.all(color: kcPrimaryColor.withOpacity(0.2)),
        children: _buildExpansionTileChildren(),
      );

  Widget _buildIcon() => Icon(
        _getIcon(),
        color: kcPrimaryColor,
      );

  List<Widget> _buildExpansionTileChildren() => [_buildContent()];

  Widget _buildTitle() => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildContent() => const Text(
        ksPrivacyPolicy,
        style: TextStyle(
          color: kcDarkGrey,
        ),
      );
}

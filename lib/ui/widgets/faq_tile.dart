import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yimaru_app/models/faq.dart';
import 'package:yimaru_app/ui/common/app_strings.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../common/app_colors.dart';

class FaqTile extends StatelessWidget {
  final Faq faq;

  const FaqTile({super.key, required this.faq});



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
        showTrailingIcon: true,
        initiallyExpanded: false,
        collapsedIconColor: kcDarkGrey,
        collapsedTextColor: kcDarkGrey,
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: const EdgeInsets.all(15),
        backgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        controlAffinity: ListTileControlAffinity.trailing,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        tilePadding: const EdgeInsets.symmetric(horizontal: 15),
        collapsedBackgroundColor: kcPrimaryColor.withValues(alpha: 0.1),
        shape: Border.all(color: kcPrimaryColor.withValues(alpha: 0.2)),
        children: _buildExpansionTileChildren(),
      );



  List<Widget> _buildExpansionTileChildren() => [_buildContent()];

  Widget _buildTitle() => Text(
        faq.question ?? '',
        style: style16DG600,
      );

  Widget _buildContent() => Text(
        faq.answer ?? '',
        style: style14DG400,
      );
}

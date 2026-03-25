import 'package:flutter/material.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';

import '../common/ui_helpers.dart';

class CoursePricingCard extends StatelessWidget {
  const CoursePricingCard({super.key});

  @override
  Widget build(BuildContext context) => _buildContainer();

  Widget _buildContainer() => Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kcBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildTile(), verticalSpaceTiny, _buildPriceCardWrapper()];

  Widget _buildTile() => ListTile(
        title: _buildTileTitle(),
        leading: _buildTileLeading(),
        subtitle: _buildTileSubtitle(),
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildTileTitle() => Text(
        'One-Time Unlock',
        style: style16DG600,
      );

  Widget _buildTileSubtitle() =>
      Text('Lifetime access to A2 level', style: style14MG400);

  Widget _buildTileLeading() => const Icon(
        Icons.key,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildPriceCardWrapper() => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.1),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
        child: _buildPriceCard(),
      );

  Widget _buildPriceCard() => ListTile(
        title: _buildPriceCardTitle(),
        subtitle: _buildPriceCardSubtitle(),
        tileColor: kcPrimaryColor.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
      );

  Widget _buildPriceCardTitle() => Text(
        '3,999 ETB',
        style: style16DG600,
      );

  Widget _buildPriceCardSubtitle() => Text(
        'One-time payment',
        style: style14DG400,
      );
}

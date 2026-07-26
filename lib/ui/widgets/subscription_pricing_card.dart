import 'package:flutter/material.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';

class SubscriptionPricingCard extends StatelessWidget {
  final int index;
  final String type;
  final String price;
  final String currency;
  final int selectedIndex;
  final GestureTapCallback? onTap;

  const SubscriptionPricingCard({
    super.key,
    this.onTap,
    required this.type,
    required this.price,
    required this.index,
    required this.currency,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) => _buildContainerWrapper();

  Widget _buildContainerWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildContainer(),
      );

  Widget _buildContainer() => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: selectedIndex == index
              ? kcPrimaryColor.withValues(alpha: 0.1)
              : kcPrimaryColor.withValues(alpha: 0.05),
          border: Border.all(
              width: selectedIndex == index ? 2 : 1,
              color: selectedIndex == index
                  ? kcPrimaryColor.withValues(alpha: 0.5)
                  : kcPrimaryColor.withValues(alpha: 0.25)),
        ),
        child: _buildColumn(),
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildPriceCardTitle(), _buildPriceCardSubtitle()];

  Widget _buildPriceCardTitle() => Text(
        '$price $currency',
        style: style16DG600,
      );

  Widget _buildPriceCardSubtitle() => Text(
        type,
        style: style14DG400,
      );
}

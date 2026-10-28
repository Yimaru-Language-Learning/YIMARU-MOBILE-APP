import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/widgets/subscription_pricing_card.dart';

import '../common/ui_helpers.dart';
import '../views/subscription/subscription_viewmodel.dart';

class SubscriptionPricingSection
    extends ViewModelWidget<SubscriptionViewModel> {
  final String subtitle;
  const SubscriptionPricingSection({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context, SubscriptionViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(SubscriptionViewModel viewModel) => Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: kcBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(SubscriptionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(SubscriptionViewModel viewModel) => [
        _buildTileWrapper(),
        verticalSpaceSmall,
        _buildLearnPriceWrapper(viewModel)
      ];

  Widget _buildTileWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildTile(),
      );

  Widget _buildTile() => ListTile(
        title: _buildTileTitle(),
        leading: _buildTileLeading(),
        subtitle: _buildSubtitle(),
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildTileTitle() => Text(
        'Subscription Plans',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(subtitle, style: style14MG400);

  Widget _buildTileLeading() => const Icon(
        Icons.key,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildLearnPriceWrapper(SubscriptionViewModel viewModel) => Expanded(
        child: _buildLearnPricing(viewModel),
      );

  Widget _buildLearnPricing(SubscriptionViewModel viewModel) =>
      PageView.builder(
        itemCount: viewModel.subscriptions.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) => _buildPriceCard(
          index: index,
          selectedIndex: viewModel.selectedIndex,
          type: viewModel.subscriptions[index].name ?? '',
          onTap: () => viewModel.setSelectedPricing(index),
          currency: viewModel.subscriptions[index].currency ?? '',
          price: viewModel.subscriptions[index].price.toString(),
        ),
      );

  Widget _buildPriceCard(
          {required int index,
          required String type,
          required String price,
          required String currency,
          required int selectedIndex,
          required GestureTapCallback onTap}) =>
      SubscriptionPricingCard(
        type: type,
        onTap: onTap,
        index: index,
        price: price,
        currency: currency,
        selectedIndex: selectedIndex,
      );
}

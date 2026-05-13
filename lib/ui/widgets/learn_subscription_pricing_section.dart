import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/learn_subscription_pricing_card.dart';

import '../common/ui_helpers.dart';

class LearnSubscriptionPricingSection
    extends ViewModelWidget<LearnSubscriptionViewModel> {
  const LearnSubscriptionPricingSection({super.key});

  @override
  Widget build(BuildContext context, LearnSubscriptionViewModel viewModel) =>
      _buildContainer(viewModel);

  Widget _buildContainer(LearnSubscriptionViewModel viewModel) => Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: kcBackgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kcPrimaryColor.withValues(alpha: 0.25)),
        ),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnSubscriptionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(LearnSubscriptionViewModel viewModel) => [
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
        subtitle: _buildTileSubtitle(),
        contentPadding: EdgeInsets.zero,
      );

  Widget _buildTileTitle() => Text(
        'Subscription Plans',
        style: style16DG600,
      );

  Widget _buildTileSubtitle() =>
      Text('This includes Monthly and 3-Month packages', style: style14MG400);

  Widget _buildTileLeading() => const Icon(
        Icons.key,
        size: 35,
        color: kcPrimaryColor,
      );

  Widget _buildLearnPriceWrapper(LearnSubscriptionViewModel viewModel) =>
      Expanded(
        child: _buildLearnPricing(viewModel),
      );

  Widget _buildLearnPricing(LearnSubscriptionViewModel viewModel) =>
      PageView.builder(
        itemCount: viewModel.subscriptions.length,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) => _buildPriceCard(
          index: index,
          selectedIndex: viewModel.selectedIndex,
          type: viewModel.subscriptions[index].name ?? '',
          onTap: () => viewModel.setSelectedPricing(index),
          currency: viewModel.subscriptions[index].currency ?? '',
          price: viewModel.subscriptions[index].price.toString() ?? '',
        ),
      );

  Widget _buildPriceCard(
          {required int index,
          required String type,
          required String price,
          required String currency,
          required int selectedIndex,
          required GestureTapCallback onTap}) =>
      LearnSubscriptionPricingCard(
        type: type,
        price: price,
        onTap: onTap,
        index: index,
        currency: currency,
        selectedIndex: selectedIndex,
      );
}

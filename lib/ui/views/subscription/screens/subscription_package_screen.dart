import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/learn_subscription_card.dart';
import '../../../widgets/subscription_pricing_section.dart';
import '../../../widgets/small_app_bar.dart';
import '../subscription_viewmodel.dart';

class SubscriptionPackageScreen extends ViewModelWidget<SubscriptionViewModel> {
  const SubscriptionPackageScreen({super.key});

  @override
  Widget build(BuildContext context, SubscriptionViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(SubscriptionViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(SubscriptionViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffoldState(viewModel),
      );

  Widget _buildScaffoldState(SubscriptionViewModel viewModel) =>
      viewModel.busy(StateObjects.subscriptions)
          ? const PageLoadingIndicator()
          : _buildScaffold(viewModel);
  Widget _buildScaffold(SubscriptionViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(SubscriptionViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(SubscriptionViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildSubscriptionColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(SubscriptionViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
      );

  Widget _buildSubscriptionColumnWrapper(SubscriptionViewModel viewModel) =>
      Expanded(child: _buildSubscriptionColumnScrollView(viewModel));

  Widget _buildSubscriptionColumnScrollView(SubscriptionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildSubscriptionColumn(viewModel),
      );

  Widget _buildSubscriptionColumn(SubscriptionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSubscriptionColumnChildren(viewModel),
      );

  List<Widget> _buildSubscriptionColumnChildren(
          SubscriptionViewModel viewModel) =>
      [
        verticalSpaceSmall,
        _buildTitleWrapper(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildFirstCard(),
        verticalSpaceMedium,
        _buildSecondCard(),
        verticalSpaceLarge,
        _buildHeadingWrapper(),
        verticalSpaceSmall,
        _buildSubscriptionPricingSection(),
        verticalSpaceMedium,
        _buildSubscribeButton(viewModel),
        verticalSpaceMedium,
        _buildSecurePaymentWrapper()
      ];

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        'Unlock Next Module',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Unlock the next level to keep growing your English skills.',
        style: style14MG400,
      );

  Widget _buildFirstCard() => const LearnSubscriptionCard(
        icon: Icons.school,
        title: '180+ New Lessons',
        subtitle: 'Access fresh, advanced content',
      );

  Widget _buildSecondCard() => const LearnSubscriptionCard(
        icon: Icons.developer_board,
        title: 'Mastery Through Practice',
        subtitle: 'Practice All Lessons, Modules & Levels',
      );

  Widget _buildHeadingWrapper() => Align(
        alignment: Alignment.centerLeft,
        child: _buildHeading(),
      );

  Widget _buildHeading() => Text(
        'Choose Your Learning Plan',
        style: style16DG600,
      );

  Widget _buildSubscriptionPricingSection() =>
      const SubscriptionPricingSection();

  Widget _buildSubscribeButton(SubscriptionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Subscribe Now',
        foregroundColor: kcWhite,
        onTap: () => viewModel.next(),
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildSecurePaymentWrapper() => Align(
        alignment: Alignment.center,
        child: _buildSecurePayment(),
      );

  Widget _buildSecurePayment() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildSecurePaymentChildren(),
      );

  List<Widget> _buildSecurePaymentChildren() =>
      [_buildTileLeading(), horizontalSpaceTiny, _buildTileTitle()];

  Widget _buildTileLeading() => const Icon(
        Icons.lock_outline_rounded,
        size: 16,
        color: kcMediumGrey,
      );

  Widget _buildTileTitle() => Text(
        'Unlock All Lessons & Practices',
        style: style14MG400,
        textAlign: TextAlign.center,
      );
}

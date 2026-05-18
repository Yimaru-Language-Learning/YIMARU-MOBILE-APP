import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/learn_subscription_card.dart';
import '../../../widgets/learn_subscription_pricing_section.dart';
import '../../../widgets/small_app_bar.dart';

class LearnSubscriptionPackageScreen
    extends ViewModelWidget<LearnSubscriptionViewModel> {
  const LearnSubscriptionPackageScreen({super.key});

  @override
  Widget build(BuildContext context, LearnSubscriptionViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnSubscriptionViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnSubscriptionViewModel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffoldState(viewModel),
      );

  Widget _buildScaffoldState(LearnSubscriptionViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubscriptions)
          ? const PageLoadingIndicator()
          : _buildScaffold(viewModel);
  Widget _buildScaffold(LearnSubscriptionViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnSubscriptionViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnSubscriptionViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildSubscriptionColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnSubscriptionViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
      );

  Widget _buildSubscriptionColumnWrapper(
          LearnSubscriptionViewModel viewModel) =>
      Expanded(child: _buildSubscriptionColumnScrollView(viewModel));

  Widget _buildSubscriptionColumnScrollView(
          LearnSubscriptionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildSubscriptionColumn(viewModel),
      );

  Widget _buildSubscriptionColumn(LearnSubscriptionViewModel viewModel) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSubscriptionColumnChildren(viewModel),
      );

  List<Widget> _buildSubscriptionColumnChildren(
          LearnSubscriptionViewModel viewModel) =>
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
      const LearnSubscriptionPricingSection();

  Widget _buildSubscribeButton(LearnSubscriptionViewModel viewModel) =>
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

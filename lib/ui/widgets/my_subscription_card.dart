import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/my_subscription.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/custom_column.dart';

import '../common/app_colors.dart';
import '../common/ui_helpers.dart';
import '../views/my_subscription/my_subscription_viewmodel.dart';
import 'custom_elevated_button.dart';

class MySubscriptionCard extends ViewModelWidget<MySubscriptionViewModel> {
  final GestureTapCallback? onTap;
  final MySubscription subscription;

  const MySubscriptionCard({super.key, this.onTap, required this.subscription});

  String getRemainingDate() {
    final startDate = DateTime.parse(subscription.startsAt ?? '');
    final endDate = DateTime.parse(subscription.expiresAt ?? '');

    final remaining = endDate.difference(startDate);

    return remaining.inDays.toString();
  }

  Future<void> _navigate(
      MySubscriptionViewModel viewModel, BuildContext context) async {
    if (subscription.category == 'LEARN_ENGLISH') {
      await viewModel.navigateToSubscription(SubscriptionType.learn,
          context: context);
    } else if (subscription.category == 'DUOLINGO') {
      await viewModel.navigateToSubscription(SubscriptionType.duolingo,
          context: context);
    } else {
      await viewModel.navigateToSubscription(SubscriptionType.ielts,
          context: context);
    }
  }

  @override
  Widget build(BuildContext context, MySubscriptionViewModel viewModel) =>
      _buildContainer(viewModel, context);

  Widget _buildContainer(
          MySubscriptionViewModel viewModel, BuildContext context) =>
      Container(
        height: 300,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: kcPrimaryColor.withValues(alpha: 0.1),
        ),
        child: _buildColumn(viewModel, context),
      );

  Widget _buildColumn(
          MySubscriptionViewModel viewModel, BuildContext context) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel, context),
      );

  List<Widget> _buildColumnChildren(
          MySubscriptionViewModel viewModel, BuildContext context) =>
      [
        _buildIcon(),
        verticalSpaceSmall,
        _buildTitle(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildStatusSection(viewModel),
        verticalSpaceMedium,
        _buildActionButton(viewModel, context),
      ];

  Widget _buildIcon() => const Icon(
        Icons.menu_book_rounded,
        size: 50,
        color: kcPrimaryColor,
      );

  Widget _buildTitle() => Text(
        subscription.planName ?? '',
        style: style16DG600,
      );

  Widget _buildSubtitle() => Text(
        subscription.status ?? '',
        maxLines: 2,
        style: style14MG400,
      );

  Widget _buildStatusSection(MySubscriptionViewModel viewModel) => Row(
        children: _buildLearningStatusChildren(viewModel),
      );

  List<Widget> _buildLearningStatusChildren(
          MySubscriptionViewModel viewModel) =>
      [
        _buildRemainingDays(viewModel),
        horizontalSpaceSmall,
        _buildTotalDuration(viewModel),
        horizontalSpaceSmall,
        _buildAutoRenew(viewModel),
      ];

  Widget _buildRemainingDays(MySubscriptionViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.subscriptions)
              ? '-'
              : getRemainingDate(),
          subtitle: LocaleKeys.remaining_days.tr()));

  Widget _buildTotalDuration(MySubscriptionViewModel viewModel) => Expanded(
      child: CustomColumn(
          title: viewModel.busy(StateObjects.subscriptions)
              ? '-'
              : '${subscription.durationValue} ${subscription.durationUnit}',
          subtitle: LocaleKeys.duration.tr()));

  Widget _buildAutoRenew(MySubscriptionViewModel viewModel) => Expanded(
        child: CustomColumn(
            title: viewModel.busy(StateObjects.subscriptions)
                ? '-'
                : (subscription.autoRenew ?? false)
                    ? 'Yes'
                    : 'No',
            subtitle: LocaleKeys.auto_renew.tr()),
      );

  Widget _buildActionButton(
          MySubscriptionViewModel viewModel, BuildContext context) =>
      CustomElevatedButton(
          height: 15,
          borderRadius: 12,
          text: LocaleKeys.resubscribe.tr(),
          onTap: subscription.status == 'ACTIVE'
              ? null
              : () async => await _navigate(viewModel, context),
          foregroundColor: kcWhite,
          leadingIcon: Icons.restart_alt,
          backgroundColor: subscription.status == 'ACTIVE'
              ? kcPrimaryColor.withValues(alpha: 0.1)
              : kcPrimaryColor);
}

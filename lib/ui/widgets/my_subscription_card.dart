import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/my_subscription.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../common/app_colors.dart';
import '../views/my_subscription/my_subscription_viewmodel.dart';

class MySubscriptionCard extends ViewModelWidget<MySubscriptionViewModel> {
  final GestureTapCallback? onTap;
  final MySubscription subscription;

  const MySubscriptionCard({super.key, this.onTap, required this.subscription});

  String _getRemainingDays() {
    try {
      final startDate = DateTime.parse(subscription.startsAt ?? '');
      final endDate = DateTime.parse(subscription.expiresAt ?? '');
      return endDate.difference(startDate).inDays.toString();
    } catch (_) {
      return '-';
    }
  }

  String get _durationLabel {
    final val = subscription.durationValue ?? '-';
    return '$val $_durationUnit';
  }

  String get _durationUnit {
    final unit = (subscription.durationUnit ?? '').toLowerCase();
    if (unit == 'month' || unit == 'months') return 'months';
    if (unit == 'year' || unit == 'years') return 'years';
    if (unit == 'day' || unit == 'days') return 'days';
    return unit;
  }

  bool get _isActive => (subscription.status ?? '').toUpperCase() == 'ACTIVE';

  String get _iconAsset {
    final cat = (subscription.category ?? '').toUpperCase();
    if (cat.contains('LEARN')) {
      return 'assets/images/subscription and progress/learn-english-book.svg';
    }
    return 'assets/images/subscription and progress/duolingo-english-test-laptop.svg';
  }

  Color get _iconBg {
    final cat = (subscription.category ?? '').toUpperCase();
    if (cat.contains('LEARN')) return const Color(0xFFF7EBF5);
    return const Color(0xFFE3FADC);
  }

  Future<void> _navigate(MySubscriptionViewModel viewModel) async {
    if (subscription.category == 'LEARN_ENGLISH') {
      await viewModel.navigateToSubscription(SubscriptionType.learn);
    } else if (subscription.category == 'DUOLINGO') {
      await viewModel.navigateToSubscription(SubscriptionType.duolingo);
    } else {
      await viewModel.navigateToSubscription(SubscriptionType.ielts);
    }
  }

  @override
  Widget build(BuildContext context, MySubscriptionViewModel viewModel) =>
      _buildCard(viewModel);

  Widget _buildCard(MySubscriptionViewModel viewModel) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFEEEEF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(),
            const SizedBox(height: 14),
            _buildStatsBox(viewModel),
            const SizedBox(height: 14),
            _buildResubscribeButton(viewModel),
          ],
        ),
      );

  Widget _buildHeaderRow() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconBox(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subscription.planName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Aeonik',
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 4),
                _buildActiveBadge(),
              ],
            ),
          ),
        ],
      );

  Widget _buildIconBox() => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: _iconBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: SvgPicture.asset(
            _iconAsset,
            width: 34,
            height: 34,
            fit: BoxFit.contain,
          ),
        ),
      );

  Widget _buildActiveBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: _isActive
              ? const Color(0xFFE4F8EE)
              : const Color(0xFFFFF0F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          subscription.status ?? '',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            fontFamily: 'Aeonik',
            color: _isActive
                ? const Color(0xFF1F7A52)
                : const Color(0xFFE4002B),
            letterSpacing: 0.4,
          ),
        ),
      );

  Widget _buildStatsBox(MySubscriptionViewModel viewModel) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF8FC),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildStatItem(
              value: viewModel.busy(StateObjects.subscriptions)
                  ? '-'
                  : _getRemainingDays(),
              label: LocaleKeys.remaining_days.tr(),
            ),
            _buildStatItem(
              value: viewModel.busy(StateObjects.subscriptions)
                  ? '-'
                  : _durationLabel,
              label: LocaleKeys.duration.tr(),
            ),
            _buildStatItem(
              value: viewModel.busy(StateObjects.subscriptions)
                  ? '-'
                  : (subscription.autoRenew ?? false) ? 'On' : 'Off',
              label: LocaleKeys.auto_renew.tr(),
            ),
          ],
        ),
      );

  Widget _buildStatItem({required String value, required String label}) =>
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'Aeonik',
                color: AppColors.magenta35,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                fontFamily: 'Aeonik',
                color: Color(0xFF888899),
              ),
            ),
          ],
        ),
      );

  Widget _buildResubscribeButton(MySubscriptionViewModel viewModel) =>
      GestureDetector(
        onTap: _isActive ? null : () async => await _navigate(viewModel),
        child: Container(
          width: double.infinity,
          height: 46,
          decoration: BoxDecoration(
            color: _isActive
                ? const Color(0xFFFAF7FC)
                : AppColors.magenta35,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isActive
                  ? const Color(0xFFEADBEE)
                  : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.refresh_rounded,
                size: 18,
                color: _isActive
                    ? const Color(0xFFA594AA)
                    : AppColors.white,
              ),
              const SizedBox(width: 6),
              Text(
                LocaleKeys.resubscribe.tr(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Aeonik',
                  color: _isActive
                      ? const Color(0xFFA594AA)
                      : AppColors.white,
                ),
              ),
            ],
          ),
        ),
      );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import 'support_viewmodel.dart';

class SupportView extends StackedView<SupportViewModel> {
  const SupportView({Key? key}) : super(key: key);

  @override
  SupportViewModel viewModelBuilder(BuildContext context) => SupportViewModel();

  @override
  Widget builder(
    BuildContext context,
    SupportViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Centered title
                    Text(
                      LocaleKeys.need_help.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.neutral14,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    // Back button anchored left
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: viewModel.pop,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: AppColors.magenta38,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ── Support items ────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      _SupportListTile(
                        iconData: Icons.phone_rounded,
                        iconBgColor: const Color(0xFFFFDDE6),
                        iconColor: const Color(0xFFE91E63),
                        title: LocaleKeys.call_support.tr(),
                        subtitle: LocaleKeys.talk_with_support.tr(),
                        accentColor: const Color(0xFFE91E63),
                        onTap: () async =>
                            await viewModel.navigateToCallSupport(),
                      ),
                      const SizedBox(height: 10),
                      _SupportListTile(
                        iconData: Icons.telegram_rounded,
                        iconBgColor: const Color(0xFFD1ECF9),
                        iconColor: const Color(0xFF28B4CD),
                        title: LocaleKeys.telegram_support.tr(),
                        subtitle: LocaleKeys.chat_via_telegram.tr(),
                        accentColor: const Color(0xFF28B4CD),
                        onTap: () async =>
                            await viewModel.navigateToTelegramSupport(),
                      ),
                      const SizedBox(height: 10),
                      _SupportListTile(
                        iconData: Icons.chat_bubble_outline_rounded,
                        iconBgColor: const Color(0xFFFFF3C4),
                        iconColor: const Color(0xFFF5C542),
                        title: LocaleKeys.in_app_support.tr(),
                        subtitle: LocaleKeys.write_issue_here.tr(),
                        accentColor: const Color(0xFFF5C542),
                        onTap: () async =>
                            await viewModel.navigateToInAppSupport(),
                      ),
                      const SizedBox(height: 10),
                      _SupportListTile(
                        iconData: Icons.help_outline_rounded,
                        iconBgColor: const Color(0xFFD6F5E0),
                        iconColor: const Color(0xFF2ECC71),
                        title: LocaleKeys.faqs.tr(),
                        subtitle: LocaleKeys.visit_faqs.tr(),
                        accentColor: const Color(0xFF2ECC71),
                        onTap: () async => await viewModel.navigateToFaqs(),
                      ),
                      const SizedBox(height: 10),
                      _SupportListTile(
                        iconData: Icons.star_rounded,
                        iconBgColor: const Color(0xFFEBD0E8),
                        iconColor: AppColors.magenta38,
                        title: LocaleKeys.app_rating.tr(),
                        subtitle: LocaleKeys.give_rating.tr(),
                        accentColor: AppColors.magenta38,
                        onTap: () async =>
                            await viewModel.navigateToAppRating(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Private list-tile widget
// ─────────────────────────────────────────────────────────────────────────────

class _SupportListTile extends StatelessWidget {
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final Color accentColor;
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;

  const _SupportListTile({
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.accentColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: iconBgColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              // Colored icon box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconData, size: 22, color: iconColor),
              ),
              const SizedBox(width: 14),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.neutral14,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral40,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                color: accentColor,
                size: 22,
              ),
            ],
          ),
        ),
      );
}

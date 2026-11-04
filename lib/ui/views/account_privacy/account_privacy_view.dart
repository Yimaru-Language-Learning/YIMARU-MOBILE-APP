import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import 'account_privacy_viewmodel.dart';

class AccountPrivacyView extends StackedView<AccountPrivacyViewModel> {
  const AccountPrivacyView({Key? key}) : super(key: key);

  @override
  AccountPrivacyViewModel viewModelBuilder(BuildContext context) =>
      AccountPrivacyViewModel();

  @override
  Widget builder(
    BuildContext context,
    AccountPrivacyViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header: back arrow left + centered title ─────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Centered title
                    Text(
                      LocaleKeys.account_and_privacy.tr(),
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
              // ── Content ─────────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // ── Section: App / language settings ────────────────
                      _SectionHeader(title: LocaleKeys.app_settings.tr()),
                      const SizedBox(height: 10),

                      // Language tile — full lavender/purple tinted background
                      _AccountListTile(
                        iconData: Icons.language_rounded,
                        iconBgColor: const Color(0xFFE8D5F0),
                        iconColor: AppColors.magenta38,
                        tileBgColor: const Color(0xFFF4E8FA),
                        title: LocaleKeys.change_language.tr(),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.neutral82,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                viewModel.selectedLanguage['language'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.neutral27,
                                  fontFamily: 'Aeonik',
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: AppColors.neutral40,
                              size: 20,
                            ),
                          ],
                        ),
                        onTap: () async =>
                            await viewModel.navigateToLanguage(),
                      ),
                      const SizedBox(height: 24),

                      // ── Section: Legal & Info ────────────────────────────
                      _SectionHeader(
                          title: LocaleKeys.legal_and_information.tr()),
                      const SizedBox(height: 10),

                      // Terms tile
                      _AccountListTile(
                        iconData: Icons.description_outlined,
                        iconBgColor: const Color(0xFFFFF3C4),
                        iconColor: const Color(0xFFF5A623),
                        tileBgColor: Colors.white,
                        title: LocaleKeys.terms_and_conditions.tr(),
                        onTap: () async => await viewModel.navigateToTerms(),
                      ),
                      const SizedBox(height: 10),

                      // Privacy tile
                      _AccountListTile(
                        iconData: Icons.shield_outlined,
                        iconBgColor: const Color(0xFFFFDDE6),
                        iconColor: const Color(0xFFE91E63),
                        tileBgColor: Colors.white,
                        title: LocaleKeys.privacy_policy.tr(),
                        onTap: () async =>
                            await viewModel.navigateToPrivacyPolicy(),
                      ),
                      const SizedBox(height: 24),
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
// Private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.neutral14,
          fontFamily: 'Aeonik',
        ),
      );
}

class _AccountListTile extends StatelessWidget {
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final Color tileBgColor;
  final String title;
  final Widget? trailing;
  final GestureTapCallback? onTap;

  const _AccountListTile({
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.tileBgColor,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: tileBgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: iconBgColor.withValues(alpha: 0.8),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon box
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(iconData, size: 20, color: iconColor),
              ),
              const SizedBox(width: 14),
              // Title
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.neutral14,
                    fontFamily: 'Aeonik',
                  ),
                ),
              ),
              // Trailing: custom widget or default chevron
              trailing ??
                  const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: AppColors.neutral40,
                    size: 22,
                  ),
            ],
          ),
        ),
      );
}

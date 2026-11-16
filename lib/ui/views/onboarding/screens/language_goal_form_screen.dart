import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class LanguageGoalFormScreens extends ViewModelWidget<OnboardingViewModel> {
  const LanguageGoalFormScreens({super.key});

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Iconsax.book;
      case 1:
        return Iconsax.microphone;
      case 2:
        return Iconsax.teacher;
    }
    return Iconsax.book;
  }

  String _getSubtitle(int index) {
    switch (index) {
      case 0:
        return LocaleKeys.know_some_english_want_learn.tr();
      case 1:
        return LocaleKeys.already_speak_english_want_practice.tr();
      case 2:
        return LocaleKeys.want_courses_ielts_toefl.tr();
    }
    return '';
  }

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetLanguageGoalFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedLanguageGoal == null) return;

    Map<String, dynamic> data = {
      'language_goal': viewModel.selectedLanguageGoal?.code,
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedLanguageGoal != null;
    final String firstName = viewModel.userData['first_name'] ?? '';

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: '',
      headerExtra: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFFFFECC8),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/mascot/yimi-hello.svg',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Aeonik',
                  color: AppColors.neutral14,
                  height: 1.25,
                ),
                children: [
                  if (firstName.isNotEmpty)
                    TextSpan(
                      text: 'Hi $firstName, ',
                      style: const TextStyle(
                        color: AppColors.magenta38,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  TextSpan(
                    text: LocaleKeys.learning_goal.tr(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      mascotAsset: 'assets/images/mascot/yimi-yay.svg',
      speechText: "Great choice! Practice makes perfect.",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: List.generate(viewModel.languageGoals.length, (index) {
          final option = viewModel.languageGoals[index];
          final bool isSelected = viewModel.isSelectedLanguageGoal(option);

          return OnboardingOptionTile(
            title: option.label ?? '',
            subtitle: _getSubtitle(index),
            isSelected: isSelected,
            isStacked: true,
            leading: Icon(
              _getIcon(index),
              size: 24,
              color: AppColors.magenta38,
            ),
            onTap: () => viewModel.setSelectedLanguageGoal(option),
          );
        }),
      ),
    );
  }
}

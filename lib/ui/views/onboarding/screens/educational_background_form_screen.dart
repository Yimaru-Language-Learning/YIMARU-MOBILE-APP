import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class EducationalBackgroundFormScreen
    extends ViewModelWidget<OnboardingViewModel> {
  const EducationalBackgroundFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetEducationalBackgroundFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedEducationalBackground == null) return;

    Map<String, dynamic> data = {
      'education_level': viewModel.selectedEducationalBackground?.code
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedEducationalBackground != null;

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.educational_background.tr(),
      subtitle: LocaleKeys.education_for_personalization.tr(),
      mascotAsset: 'assets/images/mascot/yimi-thinking.svg',
      speechText: "No wrong answers here!",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: viewModel.educationalBackgrounds.map((option) {
          final bool isSelected = viewModel.isSelectedEducationalBackground(option);
          return OnboardingOptionTile(
            title: option.label ?? '',
            isSelected: isSelected,
            onTap: () => viewModel.setSelectedEducationalBackground(option),
          );
        }).toList(),
      ),
    );
  }
}

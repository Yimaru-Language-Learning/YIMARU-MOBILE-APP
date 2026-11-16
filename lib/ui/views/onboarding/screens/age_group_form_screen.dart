import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class AgeGroupFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const AgeGroupFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetAgeGroupFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedAgeGroup == null) return;

    Map<String, dynamic> data = {'age_group': viewModel.selectedAgeGroup?.code};
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedAgeGroup != null;

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.age_range.tr(),
      subtitle: LocaleKeys.age_for_personalization.tr(),
      mascotAsset: 'assets/images/mascot/yimi-standing.svg',
      speechText: "Learning has no age limit!",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: viewModel.ageGroups.map((option) {
          final bool isSelected = viewModel.isSelectedAgeGroup(option);
          return OnboardingOptionTile(
            title: option.label ?? '',
            isSelected: isSelected,
            onTap: () => viewModel.setSelectedAgeGroup(option),
          );
        }).toList(),
      ),
    );
  }
}

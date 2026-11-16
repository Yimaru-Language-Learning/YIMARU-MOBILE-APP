import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_option_tile.dart';

class GenderFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const GenderFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetGenderFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (viewModel.selectedGender == null) return;

    Map<String, dynamic> data = {'gender': viewModel.selectedGender};
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedGender != null;
    final List<String> genders = viewModel.selectedLanguage['code'] == 'am'
        ? viewModel.gendersAm
        : viewModel.gendersEn;

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.gender.tr(),
      subtitle: LocaleKeys.gender_for_personalization.tr(),
      mascotAsset: 'assets/images/mascot/yimi-hello.svg',
      speechText: "Great to know! Let's keep going.",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        children: genders.map((gender) {
          final bool isSelected = viewModel.isSelectedGender(gender);
          return OnboardingOptionTile(
            title: gender,
            isSelected: isSelected,
            onTap: () => viewModel.setSelectedGender(gender),
          );
        }).toList(),
      ),
    );
  }
}

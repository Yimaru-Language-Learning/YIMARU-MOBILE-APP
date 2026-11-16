import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/field_option.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/views/onboarding/widgets/onboarding_layout.dart';
import 'package:yimaru_app/ui/widgets/custom_dropdown.dart';
import '../onboarding_view.form.dart';

class CountryRegionFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController regionController;

  const CountryRegionFormScreen({super.key, required this.regionController});

  void _setSelectedCountry({
    FieldOption? value,
    required OnboardingViewModel viewModel,
  }) {
    viewModel.setSelectedCountry(value);
    if (viewModel.selectedCountry?.label?.toLowerCase().tr() != 'ethiopia') {
      regionController.clear();
      viewModel.unsetRegionFocus();
    }
  }

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetCountryRegionFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'region': viewModel.dropdownRegion
          ? viewModel.selectedRegion?.code
          : regionController.text,
      'country': viewModel.selectedCountry?.code,
    };
    viewModel.addUserData(data);
    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) {
    final bool canContinue = viewModel.selectedCountry != null &&
        (!viewModel.dropdownRegion
            ? regionController.text.isNotEmpty
            : viewModel.selectedRegion != null);

    return OnboardingLayout(
      showBackButton: true,
      onBack: () => _pop(viewModel),
      onLanguage: () async => await viewModel.navigateToLanguage(),
      languageCode: viewModel.selectedLanguage['code'],
      title: LocaleKeys.location.tr(),
      subtitle: LocaleKeys.select_country_region.tr(),
      mascotAsset: 'assets/images/mascot/yimi-hello.svg',
      speechText: "I'm from wherever you are!",
      continueText: LocaleKeys.cont.tr(),
      canContinue: canContinue,
      onContinue: () async => await _next(viewModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Country Dropdown
          CustomDropdownPicker(
            hint: LocaleKeys.select_country.tr(),
            selectedItem: viewModel.selectedCountry,
            items: (value, props) => viewModel.countries,
            onChanged: (value) => _setSelectedCountry(
              value: value,
              viewModel: viewModel,
            ),
          ),
          const SizedBox(height: 16),

          // Region Dropdown or Text Field
          if (viewModel.dropdownRegion)
            CustomDropdownPicker(
              hint: LocaleKeys.select_region.tr(),
              selectedItem: viewModel.selectedRegion,
              items: (value, props) => viewModel.regions,
              onChanged: (value) => viewModel.setSelectedRegion(value),
            )
          else ...[
            TextFormField(
              controller: regionController,
              onTap: viewModel.setRegionFocus,
              onChanged: (val) => viewModel.rebuildUi(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.neutral14,
                fontFamily: 'Aeonik',
              ),
              decoration: InputDecoration(
                hintText: LocaleKeys.enter_your_city.tr(),
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.neutral40.withValues(alpha: 0.6),
                  fontFamily: 'Aeonik',
                ),
                filled: true,
                fillColor: const Color(0xFFFAFAFA),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.neutral84.withValues(alpha: 0.7),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(
                    color: AppColors.neutral84.withValues(alpha: 0.7),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: AppColors.magenta38,
                    width: 1.5,
                  ),
                ),
              ),
            ),
            if (viewModel.hasRegionValidationMessage && viewModel.focusRegion) ...[
              const SizedBox(height: 6),
              Text(
                viewModel.regionValidationMessage!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE53935),
                  fontFamily: 'Aeonik',
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

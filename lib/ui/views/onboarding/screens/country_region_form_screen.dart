import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_dropdown.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class CountryRegionFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const CountryRegionFormScreen({super.key});

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'country': viewModel.selectedCountry,
      'region': viewModel.selectedRegion
    };
    viewModel.addUserData(data);

    viewModel.next();
  }

  @override
  Widget build(BuildContext context, OnboardingViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(OnboardingViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildScaffoldChildren(viewModel),
      );

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) =>
      [_buildAppBar(viewModel), _buildExpandedBody(viewModel)];

  Widget _buildExpandedBody(OnboardingViewModel viewModel) =>
      Expanded(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildBody(viewModel),
      );

  Widget _buildBody(OnboardingViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(OnboardingViewModel viewModel) =>
      [_buildColumnScroller(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildColumnScroller(OnboardingViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildUpperColumn(viewModel),
      );

  Widget _buildUpperColumn(OnboardingViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(OnboardingViewModel viewModel) => [
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubTitle(),
        verticalSpaceMedium,
        _buildCountryDropDown(viewModel),
        verticalSpaceMedium,
        _buildRegionDropDown(viewModel),
        verticalSpaceMedium,
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        onPop: viewModel.pop,
        showBackButton: true,
        showLanguageSelection: true,
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle() => const Text(
        'Where are you from?',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubTitle() => const Text(
        'Select your country and region from the dropdown',
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildCountryDropDown(OnboardingViewModel viewModel) =>
      CustomDropdownPicker(
          hint: 'Select country',
          icon: _buildSearchIcon(),
          selectedItem: viewModel.selectedCountry,
          items: (value, props) => viewModel.getCountries(),
          onChanged: (value) =>
              viewModel.setSelectedCountry(value ?? 'Ethiopia'));

  Widget _buildRegionDropDown(OnboardingViewModel viewModel) =>
      CustomDropdownPicker(
        hint: 'Select region',
        icon: _buildSearchIcon(),
        selectedItem: viewModel.selectedRegion,
        items: (value, props) =>
            viewModel.getRegions(viewModel.selectedCountry),
        onChanged: (value) =>
            viewModel.setSelectedRegion(value ?? 'Addis Ababa'),
      );

  Icon _buildSearchIcon() => const Icon(
        Icons.search,
        color: kcPrimaryColor,
      );

  Widget _buildContinueButtonWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(OnboardingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        text: 'Continue',
        borderRadius: 12,
        foregroundColor: kcWhite,
        onTap: () => _next(viewModel),
        backgroundColor: kcPrimaryColor,
      );
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_dropdown.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';
import '../onboarding_view.form.dart';

class CountryRegionFormScreen extends ViewModelWidget<OnboardingViewModel> {
  final TextEditingController regionController;
  const CountryRegionFormScreen({super.key, required this.regionController});

  void _setSelectedCountry(
      {String? value, required OnboardingViewModel viewModel}) {
    viewModel.setSelectedCountry(value ?? 'Ethiopia');

    if (viewModel.selectedCountry != 'Ethiopia') {
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
          ? viewModel.selectedRegion
          : regionController.text,
      'country': viewModel.selectedCountry,
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

  List<Widget> _buildScaffoldChildren(OnboardingViewModel viewModel) => [
        _buildAppBar(viewModel),
        verticalSpaceMedium,
        _buildExpandedBody(viewModel)
      ];

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
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildCountryDropDown(viewModel),
        verticalSpaceMedium,
        _buildRegionFormState(viewModel),
        if (viewModel.hasRegionValidationMessage &&
            !viewModel.dropdownRegion &&
            viewModel.focusRegion)
          verticalSpaceTiny,
        if (viewModel.hasRegionValidationMessage &&
            !viewModel.dropdownRegion &&
            viewModel.focusRegion)
          _buildRegionValidatorWrapper(viewModel)
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _pop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTitle() => Text(
        'Where are you from?',
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        'Select your country and region from the dropdown',
        style: style14MG400,
      );

  Widget _buildCountryDropDown(OnboardingViewModel viewModel) =>
      CustomDropdownPicker(
          hint: 'Select country',
          icon: _buildSearchIcon(),
          selectedItem: viewModel.selectedCountry,
          items: (value, props) => viewModel.getCountries(),
          onChanged: (value) =>
              _setSelectedCountry(value: value, viewModel: viewModel));

  Widget _buildRegionFormState(OnboardingViewModel viewModel) =>
      viewModel.dropdownRegion
          ? _buildRegionDropDown(viewModel)
          : _buildRegionFormField(viewModel);

  Widget _buildRegionDropDown(OnboardingViewModel viewModel) =>
      CustomDropdownPicker(
          hint: 'Select region',
          icon: _buildSearchIcon(),
          selectedItem: viewModel.selectedRegion,
          items: (value, props) => viewModel.getRegions(),
          onChanged: (value) =>
              viewModel.setSelectedRegion(value ?? 'Addis Ababa'));

  Widget _buildRegionFormField(OnboardingViewModel viewModel) => TextFormField(
        controller: regionController,
        onTap: viewModel.setRegionFocus,
        decoration: inputDecoration(
            hint: 'Enter Your City',
            focus: viewModel.focusRegion,
            filled: regionController.text.isNotEmpty),
      );

  Widget _buildRegionValidatorWrapper(OnboardingViewModel viewModel) =>
      viewModel.hasRegionValidationMessage
          ? _buildRegionValidator(viewModel)
          : Container();

  Widget _buildRegionValidator(OnboardingViewModel viewModel) => Text(
        viewModel.regionValidationMessage!,
        style: style12R700,
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
        onTap: !viewModel.dropdownRegion
            ? regionController.text.isNotEmpty
                ? () => _next(viewModel)
                : null
            : () => _next(viewModel),
        backgroundColor: !viewModel.dropdownRegion
            ? regionController.text.isNotEmpty
                ? kcPrimaryColor
                : kcPrimaryColor.withOpacity(0.1)
            : kcPrimaryColor,
      );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_small_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class GenderFormScreen extends ViewModelWidget<OnboardingViewModel> {
  const GenderFormScreen({super.key});

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetGenderFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {'gender': viewModel.selectedGender};
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
      [_buildUpperColumn(viewModel), _buildContinueButtonWrapper(viewModel)];

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
        _buildAgeGroups(viewModel)
      ];

  Widget _buildAppBar(OnboardingViewModel viewModel) => LargeAppBar(
        showBackButton: true,
        showLanguageSelection: true,
        onPop: () => _pop(viewModel),
        onLanguage: () async => await viewModel.navigateToLanguage(),
        language: viewModel.selectedLanguage['code'] == 'am'
            ? 'አማ'
            : viewModel.selectedLanguage['code'],
      );

  Widget _buildTitle() => Text(
        LocaleKeys.choose_your_gender.tr(),
        style: style25DG600,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.gender_for_personalization.tr(),
        style: style14MG400,
      );

  Widget _buildAgeGroups(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.selectedLanguage['code'] == 'am'
            ? viewModel.gendersAm.length
            : viewModel.gendersEn.length,
        itemBuilder: (context, index) => _buildAgeGroup(
          selected: viewModel.isSelectedGender(
              viewModel.selectedLanguage['code'] == 'am'
                  ? viewModel.gendersAm[index]
                  : viewModel.gendersEn[index]),
          onTap: () => viewModel.setSelectedGender(
              viewModel.selectedLanguage['code'] == 'am'
                  ? viewModel.gendersAm[index]
                  : viewModel.gendersEn[index]),
          title: viewModel.selectedLanguage['code'] == 'am'
              ? viewModel.gendersAm[index]
              : viewModel.gendersEn[index],
        ),
      );

  Widget _buildAgeGroup(
          {required String title,
          required bool selected,
          required GestureTapCallback onTap}) =>
      CustomSmallRadioButton(
        title: title,
        onTap: onTap,
        selected: selected,
      );

  Widget _buildContinueButtonWrapper(OnboardingViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(OnboardingViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.cont.tr(),
        backgroundColor: viewModel.selectedGender != null
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
        onTap: viewModel.selectedGender != null ? () => _next(viewModel) : null,
      );
}

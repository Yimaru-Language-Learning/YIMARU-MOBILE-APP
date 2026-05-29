import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_elevated_button.dart';
import 'package:yimaru_app/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/custom_large_radio_button.dart';
import 'package:yimaru_app/ui/widgets/large_app_bar.dart';

class LanguageGoalFormScreens extends ViewModelWidget<OnboardingViewModel> {
  const LanguageGoalFormScreens({super.key});

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Iconsax.book;
      case 1:
        return Iconsax.microphone;
      case 2:
        return Iconsax.bag;
    }
    return Icons.book;
  }



  String getSubtitle(int index) {
    switch (index) {
      case 0:
        return 'I know some English, but i want to learn to speak it';
      case 1:
        return 'I already speak English, but I want more practice.';
      case 2:
        return 'I want courses for IELTS, TOEFL, Duolingo, or work';
    }
    return '';
  }

  void _pop(OnboardingViewModel viewModel) {
    viewModel.resetLanguageGoalFormScreen();
    viewModel.goBack();
  }

  Future<void> _next(OnboardingViewModel viewModel) async {
    FocusManager.instance.primaryFocus?.unfocus();

    Map<String, dynamic> data = {
      'language_goal': viewModel.selectedLanguageGoal?.code,

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
        _buildExpandedBody(viewModel)
      ];

  Widget _buildExpandedBody(OnboardingViewModel viewModel) =>
      Expanded(child: _buildBodyScroller(viewModel));

  Widget _buildBodyScroller(OnboardingViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildBodyWrapper(viewModel),
      );

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
        verticalSpaceLarge,
        _buildTitle(viewModel),
        verticalSpaceMedium,
        _buildLanguageGoals(viewModel)
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

  Widget _buildTitle(OnboardingViewModel viewModel) => Text.rich(
        TextSpan(
            text:
                '${LocaleKeys.hello.tr()} ${viewModel.userData['first_name']},',
            style: style18P600.copyWith(fontSize: 22),
            children: [
              TextSpan(
                text: ' ${LocaleKeys.language_goal.tr()}',
                style: style16DG600.copyWith(fontSize: 22),
              )
            ]),
      );

  Widget _buildLanguageGoals(OnboardingViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount:  viewModel.languageGoals.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildLanguageGoal(
          icon: getIcon(index),
          subtitle: getSubtitle(index),
          title:viewModel.languageGoals[index].label ?? '',
          selected:
              viewModel.isSelectedLanguageGoal(viewModel.languageGoals[index]),
          onTap: () =>
              viewModel.setSelectedLanguageGoal(viewModel.languageGoals[index]),
        ),
      );

  Widget _buildLanguageGoal(
          {required String title,
          required bool selected,
          required IconData icon,
          required String subtitle,
          required GestureTapCallback onTap}) =>
      CustomLargeRadioButton(
        icon: icon,
        title: title,
        onTap: onTap,
        subtitle: subtitle,
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
        onTap: viewModel.selectedLanguageGoal != null
            ? () => _next(viewModel)
            : null,
        backgroundColor: viewModel.selectedLanguageGoal != null
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
      );
}

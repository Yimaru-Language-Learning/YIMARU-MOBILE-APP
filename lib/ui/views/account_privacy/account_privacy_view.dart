import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/custom_list_tile.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'account_privacy_viewmodel.dart';
import '../../widgets/retryable_content.dart';

class AccountPrivacyView extends StackedView<AccountPrivacyViewModel> {
  @override
  void onViewModelReady(AccountPrivacyViewModel viewModel) {
    viewModel.loadReminders();
  }

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
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(AccountPrivacyViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(AccountPrivacyViewModel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(AccountPrivacyViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(AccountPrivacyViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(AccountPrivacyViewModel viewModel) =>
      _buildColumn(viewModel);

  Widget _buildColumn(AccountPrivacyViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(AccountPrivacyViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(AccountPrivacyViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(AccountPrivacyViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.account_and_privacy.tr(),
      );

  Widget _buildContentWrapper(AccountPrivacyViewModel viewModel) =>
      Expanded(child: _buildContentColumnWrapper(viewModel));

  Widget _buildContentColumnWrapper(AccountPrivacyViewModel viewModel) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildContentColumn(viewModel),
      );

  Widget _buildContentColumn(AccountPrivacyViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(AccountPrivacyViewModel viewModel) => [
        Expanded(child: _buildMenuColumnScrollView(viewModel)),
        // _buildDeleteButtonWrapper()
      ];

  Widget _buildMenuColumnScrollView(AccountPrivacyViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildMenuColumn(viewModel),
      );

  Widget _buildMenuColumn(AccountPrivacyViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildMenuColumnChildren(viewModel),
      );

  List<Widget> _buildMenuColumnChildren(AccountPrivacyViewModel viewModel) => [
        verticalSpaceLarge,
        _buildHeader(LocaleKeys.app_settings.tr()),
        verticalSpaceSmall,
        _buildLanguageMenu(viewModel),
        RetryableContent(
          isLoading: viewModel.busy(AccountPrivacyViewModel.reminderLoadKey),
          hasError:
              viewModel.hasErrorForKey(AccountPrivacyViewModel.reminderLoadKey),
          onRetry: viewModel.loadReminders,
          builder: () => Column(mainAxisSize: MainAxisSize.min, children: [
            SwitchListTile.adaptive(
              title: Text(LocaleKeys.automated_reminders.tr()),
              subtitle: Text(LocaleKeys.automated_reminders_description.tr()),
              value: viewModel.remindersEnabled ?? false,
              onChanged: viewModel.remindersEnabled == null ||
                      viewModel.busy(AccountPrivacyViewModel.reminderSaveKey)
                  ? null
                  : viewModel.setReminders,
            ),
            if (viewModel
                .hasErrorForKey(AccountPrivacyViewModel.reminderSaveKey))
              Text(LocaleKeys.reminder_save_failed.tr(),
                  style: const TextStyle(color: kcRed)),
          ]),
        ),
        _buildDividerWrapper(),
        verticalSpaceMedium,
        _buildHeader(LocaleKeys.legal_and_information.tr()),
        verticalSpaceSmall,
        _buildTermsAndConditionsMenu(viewModel),
        _buildPrivacyPolicy(viewModel),
        _buildDividerWrapper(),
      ];

  Widget _buildHeader(String title) => Text(
        title,
        style: style18DG700,
      );

  Widget _buildLanguageMenu(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        isLanguage: true,
        icon: Icons.language,
        title: LocaleKeys.change_language.tr(),
        language: viewModel.selectedLanguage['language'],
        onTap: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTermsAndConditionsMenu(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        icon: Icons.handshake,
        title: LocaleKeys.terms_and_conditions.tr(),
        onTap: () async => await viewModel.navigateToTerms(),
      );

  Widget _buildPrivacyPolicy(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        icon: Icons.shield_moon_outlined,
        title: LocaleKeys.privacy_policy.tr(),
        onTap: () async => await viewModel.navigateToPrivacyPolicy(),
      );

  Widget _buildDividerWrapper() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _buildDivider(),
      );

  Widget _buildDivider() => const Divider(color: kcVeryLightGrey);

  Widget _buildDeleteButtonWrapper() => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildDeleteButton(),
      );
  Widget _buildDeleteButton() => CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcRed,
        text: LocaleKeys.delete_account.tr(),
        backgroundColor: kcRed.withValues(alpha: 0.25),
      );
}

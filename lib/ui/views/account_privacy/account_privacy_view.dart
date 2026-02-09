import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/custom_list_tile.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'account_privacy_viewmodel.dart';

class AccountPrivacyView extends StackedView<AccountPrivacyViewModel> {
  const AccountPrivacyView({Key? key}) : super(key: key);

  @override
  AccountPrivacyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
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
        body: _buildScaffold(viewModel),
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
        title: 'Account Privacy',
        onTap: viewModel.pop,
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

  List<Widget> _buildContentChildren(AccountPrivacyViewModel viewModel) =>
      [_buildMenuColumnScrollView(viewModel), _buildDeleteButtonWrapper()];

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
        _buildHeader('App Settings'),
        verticalSpaceSmall,
        _buildLanguageMenu(viewModel),
        _buildDividerWrapper(),
        verticalSpaceMedium,
        _buildHeader('Legal & Information'),
        verticalSpaceSmall,
        _buildTermsAndConditionsMenu(viewModel),
        _buildPrivacyPolicy(viewModel),
        _buildDividerWrapper(),
      ];

  Widget _buildHeader(String title) => Text(
        title,
        style: style18DG600,
      );

  Widget _buildLanguageMenu(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        isLanguage: true,
        language: 'English',
        icon: Icons.language,
        title: 'Change Language',
        onTap: () async => await viewModel.navigateToLanguage(),
      );

  Widget _buildTermsAndConditionsMenu(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        icon: Icons.handshake,
        title: 'Terms & Conditions',
        onTap: () async => await viewModel.navigateToTerms(),
      );

  Widget _buildPrivacyPolicy(AccountPrivacyViewModel viewModel) =>
      CustomListTile(
        icon: Icons.shield_moon_outlined,
        title: 'Privacy Policy',
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
        text: 'Delete Account',
        borderRadius: 12,
        foregroundColor: kcRed,
        backgroundColor: kcRed.withOpacity(0.25),
      );
}

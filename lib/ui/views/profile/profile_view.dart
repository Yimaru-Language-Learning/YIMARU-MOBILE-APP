import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/profile_card.dart';
import 'package:yimaru_app/ui/widgets/profile_image.dart';
import 'package:yimaru_app/ui/widgets/view_profile_button.dart';

import '../../widgets/custom_elevated_button.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(ProfileViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(ProfileViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(ProfileViewModel viewModel) => SingleChildScrollView(
        child: _buildBody(viewModel),
      );

  Widget _buildBody(ProfileViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(ProfileViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildNotificationIconWrapper(),
          _buildProfileSection(),
          verticalSpaceSmall,
          _buildViewProfileButton(viewModel),
          verticalSpaceLarge,
          _buildSettingsSection(viewModel),
          verticalSpaceLarge,
          _buildLogOutButton(viewModel),
          verticalSpaceLarge,
        ],
      );

  Widget _buildNotificationIconWrapper() =>
      Align(alignment: Alignment.bottomRight, child: _buildNotificationIcon());

  Widget _buildNotificationIcon() => const Icon(
        Icons.notifications_none,
        color: kcDarkGrey,
      );

  Widget _buildProfileSection() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildProfileSectionChildren(),
      );

  List<Widget> _buildProfileSectionChildren() => [
        _buildProfileImage(),
        verticalSpaceSmall,
        _buildProfileName(),
      ];

  Widget _buildProfileImage() => const ProfileImage();

  Widget _buildProfileName() => const Text(
        'Hi, Bisrat 👋',
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildViewProfileButton(ProfileViewModel viewModel) =>
      ViewProfileButton(
        onTap: () async => await viewModel.navigateToProfileDetail(),
      );

  Widget _buildSettingsSection(ProfileViewModel viewModel) => GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 15, crossAxisSpacing: 15),
      children: _buildSettingsChildren(viewModel));

  List<Widget> _buildSettingsChildren(ProfileViewModel viewModel) => [
        _buildDownloadsCard(viewModel),
        _buildProgressCard(viewModel),
        _buildAccountCard(viewModel),
        _buildSupportCard(viewModel)
      ];

  Widget _buildDownloadsCard(ProfileViewModel viewModel) => ProfileCard(
        icon: Icons.download,
        title: 'My Downloads',
        subTitle: 'Access offline lessons and saved videos',
        onTap: () async => await viewModel.navigateToDownloads(),
      );

  Widget _buildProgressCard(ProfileViewModel viewModel) => ProfileCard(
        title: 'My Progress',
        icon: Icons.stacked_bar_chart,
        subTitle: 'Track your achievements and learning streak',
        onTap: () async => await viewModel.navigateToProgress(),
      );

  Widget _buildAccountCard(ProfileViewModel viewModel) => ProfileCard(
        title: 'Account & Privacy',
        icon: Icons.privacy_tip_outlined,
        subTitle: 'Manage setting and app preference',
        onTap: () async => await viewModel.navigateToAccountPrivacy(),
      );

  Widget _buildSupportCard(ProfileViewModel viewModel) => ProfileCard(
        title: 'Support',
        icon: Icons.headphones,
        subTitle: 'Get help through phone or Telegram',
        onTap: () async => await viewModel.navigateToSupport(),
      );

  Widget _buildLogOutButton(ProfileViewModel viewModel) => CustomElevatedButton(
        height: 55,
        text: 'Log Out',
        borderRadius: 12,
        foregroundColor: kcRed,
        onTap: () async => await viewModel.logOut(),
        backgroundColor: kcRed.withOpacity(0.25),
      );
}

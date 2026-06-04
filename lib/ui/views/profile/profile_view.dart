import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/notification_icon.dart';
import 'package:yimaru_app/ui/widgets/profile_card.dart';
import 'package:yimaru_app/ui/widgets/profile_image.dart';
import 'package:yimaru_app/ui/widgets/view_profile_button.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/image_picker_option.dart';
import 'profile_viewmodel.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  Future<void> _showImagePicker(
          {required BuildContext context,
          required ProfileViewModel viewModel}) async =>
      await showDialog(
        context: context,
        builder: (context) =>
            _showImagePickerDialog(context: context, viewModel: viewModel),
      );

  AlertDialog _showImagePickerDialog(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      AlertDialog(
        backgroundColor: Colors.transparent,
        content: _buildImagePicker(context: context, viewModel: viewModel),
      );

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
      _buildScaffoldWrapper(context: context, viewModel: viewModel);

  Widget _buildScaffoldWrapper(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(context: context, viewModel: viewModel),
      );

  Widget _buildScaffoldContainer(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(context: context, viewModel: viewModel),
      );

  Widget _buildScaffold(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      SafeArea(
          child: _buildBodyWrapper(context: context, viewModel: viewModel));

  Widget _buildBodyWrapper(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      SingleChildScrollView(
        child: _buildBody(context: context, viewModel: viewModel),
      );

  Widget _buildBody(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(context: context, viewModel: viewModel),
      );

  Widget _buildColumn(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      Column(
        children: [
          verticalSpaceSmall,
          verticalSpaceMedium,
          _buildNotificationIconWrapper(viewModel),
          _buildProfileSection(context: context, viewModel: viewModel),
          verticalSpaceSmall,
          _buildViewProfileButton(viewModel),
          verticalSpaceLarge,
          _buildSettingsSection(viewModel),
          verticalSpaceLarge,
          _buildLogOutButton(viewModel),
          verticalSpaceLarge,
        ],
      );

  Widget _buildNotificationIconWrapper(ProfileViewModel viewModel) =>
      NotificationIcon(
        count: viewModel.unreadCount.toString(),
        onTap: () async => await viewModel.navigateToNotification(),
      );

  Widget _buildProfileSection(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildProfileSectionChildren(
            context: context, viewModel: viewModel),
      );

  List<Widget> _buildProfileSectionChildren(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      [
        _buildProfileImage(context: context, viewModel: viewModel),
        verticalSpaceSmall,
        _buildProfileName(viewModel),
      ];

  Widget _buildProfileImage(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      ProfileImage(
        profileImage: viewModel.user?.profilePicture,
        loading: viewModel.busy(StateObjects.profileImage) ? true : false,
        onTap: () async =>
            await _showImagePicker(context: context, viewModel: viewModel),
      );

  Widget _buildImagePicker(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      ImagePickerOption(
        onCameraTap: () async => await viewModel.openCamera(),
        onGalleryTap: () async => await viewModel.openGallery(),
      );

  Widget _buildProfileName(ProfileViewModel viewModel) => Text(
        '${LocaleKeys.hello.tr()}, ${viewModel.user?.firstName ?? ''} 👋',
        style: style25DG600,
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
        //  _buildDownloadsCard(viewModel),
        _buildProgressCard(viewModel),
        _buildAccountCard(viewModel),
        _buildSupportCard(viewModel)
      ];

  Widget _buildDownloadsCard(ProfileViewModel viewModel) => ProfileCard(
        icon: Icons.download,
        title: 'My Downloads',
        subtitle: 'Access offline lessons and saved videos',
        onTap: () async => await viewModel.navigateToDownloads(),
      );

  Widget _buildProgressCard(ProfileViewModel viewModel) => ProfileCard(
        icon: Icons.stacked_bar_chart,
        title: LocaleKeys.my_progress.tr(),
        subtitle: LocaleKeys.track_your_achievement.tr(),
        onTap: () async => await viewModel.navigateToProgress(),
      );

  Widget _buildAccountCard(ProfileViewModel viewModel) => ProfileCard(
        icon: Icons.privacy_tip_outlined,
        subtitle: LocaleKeys.manage_settings.tr(),
        title: LocaleKeys.account_and_privacy.tr(),
        onTap: () async => await viewModel.navigateToAccountPrivacy(),
      );

  Widget _buildSupportCard(ProfileViewModel viewModel) => ProfileCard(
        icon: Icons.headphones,
        title: LocaleKeys.support.tr(),
        subtitle: LocaleKeys.get_help.tr(),
        onTap: () async => await viewModel.navigateToSupport(),
      );

  Widget _buildLogOutButton(ProfileViewModel viewModel) => CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcRed,
        text: LocaleKeys.logout.tr(),
        backgroundColor: kcRed.withOpacity(0.25),
        onTap: () async => await viewModel.logout(),
      );
}

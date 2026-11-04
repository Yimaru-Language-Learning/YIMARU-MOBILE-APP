import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/notification_icon.dart';

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
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) =>
      Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ── Illustrated header section ──────────────────────────
                _buildHeaderSection(context: context, viewModel: viewModel),
                // ── Cards + logout below header ─────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      _buildSettingsGrid(viewModel),
                      const SizedBox(height: 24),
                      _buildLogOutButton(viewModel),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  // ── Illustrated header ──────────────────────────────────────────────────

  Widget _buildHeaderSection(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      SizedBox(
        height: 310,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Lavender curved background SVG
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/images/10-profile-and-settings/10.1-profile-tab-01.svg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            // Notification bell — top right
            Positioned(
              top: 16,
              right: 20,
              child: NotificationIcon(
                count: viewModel.unreadCount.toString(),
                onTap: () async => await viewModel.navigateToNotification(),
              ),
            ),
            // Avatar + name + link — centred
            Positioned(
              left: 0,
              right: 0,
              top: 60,
              child: Column(
                children: [
                  // Yellow circle avatar with purple person + camera edit button
                  GestureDetector(
                    onTap: () async => await _showImagePicker(
                        context: context, viewModel: viewModel),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Yellow avatar circle
                        Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF5C542),
                          ),
                          child: _buildAvatarContent(viewModel),
                        ),
                        // Camera edit pill — bottom centre of avatar
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.magenta38,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Name
                  Text(
                    '${viewModel.user?.firstName ?? 'ሰላምሮ'} Demo',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral14,
                      fontFamily: 'Aeonik',
                    ),
                  ),
                  const SizedBox(height: 6),
                  // "View profile →" link
                  GestureDetector(
                    onTap: () async =>
                        await viewModel.navigateToProfileDetail(),
                    child: Text(
                      '${LocaleKeys.view_profile.tr()} →',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.magenta38,
                        fontFamily: 'Aeonik',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildAvatarContent(ProfileViewModel viewModel) {
    final pic = viewModel.user?.profilePicture;
    final hasImage = pic != null &&
        pic.isNotEmpty &&
        pic.contains('.') &&
        pic != 'empty_image_path';
    if (viewModel.busy(StateObjects.profileImage)) {
      return const CircularProgressIndicator(color: AppColors.magenta38);
    }
    if (hasImage) {
      return ClipOval(
        child: Image.file(
          File(pic),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
      );
    }
    // Default: purple person silhouette SVG
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: SvgPicture.asset(
        'assets/images/10-profile-and-settings/10.1-profile-tab-02.svg',
        width: 64,
        height: 64,
      ),
    );
  }

  Widget _buildImagePicker(
          {required BuildContext context,
          required ProfileViewModel viewModel}) =>
      ImagePickerOption(
        onCameraTap: () async => await viewModel.openCamera(),
        onGalleryTap: () async => await viewModel.openGallery(),
      );

  // ── 2×2 Grid ───────────────────────────────────────────────────────────────

  Widget _buildSettingsGrid(ProfileViewModel viewModel) => GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.95,
        ),
        children: _buildSettingsChildren(viewModel),
      );

  List<Widget> _buildSettingsChildren(ProfileViewModel viewModel) => [
        if (!Platform.isIOS) _buildSubscriptionCard(viewModel),
        _buildProgressCard(viewModel),
        _buildAccountCard(viewModel),
        _buildSupportCard(viewModel),
      ];

  Widget _buildSubscriptionCard(ProfileViewModel viewModel) => _ProfileGridCard(
        iconData: Icons.download_rounded,
        iconBgColor: const Color(0xFFFFF3C4),
        iconColor: const Color(0xFFF5C542),
        cardBgColor: const Color(0xFFFFFBEE),
        title: LocaleKeys.my_subscriptions.tr(),
        subtitle: LocaleKeys.active_all_subscriptions.tr(),
        onTap: () async => await viewModel.navigateToMySubscription(),
      );

  Widget _buildProgressCard(ProfileViewModel viewModel) => _ProfileGridCard(
        iconData: Icons.stacked_bar_chart_rounded,
        iconBgColor: const Color(0xFFD6F5E0),
        iconColor: const Color(0xFF2ECC71),
        cardBgColor: const Color(0xFFF0FBF4),
        title: LocaleKeys.my_progress.tr(),
        subtitle: LocaleKeys.track_your_achievement.tr(),
        onTap: () async => await viewModel.navigateToMyProgress(),
      );

  Widget _buildAccountCard(ProfileViewModel viewModel) => _ProfileGridCard(
        iconData: Icons.shield_outlined,
        iconBgColor: const Color(0xFFFFDDE6),
        iconColor: const Color(0xFFE91E63),
        cardBgColor: const Color(0xFFFFF5F8),
        title: LocaleKeys.account_and_privacy.tr(),
        subtitle: LocaleKeys.manage_settings.tr(),
        onTap: () async => await viewModel.navigateToAccountPrivacy(),
      );

  Widget _buildSupportCard(ProfileViewModel viewModel) => _ProfileGridCard(
        iconData: Icons.headphones_rounded,
        iconBgColor: const Color(0xFFD6F4F9),
        iconColor: const Color(0xFF28B4CD),
        cardBgColor: const Color(0xFFF0FAFE),
        title: LocaleKeys.support.tr(),
        subtitle: LocaleKeys.get_help.tr(),
        onTap: () async => await viewModel.navigateToSupport(),
      );

  // ── Logout ─────────────────────────────────────────────────────────────────

  Widget _buildLogOutButton(ProfileViewModel viewModel) => SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: () async => await viewModel.logout(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: kcRed.withValues(alpha: 0.5), width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: kcRed.withValues(alpha: 0.06),
          ),
          child: Text(
            '→ ${LocaleKeys.logout.tr()}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kcRed,
              fontFamily: 'Aeonik',
            ),
          ),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// Private grid card widget
// ─────────────────────────────────────────────────────────────────────────────

class _ProfileGridCard extends StatelessWidget {
  final IconData iconData;
  final Color iconBgColor;
  final Color iconColor;
  final Color cardBgColor;
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;

  const _ProfileGridCard({
    required this.iconData,
    required this.iconBgColor,
    required this.iconColor,
    required this.cardBgColor,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral14.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon box
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconData, size: 22, color: iconColor),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.neutral14,
                  fontFamily: 'Aeonik',
                ),
              ),
              const SizedBox(height: 4),
              // Subtitle
              Flexible(
                child: Text(
                  subtitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.neutral40,
                    fontFamily: 'Aeonik',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

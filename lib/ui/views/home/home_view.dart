import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/views/learn_program/learn_program_view.dart';
import 'package:yimaru_app/ui/views/profile/profile_view.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import '../../widgets/developer_mode.dart';
import '../course/course_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    await viewModel.initInAppNotification();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      KeyedSubtree(
          key: ValueKey(context.locale.languageCode),
          child: _buildScaffoldState(viewModel));

  Widget _buildScaffoldState(HomeViewModel viewModel) =>
      viewModel.isDeveloperModeEnabled
          ? _buildDeveloperMode()
          : _buildScaffoldStack(viewModel);

  Widget _buildScaffoldStack(HomeViewModel viewModel) => Stack(
        children: [_buildScaffold(viewModel), _buildLogoutState(viewModel)],
      );

  Widget _buildScaffold(HomeViewModel viewModel) => Scaffold(
        backgroundColor: AppColors.background,
        body: getViewForIndex(viewModel.currentPage),
        bottomNavigationBar: _buildBottomNav(viewModel),
      );

  Widget _buildBottomNav(HomeViewModel viewModel) => SafeArea(
        top: false,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: kcWhite,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: AppColors.neutral14.withValues(alpha: 0.08),
                blurRadius: 24,
                spreadRadius: 0,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.neutral84.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                label: LocaleKeys.learn.tr(),
                icon: Icons.school_rounded,
                unselectedIcon: Icons.school_outlined,
                viewModel: viewModel,
              ),
              _buildNavItem(
                index: 1,
                label: LocaleKeys.course.tr(),
                icon: Icons.menu_book_rounded,
                unselectedIcon: Icons.menu_book_outlined,
                viewModel: viewModel,
              ),
              _buildNavItem(
                index: 2,
                label: LocaleKeys.profile.tr(),
                icon: Icons.person_rounded,
                unselectedIcon: Icons.person_outline_rounded,
                viewModel: viewModel,
              ),
            ],
          ),
        ),
      );

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required IconData unselectedIcon,
    required HomeViewModel viewModel,
  }) {
    final bool isSelected = viewModel.currentPage == index;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => viewModel.setCurrentIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 18, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.neutral93 : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? icon : unselectedIcon,
              size: 24,
              color: isSelected ? AppColors.magenta38 : AppColors.neutral40,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.magenta38 : AppColors.neutral40,
                fontFamily: 'Aeonik',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const LearnProgramView(showAppBar: true);
      case 1:
        // return const ComingSoon();
        return const CourseView();

      default:
        return const ProfileView();
    }
  }

  Widget _buildLogoutState(HomeViewModel viewModel) =>
      viewModel.state == StateObjects.logout
          ? const PageLoadingIndicator()
          : Container();

  Widget _buildDeveloperMode() => const DeveloperMode();
}

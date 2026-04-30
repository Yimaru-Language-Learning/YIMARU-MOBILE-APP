import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/learn_program/learn_program_view.dart';
import 'package:yimaru_app/ui/views/profile/profile_view.dart';
import 'package:yimaru_app/ui/widgets/coming_soon.dart';

import '../../common/enmus.dart';
import '../../widgets/page_loading_indicator.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    await viewModel.inAppUpdate();
    super.onViewModelReady(viewModel);
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      _buildScaffold(viewModel);

  Widget _buildScaffold(HomeViewModel viewModel) => Scaffold(
        body: getViewForIndex(viewModel.currentPage),
        bottomNavigationBar: _buildBottomNav(viewModel),
      );

  Widget _buildBottomNav(HomeViewModel viewModel) => BottomNavigationBar(
        items: _buildNavBarItems(),
        onTap: viewModel.setCurrentIndex,
        selectedItemColor: kcPrimaryColor,
        backgroundColor: kcBackgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: viewModel.currentPage,
      );

  List<BottomNavigationBarItem> _buildNavBarItems() => [
        _buildLearnItem(),
        _buildCourseItem(),
        _buildProfileItem(),
      ];

  BottomNavigationBarItem _buildLearnItem() => BottomNavigationBarItem(
        label: 'Learn',
        icon: _buildLearnIcon(),
      );

  BottomNavigationBarItem _buildCourseItem() => BottomNavigationBarItem(
        label: 'Course',
        icon: _buildCourseIcon(),
      );

  BottomNavigationBarItem _buildProfileItem() => BottomNavigationBarItem(
        label: 'Profile',
        icon: _buildProfileIcon(),
      );

  Widget _buildLearnIcon() => const Icon(Icons.school);

  Widget _buildCourseIcon() => const Icon(Icons.book);

  Widget _buildProfileIcon() => const Icon(Icons.person);

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const LearnProgramView();
      case 1:
        return const ComingSoon();

      default:
        return const ProfileView();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/learn/learn_view.dart';
import 'package:yimaru_app/ui/views/profile/profile_view.dart';
import 'package:yimaru_app/ui/views/startup/startup_view.dart';
import 'package:yimaru_app/ui/widgets/coming_soon.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    await viewModel.getProfileStatus();
    await viewModel.getProfileData();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(HomeViewModel viewModel) => viewModel.isBusy
      ? const StartupView(label: 'Checking user info')
      : _buildScaffold(viewModel);

  Widget _buildScaffold(HomeViewModel viewModel) => Scaffold(
        body: getViewForIndex(viewModel.currentIndex),
        bottomNavigationBar: _buildBottomNav(viewModel),
      );

  Widget _buildBottomNav(HomeViewModel viewModel) => BottomNavigationBar(
        onTap: viewModel.setCurrentIndex,
        items: _buildNavBarItems(),
        selectedItemColor: kcPrimaryColor,
        backgroundColor: kcBackgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: viewModel.currentIndex,
      );

  List<BottomNavigationBarItem> _buildNavBarItems() => [
        _buildLearnItem(),
        _buildCourseItem(),
        _buildProfileItem(),
      ];

  BottomNavigationBarItem _buildLearnItem() => const BottomNavigationBarItem(
        label: 'Learn',
        icon: Icon(Icons.school),
      );

  BottomNavigationBarItem _buildCourseItem() => const BottomNavigationBarItem(
        label: 'Course',
        icon: Icon(Icons.book),
      );

  BottomNavigationBarItem _buildProfileItem() => const BottomNavigationBarItem(
        label: 'Profile',
        icon: Icon(Icons.person),
      );
}

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const LearnView();
    case 1:
      return const ComingSoon();

    default:
      return const ProfileView();
  }
}

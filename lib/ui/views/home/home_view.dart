import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/course_category/course_category_view.dart';
import 'package:yimaru_app/ui/views/learn_subcategory/learn_subcategory_view.dart';
import 'package:yimaru_app/ui/views/profile/profile_view.dart';
import 'package:yimaru_app/ui/views/startup/startup_view.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) async {
    // Removable
    print('HERE');
    await _init(viewModel);
    super.onViewModelReady(viewModel);
  }

  Future<void> _init(HomeViewModel viewModel) async =>
      await viewModel.initialize();

  @override
  Widget builder(
          BuildContext context, HomeViewModel viewModel, Widget? child) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(HomeViewModel viewModel) =>
      viewModel.busy(StateObjects.homeView)
          ? _buildStartUpView()
          : _buildScaffold(viewModel);

  Widget _buildStartUpView() => const StartupView(label: 'Checking user info');

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
}

Widget _buildLearnIcon() => const Icon(Icons.school);

Widget _buildCourseIcon() => const Icon(Icons.book);

Widget _buildProfileIcon() => const Icon(Icons.person);

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const LearnSubcategoryView();
    case 1:
      return const CourseCategoryView();

    default:
      return const ProfileView();
  }
}

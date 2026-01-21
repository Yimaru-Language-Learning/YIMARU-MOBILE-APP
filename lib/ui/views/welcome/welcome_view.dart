import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'screens/first_welcome_screen.dart';
import 'screens/second_welcome_screen.dart';
import 'screens/third_welcome_screen.dart';
import 'welcome_viewmodel.dart';

class WelcomeView extends StackedView<WelcomeViewModel> {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  WelcomeViewModel viewModelBuilder(BuildContext context) => WelcomeViewModel();

  @override
  Widget builder(
    BuildContext context,
    WelcomeViewModel viewModel,
    Widget? child,
  ) =>
      _buildWelcomeScreens(viewModel);

  Widget _buildWelcomeScreens(WelcomeViewModel viewModel) => IndexedStack(
        index: viewModel.currentPage,
        children: _buildScreens(),
      );

  List<Widget> _buildScreens() =>
      [_buildFirstWelcome(), _buildSecondWelcome(), _buildThirdWelcome()];

  Widget _buildFirstWelcome() => const FirstWelcomeScreen();

  Widget _buildSecondWelcome() => const SecondWelcomeScreen();

  Widget _buildThirdWelcome() => const ThirdWelcomeScreen();
}

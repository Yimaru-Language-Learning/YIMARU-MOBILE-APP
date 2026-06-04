import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_colors.dart';
import 'package:yimaru_app/ui/views/landing/screens/first_landing_screen.dart';
import 'package:yimaru_app/ui/views/landing/screens/second_landing_screen.dart';
import 'package:yimaru_app/ui/views/landing/screens/third_landing_screen.dart';

import 'landing_viewmodel.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({Key? key}) : super(key: key);

  @override
  LandingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LandingViewModel();

  @override
  Widget builder(
    BuildContext context,
    LandingViewModel viewModel,
    Widget? child,
  ) =>
      _buildLandingScreensWrapper(viewModel);

  Widget _buildLandingScreensWrapper(LandingViewModel viewModel) => Scaffold(
        backgroundColor: kcPrimaryColor,
        body: _buildLandingScreens(viewModel),
      );

  Widget _buildLandingScreens(LandingViewModel viewModel) => FlutterCarousel(
        options: FlutterCarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          indicatorMargin: 40,
          showIndicator: false,
          height: double.maxFinite,
          controller: viewModel.controller,
        ),
        items: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildFirstLanding(),
        _buildSecondLanding(),
        _buildThirdLanding(),
      ];

  Widget _buildFirstLanding() => const FirstLandingScreen();

  Widget _buildSecondLanding() => const SecondLandingScreen();

  Widget _buildThirdLanding() => const ThirdLandingScreen();

}

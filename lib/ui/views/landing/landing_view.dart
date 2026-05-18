import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
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
  )=> _buildLandingScreens(viewModel);

  Widget _buildLandingScreens(LandingViewModel viewModel) => FlutterCarousel(
    options: FlutterCarouselOptions(
      autoPlay: true,
      viewportFraction: 1,
      showIndicator: true,
      indicatorMargin: 40,
      height: double.maxFinite,
      slideIndicator: CircularSlideIndicator(
        slideIndicatorOptions:
        const SlideIndicatorOptions(indicatorRadius: 2.5),
      ),
    ),
    items: _buildScreens(),
  );

  List<Widget> _buildScreens() =>
      [_buildFirstWelcome(), _buildSecondWelcome(), _buildThirdWelcome()];

  Widget _buildFirstWelcome() => const FirstLandingScreen();

  Widget _buildSecondWelcome() => const SecondLandingScreen();

  Widget _buildThirdWelcome() => const ThirdLandingScreen();


}

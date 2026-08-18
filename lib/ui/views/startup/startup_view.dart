import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/startup/screens/first_startup_screen.dart';
import 'package:yimaru_app/ui/views/startup/screens/second_startup_screen.dart';
import 'package:yimaru_app/ui/views/startup/screens/third_startup_screen.dart';

import '../../common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  final String? label;

  const StartupView({Key? key, this.label}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(StartupViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcPrimaryColor,
        body: _buildStartupScreens(viewModel),
      );

  Widget _buildStartupScreens(StartupViewModel viewModel) => FlutterCarousel(
        options: FlutterCarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          showIndicator: false,
          height: double.maxFinite,
        ),
        items: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildFirstStartup(),
        _buildSecondStartup(),
        _buildThirdWelcome(),
      ];

  Widget _buildFirstStartup() => FirstStartupScreen(
        label: label,
      );

  Widget _buildSecondStartup() => SecondStartupScreen(
        label: label,
      );

  Widget _buildThirdWelcome() => ThirdStartupScreen(
        label: label,
      );

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

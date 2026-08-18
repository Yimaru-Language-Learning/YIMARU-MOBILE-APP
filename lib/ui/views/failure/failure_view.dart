import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/failure/screens/first_failure_screen.dart';
import 'package:yimaru_app/ui/views/failure/screens/second_failure_screen.dart';
import 'package:yimaru_app/ui/views/failure/screens/third_failure_screen.dart';

import '../../common/app_colors.dart';
import 'failure_viewmodel.dart';

class FailureView extends StackedView<FailureViewModel> {
  final String label;
  final GestureTapCallback onTap;

  const FailureView({Key? key, required this.onTap, required this.label})
      : super(key: key);

  @override
  FailureViewModel viewModelBuilder(BuildContext context) => FailureViewModel();

  @override
  Widget builder(
    BuildContext context,
    FailureViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper();

  Widget _buildScaffoldWrapper() => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcPrimaryColor,
        body: _buildStartupScreens(),
      );

  Widget _buildStartupScreens() => FlutterCarousel(
        options: FlutterCarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          showIndicator: false,
          height: double.maxFinite,
        ),
        items: _buildScreens(),
      );

  List<Widget> _buildScreens() => [
        _buildFirstFailure(),
        _buildSecondFailure(),
        _buildThirdFailure(),
      ];

  Widget _buildFirstFailure() => FirstFailureScreen(
        label: label,
        onTap: onTap,
      );

  Widget _buildSecondFailure() => SecondFailureScreen(
        label: label,
        onTap: onTap,
      );

  Widget _buildThirdFailure() => ThirdFailureScreen(
        label: label,
        onTap: onTap,
      );
}

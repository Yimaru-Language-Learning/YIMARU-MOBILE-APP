import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
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
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(),
      );

  Widget _buildScaffold() => Stack(
        children: _buildScaffoldChildren(),
      );

  List<Widget> _buildScaffoldChildren() => [
        _buildBackground(),
        _buildColumn(),
      ];

  Widget _buildBackground() => Image.asset(
        'assets/images/loading.png',
        fit: BoxFit.fill,
        width: double.maxFinite,
        height: double.maxFinite,
      );

  Widget _buildColumn() => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildColumnChildren(),
      );

  List<Widget> _buildColumnChildren() =>
      [_buildIconWrapper(), _buildSafeWrapper()];

  Widget _buildIconWrapper() => Padding(
        padding: const EdgeInsets.only(top: 100),
        child: _buildIcon(),
      );

  Widget _buildIcon() => SvgPicture.asset('assets/icons/logo.svg', height: 50);

  Widget _buildSafeWrapper() => SafeArea(child: _buildBottomSectionWrapper());

  Widget _buildBottomSectionWrapper() => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildBottomSectionColumn(),
      );

  Widget _buildBottomSectionColumn() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildBottomSectionChildren(),
      );

  List<Widget> _buildBottomSectionChildren() => [
        _buildLoadingTextWrapper(),
        verticalSpaceSmall,
        _buildRetryButtonWrapper()
      ];

  Widget _buildLoadingTextWrapper() => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildLoadingTextChildren(),
      );

  List<Widget> _buildLoadingTextChildren() => [
        _buildLoadingText(),
        horizontalSpaceSmall,
        _buildIndicatorWrapper(),
      ];

  Widget _buildLoadingText() =>
      Text('$label ...', style: const TextStyle(color: kcWhite, fontSize: 16));

  Widget _buildIndicatorWrapper() => SizedBox(
        width: 16,
        height: 16,
        child: _buildIndicator(),
      );

  Widget _buildIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildRetryButtonWrapper() => GestureDetector(
        onTap: onTap,
        child: _buildRetryButton(),
      );

  Widget _buildRetryButton() => Text(
        'Retry',
        style: style16W600.copyWith(
            fontStyle: FontStyle.italic, decoration: TextDecoration.underline),
      );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/custom_circular_progress_indicator.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
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
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldState(viewModel),
      );

  Widget _buildScaffoldState(StartupViewModel viewModel) =>
      viewModel.busy(StateObjects.startupView)
          ? _buildStartUpView()
          : _buildScaffold();

  Widget _buildStartUpView() =>
      StartupView(label: LocaleKeys.checking_user_info.tr());

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildUpperColumnChildren(),
      );

  List<Widget> _buildUpperColumnChildren() =>
      [_buildIconWrapper(), _buildSafeWrapper()];

  Widget _buildSafeWrapper() => SafeArea(child: _buildLoadingTextContainer());

  Widget _buildLoadingTextContainer() => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildLoadingTextWrapper(),
      );

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
      Text('${label ?? LocaleKeys.loading.tr()} ...', style: style16W600);

  Widget _buildIndicatorWrapper() => SizedBox(
        width: 16,
        height: 16,
        child: _buildIndicator(),
      );

  Widget _buildIndicator() =>
      const CustomCircularProgressIndicator(color: kcWhite);

  Widget _buildIconWrapper() => Padding(
        padding: const EdgeInsets.only(top: 120),
        child: _buildIcon(),
      );

  Widget _buildIcon() => SvgPicture.asset(
        'assets/icons/logo.svg',
        height: 50,
      );

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}

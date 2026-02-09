import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/circular_icon.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'call_support_viewmodel.dart';

class CallSupportView extends StackedView<CallSupportViewModel> {
  const CallSupportView({Key? key}) : super(key: key);

  @override
  CallSupportViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CallSupportViewModel();

  @override
  Widget builder(
    BuildContext context,
    CallSupportViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(CallSupportViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(CallSupportViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(CallSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(CallSupportViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedColumn(viewModel)
      ];

  Widget _buildAppBarWrapper(CallSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(CallSupportViewModel viewModel) => SmallAppBar(
        title: 'Call Support',
        onTap: viewModel.pop,
      );

  Widget _buildExpandedColumn(CallSupportViewModel viewModel) =>
      Expanded(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(CallSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CallSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(CallSupportViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildContinueButtonWrapper(viewModel)];

  Widget _buildUpperColumn(CallSupportViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(CallSupportViewModel viewModel) => [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceMedium,
        _buildSubTitle('+2519012345678'),
        verticalSpaceSmall,
        _buildSubTitle('+2519012345678'),
      ];

  Widget _buildIcon() =>
      const CircularIcon(icon: Icons.call, size: 50, color: kcPrimaryColor);

  Widget _buildTitle() => Text(
        'Call our support team between 9 AM - 6 PM',
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubTitle(String title) => Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(color: kcPrimaryColor),
      );

  Widget _buildContinueButtonWrapper(CallSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: _buildContinueButton(viewModel),
      );

  Widget _buildContinueButton(CallSupportViewModel viewModel) =>
      const CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        text: 'Tap to Call',
        leadingIcon: Icons.call,
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );
}

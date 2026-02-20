import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/circular_icon.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/option_text_divider.dart';
import '../../widgets/small_app_bar.dart';
import 'telegram_support_viewmodel.dart';

class TelegramSupportView extends StackedView<TelegramSupportViewModel> {
  const TelegramSupportView({Key? key}) : super(key: key);

  @override
  TelegramSupportViewModel viewModelBuilder(BuildContext context) =>
      TelegramSupportViewModel();

  @override
  Widget builder(
    BuildContext context,
    TelegramSupportViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(TelegramSupportViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(TelegramSupportViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(TelegramSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildBodyChildren(viewModel),
      );

  List<Widget> _buildBodyChildren(TelegramSupportViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        _buildExpandedColumn(viewModel)
      ];

  Widget _buildAppBarWrapper(TelegramSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(TelegramSupportViewModel viewModel) => SmallAppBar(
        onTap: viewModel.pop,
        showBackButton: true,
        title: 'Telegram Support',
      );

  Widget _buildExpandedColumn(TelegramSupportViewModel viewModel) =>
      Expanded(child: _buildColumnWrapper(viewModel));

  Widget _buildColumnWrapper(TelegramSupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(TelegramSupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(TelegramSupportViewModel viewModel) =>
      [_buildUpperColumn(viewModel), _buildLowerColumn(viewModel)];

  Widget _buildUpperColumn(TelegramSupportViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildUpperColumnChildren(viewModel),
      );

  List<Widget> _buildUpperColumnChildren(TelegramSupportViewModel viewModel) =>
      [
        verticalSpaceLarge,
        _buildIcon(),
        verticalSpaceMedium,
        _buildTitle(),
        verticalSpaceSmall,
        _buildSubtitle(),
      ];

  Widget _buildIcon() =>
      const CircularIcon(icon: Icons.telegram, size: 50, color: kcSkyBlue);

  Widget _buildTitle() => const Text(
        'Join Yimaru Academy on Telegram',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          color: kcDarkGrey,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildSubtitle() => const Text(
        'Connect with our support team instantly on Telegram for quick assistance and community updates',
        textAlign: TextAlign.center,
        style: TextStyle(color: kcMediumGrey),
      );

  Widget _buildLowerColumn(TelegramSupportViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        children: _buildLowerColumnChildren(viewModel),
      );

  List<Widget> _buildLowerColumnChildren(TelegramSupportViewModel viewModel) =>
      [
        _buildContinueButton(viewModel),
        verticalSpaceSmall,
        _buildOptionTextDivider(),
        verticalSpaceSmall,
        _buildSearchText(),
        verticalSpaceMedium
      ];

  Widget _buildContinueButton(TelegramSupportViewModel viewModel) =>
      const CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        leadingIcon: Icons.telegram,
        text: 'Open in Telegram',
        foregroundColor: kcWhite,
        backgroundColor: kcPrimaryColor,
      );

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildSearchText() => const Text.rich(
        TextSpan(
            text: 'Search for',
            style: TextStyle(
              color: kcDarkGrey,
            ),
            children: [
              TextSpan(
                text: ' @YimaruSupport',
                style: TextStyle(
                  color: kcPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ]),
      );
}

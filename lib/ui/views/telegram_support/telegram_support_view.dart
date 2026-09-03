import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
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
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(TelegramSupportViewModel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
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
        onPop: viewModel.pop,
        showBackButton: true,
        title: LocaleKeys.telegram_support.tr(),
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

  Widget _buildTitle() => Text(
        LocaleKeys.join_telegram.tr(),
        style: style25DG600,
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.connect_with_support_team.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
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
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        leadingIcon: Icons.telegram,
        backgroundColor: kcPrimaryColor,
        text: LocaleKeys.open_in_telegram.tr(),
        onTap: () async => await viewModel.launchTelegram(),
      );

  Widget _buildOptionTextDivider() => const OptionTextDivider();

  Widget _buildSearchText() => Text.rich(
        TextSpan(
            text: LocaleKeys.search_for.tr(),
            style: style14DG500,
            children: [
              TextSpan(
                style: style14P600,
                text: ' $kTelegramSupport',
              )
            ]),
      );
}

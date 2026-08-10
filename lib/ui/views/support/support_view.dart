import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/support_card.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/small_app_bar.dart';
import 'support_viewmodel.dart';

class SupportView extends StackedView<SupportViewModel> {
  const SupportView({Key? key}) : super(key: key);

  @override
  SupportViewModel viewModelBuilder(BuildContext context) => SupportViewModel();

  @override
  Widget builder(
    BuildContext context,
    SupportViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(SupportViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(SupportViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(SupportViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(SupportViewModel viewModel) => _buildBody(viewModel);

  Widget _buildBody(SupportViewModel viewModel) => _buildColumn(viewModel);

  Widget _buildColumn(SupportViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(SupportViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(SupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(SupportViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.need_help.tr(),
      );

  Widget _buildContentWrapper(SupportViewModel viewModel) =>
      Expanded(child: _buildContentColumnWrapper(viewModel));

  Widget _buildContentColumnWrapper(SupportViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildMenuColumnScrollView(viewModel),
      );

  Widget _buildMenuColumnScrollView(SupportViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildMenuColumn(viewModel),
      );

  Widget _buildMenuColumn(SupportViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildMenuColumnChildren(viewModel),
      );

  List<Widget> _buildMenuColumnChildren(SupportViewModel viewModel) => [
        verticalSpaceLarge,
        _buildCallSupport(viewModel),
        verticalSpaceMedium,
        _buildTelegramSupport(viewModel),
        verticalSpaceMedium,
        _buildInAppSupport(viewModel),
        verticalSpaceMedium,
        _buildFaqSupport(viewModel),
        verticalSpaceMedium,
        _buildRating(viewModel)
      ];

  Widget _buildCallSupport(SupportViewModel viewModel) => SupportCard(
        icon: Icons.call,
        color: kcPrimaryColor,
        title: LocaleKeys.call_support.tr(),
        subtitle: LocaleKeys.talk_with_support.tr(),
        onTap: () async => await viewModel.navigateToCallSupport(),
      );

  Widget _buildTelegramSupport(SupportViewModel viewModel) => SupportCard(
        color: kcSkyBlue,
        icon: Icons.telegram,
        title: LocaleKeys.telegram_support.tr(),
        subtitle: LocaleKeys.chat_via_telegram.tr(),
        onTap: () async => await viewModel.navigateToTelegramSupport(),
      );

  Widget _buildInAppSupport(SupportViewModel viewModel) => SupportCard(
        color: kcOrange,
        icon: Icons.menu_book,
        title: 'In-App support',
        subtitle: 'Write down your issue here',
        onTap: () async => await viewModel.navigateToInAppSupport(),
      );

  Widget _buildFaqSupport(SupportViewModel viewModel) => SupportCard(
        color: kcGreen,
        title: 'FAQ',
        icon: Icons.question_mark,
        subtitle: 'Visit frequently asked questions',
        onTap: () async => await viewModel.navigateToFaqs(),
      );

  Widget _buildRating(SupportViewModel viewModel) => SupportCard(
        color: kcIndigo,
        title: 'Rate App',
        icon: Icons.rate_review,
        subtitle: 'Give us rating about our app',
        onTap: () async => await viewModel.navigateToAppRating(),
      );
}

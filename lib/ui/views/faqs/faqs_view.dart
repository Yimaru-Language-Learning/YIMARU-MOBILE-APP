import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../widgets/retryable_content.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/models/faq.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/faq_tile.dart';
import '../../widgets/small_app_bar.dart';
import 'faqs_viewmodel.dart';

class FaqsView extends StackedView<FaqsViewModel> {
  const FaqsView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(FaqsViewModel viewModel) async {
    await viewModel.getFAQs();
    super.onViewModelReady(viewModel);
  }

  @override
  FaqsViewModel viewModelBuilder(BuildContext context) => FaqsViewModel();

  @override
  Widget builder(
    BuildContext context,
    FaqsViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(FaqsViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(FaqsViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(FaqsViewModel viewModel) => _buildBody(viewModel);

  Widget _buildBody(FaqsViewModel viewModel) => _buildColumn(viewModel);

  Widget _buildColumn(FaqsViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(FaqsViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceSmall,
        _buildContentWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(FaqsViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(FaqsViewModel viewModel) => SmallAppBar(
        title: LocaleKeys.faqs.tr(),
        showBackButton: true,
        onPop: viewModel.pop,
      );

  Widget _buildContentWrapper(FaqsViewModel viewModel) =>
      Expanded(child: _buildContentColumnWrapper(viewModel));

  Widget _buildContentColumnWrapper(FaqsViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildMenuColumnScrollView(viewModel),
      );

  Widget _buildMenuColumnScrollView(FaqsViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildMenuColumn(viewModel),
      );

  Widget _buildMenuColumn(FaqsViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildMenuColumnChildren(viewModel),
      );

  List<Widget> _buildMenuColumnChildren(FaqsViewModel viewModel) =>
      [verticalSpaceLarge, _buildListViewState(viewModel)];

  Widget _buildListViewState(FaqsViewModel viewModel) => RetryableContent(
        isLoading: viewModel.busy(StateObjects.faqs),
        hasError: viewModel.hasErrorForKey(StateObjects.faqs),
        onRetry: () => viewModel.getFAQs(),
        loading: _buildProgressIndicator(),
        builder: () => _buildListView(viewModel),
      );

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(FaqsViewModel viewModel) => ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.faqs.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildTile(viewModel.faqs[index]),
      );

  Widget _buildTile(Faq faq) => FaqTile(faq: faq);
}

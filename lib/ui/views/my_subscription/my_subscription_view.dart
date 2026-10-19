import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

import '../../../models/my_subscription.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/my_subscription_card.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'my_subscription_viewmodel.dart';
import '../../widgets/retryable_content.dart';

class MySubscriptionView extends StackedView<MySubscriptionViewModel> {
  const MySubscriptionView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(MySubscriptionViewModel viewModel) async {
    await viewModel.getMySubscriptions();
    super.onViewModelReady(viewModel);
  }

  @override
  MySubscriptionViewModel viewModelBuilder(BuildContext context) =>
      MySubscriptionViewModel();

  @override
  Widget builder(
    BuildContext context,
    MySubscriptionViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(MySubscriptionViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldStack(viewModel),
      );

  Widget _buildScaffoldStack(MySubscriptionViewModel viewModel) => Stack(
        children: [_buildScaffold(viewModel), _buildBodyState(viewModel)],
      );

  Widget _buildScaffold(MySubscriptionViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(MySubscriptionViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(MySubscriptionViewModel viewModel) =>
      _buildNestedScrollView(viewModel);

  Widget _buildNestedScrollView(MySubscriptionViewModel viewModel) =>
      NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  [_buildSliverAppbarWrapper(viewModel)],
          body: _buildContentScrollViewWrapper(viewModel));

  Widget _buildSliverAppbarWrapper(MySubscriptionViewModel viewModel) =>
      SliverAppBar(
        pinned: true,
        automaticallyImplyLeading: false,
        backgroundColor: kcBackgroundColor,
        surfaceTintColor: kcBackgroundColor,
        title: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(MySubscriptionViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.my_subscriptions.tr(),
      );

  Widget _buildContentScrollViewWrapper(MySubscriptionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildContentWrapper(viewModel),
      );

  Widget _buildContentWrapper(MySubscriptionViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildContentColumn(viewModel),
      );

  Widget _buildContentColumn(MySubscriptionViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildContentChildren(viewModel),
      );

  List<Widget> _buildContentChildren(MySubscriptionViewModel viewModel) => [
        verticalSpaceMedium,
        _buildText(),
        verticalSpaceMedium,
        RetryableContent(
          isLoading: viewModel.busy(StateObjects.mySubscriptions),
          hasError: viewModel.hasErrorForKey(StateObjects.mySubscriptions),
          onRetry: viewModel.getMySubscriptions,
          builder: () => _buildSubscriptions(viewModel),
        )
      ];

  Widget _buildText() => Text(
        LocaleKeys.continue_learning_favorite.tr(),
        style: style14DG400,
      );

  Widget _buildSubscriptions(MySubscriptionViewModel viewModel) =>
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.subscriptions.length,
        separatorBuilder: (context, index) => verticalSpaceMedium,
        itemBuilder: (context, index) =>
            _buildSubscriptionCard(viewModel.subscriptions[index]),
      );

  Widget _buildSubscriptionCard(MySubscription subscription) =>
      MySubscriptionCard(subscription: subscription);

  Widget _buildBodyState(MySubscriptionViewModel viewModel) =>
      viewModel.busy(StateObjects.mySubscriptions)
          ? const PageLoadingIndicator()
          : Container();
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/widgets/notification_card.dart';

import '../../../models/in_app_notification.dart';
import '../../common/app_colors.dart';
import '../../common/enmus.dart';
import '../../common/translations/locale_keys.g.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/custom_circular_progress_indicator.dart';
import '../../widgets/small_app_bar.dart';
import 'notification_viewmodel.dart';

class NotificationView extends StackedView<NotificationViewModel> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(NotificationViewModel viewModel) async {
    await viewModel.getAllNotifications();
    await viewModel.markNotificationsRead();
    super.onViewModelReady(viewModel);
  }

  @override
  NotificationViewModel viewModelBuilder(BuildContext context) =>
      NotificationViewModel();

  @override
  Widget builder(
    BuildContext context,
    NotificationViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(NotificationViewModel viewModel) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(NotificationViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(NotificationViewModel viewModel) =>
      SafeArea(child: _buildBodyWrapper(viewModel));

  Widget _buildBodyWrapper(NotificationViewModel viewModel) =>
      _buildBody(viewModel);

  Widget _buildBody(NotificationViewModel viewModel) => _buildColumn(viewModel);

  Widget _buildColumn(NotificationViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildColumnChildren(viewModel),
      );

  List<Widget> _buildColumnChildren(NotificationViewModel viewModel) => [
        verticalSpaceMedium,
        _buildAppBarWrapper(viewModel),
        verticalSpaceMedium,
        _buildNotificationsColumnWrapper(viewModel)
      ];

  Widget _buildAppBarWrapper(NotificationViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildAppbar(viewModel),
      );

  Widget _buildAppbar(NotificationViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.pop,
        title: LocaleKeys.notifications.tr(),
      );

  Widget _buildNotificationsColumnWrapper(NotificationViewModel viewModel) =>
      Expanded(child: _buildNotificationsColumnScrollView(viewModel));

  Widget _buildNotificationsColumnScrollView(NotificationViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildListViewBuilder(viewModel),
      );

  Widget _buildListViewBuilder(NotificationViewModel viewModel) =>
      viewModel.busy(StateObjects.notifications)
          ? _buildProgressIndicator()
          : _buildListView(viewModel);

  Widget _buildProgressIndicator() => const Center(
        child: CustomCircularProgressIndicator(color: kcPrimaryColor),
      );

  Widget _buildListView(NotificationViewModel viewModel) => ListView.separated(
        shrinkWrap: true,
        itemCount: viewModel.notifications.length,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => verticalSpaceSmall,
        itemBuilder: (context, index) => _buildCard(
          notification: viewModel.notifications[index],
        ),
      );

  Widget _buildCard({
    required InAppNotification notification,
  }) =>
      NotificationCard(notification: notification);
}

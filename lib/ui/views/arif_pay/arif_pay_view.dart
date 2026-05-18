import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';
import 'package:yimaru_app/ui/widgets/page_loading_indicator.dart';

import 'arif_pay_viewmodel.dart';

class ArifPayView extends StackedView<ArifPayViewModel> {
  final String phone;

  const ArifPayView({Key? key, required this.phone}) : super(key: key);

  void _pop(ArifPayViewModel viewModel) => viewModel.pop;

  Future<void> _error() async {
    // await Navigator.pushNamed(context, AppRoutes.subscriptionErrorPage);
    // Navigation.pop();
  }

  void _success() {
    // Navigation.navigateTo(
    //   AppRoutes.subscriptionSuccessPage,
    //   arguments: widget.body,
    // );
  }

  @override
  void onViewModelReady(ArifPayViewModel viewModel) async {
    await viewModel.createLearnSubscriptionRequest(phone);
    super.onViewModelReady(viewModel);
  }

  @override
  ArifPayViewModel viewModelBuilder(BuildContext context) => ArifPayViewModel();

  @override
  Widget builder(
    BuildContext context,
    ArifPayViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(ArifPayViewModel viewModel) =>
      Scaffold(body: _buildScaffoldState(viewModel));

  Widget _buildScaffoldState(ArifPayViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubscription)
          ? const PageLoadingIndicator()
          : _buildScaffold(viewModel);

  Widget _buildScaffold(ArifPayViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(ArifPayViewModel viewModel) => InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri(viewModel.request?.paymentUrl ?? '')),
        onUpdateVisitedHistory: (controller, url, androidIsReload) {
          if (url
              .toString()
              .contains("https://checkout.arifpay.net/canceled")) {
            showErrorToast('Operation was cancelled');
            // _pop();
          } else if (url.toString().contains(kSuccessUrl)) {
            _success();
          } else if (url.toString().contains(kErrorUrl)) {
            showErrorToast('Operation was cancelled');
            // _pop();
          } else if (url.toString().contains("http://x.com/elonmusk/status/")) {
            _error();
          } else if (url.toString().contains(kErrorUrl)) {
            _error();
          }
        },
      );
}

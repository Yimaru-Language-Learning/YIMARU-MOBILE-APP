import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';

import '../../../models/subscription.dart';
import '../../common/app_constants.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/page_loading_indicator.dart';
import 'payment_viewmodel.dart';

class PaymentView extends StackedView<PaymentViewModel> {
  final String phone;
  final PaymentMethod method;
  final Subscription subscription;

  const PaymentView(
      {Key? key,
      required this.phone,
      required this.method,
      required this.subscription})
      : super(key: key);

  void _error(PaymentViewModel viewModel) => viewModel.pop();

  Future<void> _success(PaymentViewModel viewModel) async {
    await viewModel.updatePaymentStatus();

    await viewModel.replaceWithHome();
  }

  @override
  void onViewModelReady(PaymentViewModel viewModel) async {
    await viewModel.initiate(
        phone: phone, method: method, subscription: subscription);
    super.onViewModelReady(viewModel);
  }

  @override
  PaymentViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PaymentViewModel();

  @override
  Widget builder(
    BuildContext context,
    PaymentViewModel viewModel,
    Widget? child,
  ) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(PaymentViewModel viewModel) =>
      Scaffold(
        
        body: _buildScaffoldState(viewModel));

  Widget _buildScaffoldState(PaymentViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubscription)
          ? const PageLoadingIndicator()
          : _buildScaffold(viewModel);

  Widget _buildScaffold(PaymentViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(PaymentViewModel viewModel) => InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri(viewModel.request?.paymentUrl ?? '')),
        onUpdateVisitedHistory: (controller, url, androidIsReload) async {
          if (url.toString().contains(kSuccessUrl)) {
            showSuccessToast(
                'Subscription successful, activation in progress!');
            _success(viewModel);
          } else if (url.toString().contains(kErrorUrl)) {
            _error(viewModel);
          }
        },
      );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:stacked/stacked.dart';

import '../../../models/subscription.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';
import '../../widgets/page_loading_indicator.dart';
import '../../widgets/manual_payment_dialog.dart';
import 'payment_redirect.dart';
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

  bool _isActive(BuildContext context) =>
      context.mounted && ModalRoute.of(context)?.isCurrent == true;

  Future<void> _showFailure(BuildContext context, PaymentViewModel viewModel,
      PaymentFailure failure) async {
    if (!_isActive(context) || !viewModel.claimFailureDialog()) return;
    await showDialog<void>(
      context: context,
      builder: (_) => ManualPaymentDialog(
          paymentUncertain: failure == PaymentFailure.uncertain),
    );
    if (context.mounted && _isActive(context)) viewModel.pop();
  }

  Future<void> _checkoutFailed(
      BuildContext context, PaymentViewModel viewModel) async {
    if (!_isActive(context) || !viewModel.beginCheckoutResult()) return;
    final outcome = await viewModel.checkCheckoutOutcome();
    if (!context.mounted || !_isActive(context)) return;
    switch (outcome) {
      case CheckoutOutcome.cancelled:
        viewModel.pop();
        return;
      case CheckoutOutcome.success:
        await _success(viewModel);
        return;
      case CheckoutOutcome.failed:
        await _showFailure(context, viewModel, PaymentFailure.failed);
        return;
      case CheckoutOutcome.uncertain:
        await _showFailure(context, viewModel, PaymentFailure.uncertain);
        return;
    }
  }

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
      _buildScaffoldWrapper(context, viewModel);

  Widget _buildScaffoldWrapper(
      BuildContext context, PaymentViewModel viewModel) {
    final failure = viewModel.startFailure;
    if (!viewModel.busy(StateObjects.learnSubscription) && failure != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFailure(context, viewModel, failure);
      });
    }
    return Scaffold(body: _buildScaffoldState(context, viewModel));
  }

  Widget _buildScaffoldState(
          BuildContext context, PaymentViewModel viewModel) =>
      viewModel.busy(StateObjects.learnSubscription)
          ? const PageLoadingIndicator()
          : viewModel.request == null
              ? SafeArea(
                  child: Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text('manual_payment_start_failed'.tr()),
                      TextButton(
                        onPressed: viewModel.pop,
                        child: Text('go_back'.tr()),
                      ),
                    ]),
                  ),
                )
              : _buildScaffold(context, viewModel);

  Widget _buildScaffold(BuildContext context, PaymentViewModel viewModel) =>
      SafeArea(child: _buildBody(context, viewModel));

  Widget _buildBody(BuildContext context, PaymentViewModel viewModel) =>
      InAppWebView(
        initialUrlRequest:
            URLRequest(url: WebUri(viewModel.request?.paymentUrl ?? '')),
        onUpdateVisitedHistory: (controller, url, androidIsReload) async {
          if (!_isActive(context)) return;
          switch (
              classifyPaymentRedirect(Uri.tryParse(url?.toString() ?? ''))) {
            case PaymentRedirect.success:
              if (!viewModel.beginCheckoutResult()) return;
              showSuccessToast(
                  'Subscription successful, activation in progress!');
              await _success(viewModel);
              return;
            case PaymentRedirect.failure:
              await _checkoutFailed(context, viewModel);
              return;
            case PaymentRedirect.cancelled:
              if (viewModel.beginCheckoutResult()) viewModel.pop();
              return;
            case PaymentRedirect.none:
              return;
          }
        },
        onReceivedError: (controller, request, error) async {
          if (request.isForMainFrame == true) {
            await _checkoutFailed(context, viewModel);
          }
        },
        onReceivedHttpError: (controller, request, error) async {
          if (request.isForMainFrame == true) {
            await _checkoutFailed(context, viewModel);
          }
        },
      );
}

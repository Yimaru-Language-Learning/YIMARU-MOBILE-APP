import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_view.form.dart';
import 'package:yimaru_app/ui/views/learn_subscription/screens/subscription_form_screen.dart';
import 'package:yimaru_app/ui/views/learn_subscription/screens/subscription_package_screen.dart';
import 'package:yimaru_app/ui/views/subscription/subscription_view.form.dart';
import 'package:yimaru_app/ui/views/subscription/subscription_viewmodel.dart';

import '../../common/validators/form_validator.dart';
import 'subscription_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'phoneNumber', validator: FormValidator.validateForm)
])
class SubscriptionView extends StackedView<SubscriptionViewModel>
    with $SubscriptionView {
  const SubscriptionView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(SubscriptionViewModel viewModel) async {
    await viewModel.getLearnSubscriptions();
    _clearData();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  void _clearData() {
    phoneNumberController.clear();
  }

  @override
  SubscriptionViewModel viewModelBuilder(BuildContext context) =>
      SubscriptionViewModel();

  @override
  Widget builder(
    BuildContext context,
    SubscriptionViewModel viewModel,
    Widget? child,
  ) =>
      _buildBodyWrapper(viewModel);

  Widget _buildBodyWrapper(SubscriptionViewModel viewModel) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, data) {
        if (!didPop) {
          Future.microtask(() => viewModel.goBack());
        }
      },
      child: _buildBody(viewModel));

  Widget _buildBody(SubscriptionViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildScreens(viewModel));

  List<Widget> _buildScreens(SubscriptionViewModel viewModel) => [
        _buildLearnSubscriptionPackageScreen(),
        _buildLearnSubscriptionFormScreen()
      ];

  Widget _buildLearnSubscriptionPackageScreen() =>
      const SubscriptionPackageScreen();

  Widget _buildLearnSubscriptionFormScreen() =>
      SubscriptionFormScreen(phoneNumberController: phoneNumberController);
}

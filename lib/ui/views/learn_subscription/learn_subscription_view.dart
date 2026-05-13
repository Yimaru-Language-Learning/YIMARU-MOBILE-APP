import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_view.form.dart';
import 'package:yimaru_app/ui/views/learn_subscription/screens/learn_subscription_form_screen.dart';
import 'package:yimaru_app/ui/views/learn_subscription/screens/learn_subscription_package_screen.dart';
import 'package:yimaru_app/ui/widgets/learn_subscription_card.dart';
import 'package:yimaru_app/ui/widgets/learn_subscription_pricing_section.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../../common/validators/form_validator.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/small_app_bar.dart';
import 'learn_subscription_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'phoneNumber', validator: FormValidator.validateForm)
])
class LearnSubscriptionView extends StackedView<LearnSubscriptionViewModel>
    with $LearnSubscriptionView {
  const LearnSubscriptionView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(LearnSubscriptionViewModel viewModel) async {
    await viewModel.getLearnSubscriptions();
    _clearData();
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  void _clearData() {
    phoneNumberController.clear();
  }

  @override
  LearnSubscriptionViewModel viewModelBuilder(BuildContext context) =>
      LearnSubscriptionViewModel();

  @override
  Widget builder(
    BuildContext context,
    LearnSubscriptionViewModel viewModel,
    Widget? child,
  ) =>
      _buildBodyWrapper(viewModel);

  Widget _buildBodyWrapper(LearnSubscriptionViewModel viewModel) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, data) {
        if (!didPop) {
          Future.microtask(() => viewModel.goBack());
        }
      },
      child: _buildBody(viewModel));

  Widget _buildBody(LearnSubscriptionViewModel viewModel) => IndexedStack(
      index: viewModel.currentPage, children: _buildScreens(viewModel));

  List<Widget> _buildScreens(LearnSubscriptionViewModel viewModel) => [
        _buildLearnSubscriptionPackageScreen(),
        _buildLearnSubscriptionFormScreen()
      ];

  Widget _buildLearnSubscriptionPackageScreen() =>
      const LearnSubscriptionPackageScreen();

  Widget _buildLearnSubscriptionFormScreen() =>
      LearnSubscriptionFormScreen(phoneNumberController: phoneNumberController);
}

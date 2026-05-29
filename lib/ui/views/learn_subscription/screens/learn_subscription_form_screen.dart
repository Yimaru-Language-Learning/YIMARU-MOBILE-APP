import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/learn_subscription/learn_subscription_viewmodel.dart';
import 'package:yimaru_app/ui/widgets/phone_number_prefix.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/learn_subscription_card.dart';
import '../../../widgets/small_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../learn_subscription_view.form.dart';

class LearnSubscriptionFormScreen
    extends ViewModelWidget<LearnSubscriptionViewModel> {
  final TextEditingController phoneNumberController;

  const LearnSubscriptionFormScreen({
    super.key,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context, LearnSubscriptionViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(LearnSubscriptionViewModel viewModel) =>
      Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(LearnSubscriptionViewModel viewModel) =>
      Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(LearnSubscriptionViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(LearnSubscriptionViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(LearnSubscriptionViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildSubscriptionColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(LearnSubscriptionViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
      );

  Widget _buildSubscriptionColumnWrapper(
          LearnSubscriptionViewModel viewModel) =>
      Expanded(child: _buildSubscriptionColumnScrollView(viewModel));

  Widget _buildSubscriptionColumnScrollView(
          LearnSubscriptionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildSubscriptionColumn(viewModel),
      );

  Widget _buildSubscriptionColumn(LearnSubscriptionViewModel viewModel) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSheetChildren(viewModel),
      );

  List<Widget> _buildSheetChildren(LearnSubscriptionViewModel viewModel) => [
        verticalSpaceSmall,
        _buildTitleWrapper(),
        verticalSpaceMedium,
        _buildFirstCard(),
        verticalSpaceMedium,
        _buildSecondCard(),
        verticalSpaceLarge,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildPhoneNumberWrapper(viewModel),
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          verticalSpaceTiny,
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          _buildPhoneNumberValidatorWrapper(viewModel),
        verticalSpaceLarge,
        _buildContinueButton(viewModel),
        verticalSpaceMedium,
        _buildSecurePaymentWrapper()
      ];

  Widget _buildFirstCard() => const LearnSubscriptionCard(
        icon: Icons.school,
        title: '180+ New Lessons',
        subtitle: 'Access fresh, advanced content',
      );

  Widget _buildSecondCard() => const LearnSubscriptionCard(
        icon: Icons.developer_board,
        title: 'Mastery Through Practice',
        subtitle: 'Practice All Lessons, Modules & Levels',
      );

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        'Unlock Next Module',
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        'Enter payment phone number, this will be used to process the payment.',
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildPhoneNumberWrapper(LearnSubscriptionViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberChildren(
          LearnSubscriptionViewModel viewModel) =>
      [
        _buildPhoneNumberPrefix(viewModel),
        horizontalSpaceSmall,
        _buildPhoneNumberFormFieldWrapper(viewModel),
      ];

  Widget _buildPhoneNumberPrefix(LearnSubscriptionViewModel viewModel) =>
      PhoneNumberPrefix(selected: viewModel.focusPhoneNumber);

  Widget _buildPhoneNumberFormFieldWrapper(
          LearnSubscriptionViewModel viewModel) =>
      Expanded(child: _buildPhoneNumberFormField(viewModel));

  Widget _buildPhoneNumberFormField(LearnSubscriptionViewModel viewModel) =>
      TextFormField(
        maxLength: 9,
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onTap: viewModel.setPhoneNumberFocus,
        decoration: inputDecoration(
            focus: viewModel.focusPhoneNumber,
            filled: phoneNumberController.text.isNotEmpty),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildPhoneNumberValidatorWrapper(
          LearnSubscriptionViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(LearnSubscriptionViewModel viewModel) =>
      Text(
        viewModel.phoneNumberValidationMessage!,
        style: style12R700,
      );

  Widget _buildContinueButton(LearnSubscriptionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: 'Proceed to Payment',
        backgroundColor: phoneNumberController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withOpacity(0.1),
        onTap: phoneNumberController.text.isNotEmpty
            ? () async => await viewModel.navigateToArifPay(
                phone: phoneNumberController.text,
                subscription: viewModel.selectedSubscription)
            : null,
      );

  Widget _buildSecurePaymentWrapper() => Align(
        alignment: Alignment.center,
        child: _buildSecurePayment(),
      );

  Widget _buildSecurePayment() => Row(
        mainAxisSize: MainAxisSize.min,
        children: _buildSecurePaymentChildren(),
      );

  List<Widget> _buildSecurePaymentChildren() =>
      [_buildTileLeading(), horizontalSpaceTiny, _buildTileTitle()];

  Widget _buildTileLeading() => const Icon(
        Icons.lock_outline_rounded,
        size: 16,
        color: kcMediumGrey,
      );

  Widget _buildTileTitle() => Text(
        'Unlock All Lessons & Practices',
        style: style14MG400,
        textAlign: TextAlign.center,
      );
}

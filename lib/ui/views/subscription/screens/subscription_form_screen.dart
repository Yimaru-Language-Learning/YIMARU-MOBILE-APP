import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/widgets/phone_number_prefix.dart';

import '../../../common/app_colors.dart';
import '../../../common/ui_helpers.dart';
import '../../../widgets/learn_subscription_card.dart';
import '../../../widgets/small_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../subscription_view.form.dart';
import '../subscription_viewmodel.dart';

class SubscriptionFormScreen extends ViewModelWidget<SubscriptionViewModel> {
  final TextEditingController phoneNumberController;

  const SubscriptionFormScreen({
    super.key,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context, SubscriptionViewModel viewModel) =>
      _buildScaffoldWrapper(viewModel);

  Widget _buildScaffoldWrapper(SubscriptionViewModel viewModel) => Scaffold(
        backgroundColor: kcBackgroundColor,
        body: _buildScaffoldContainer(viewModel),
      );

  Widget _buildScaffoldContainer(SubscriptionViewModel viewModel) => Container(
        decoration: bgDecoration,
        child: _buildScaffold(viewModel),
      );

  Widget _buildScaffold(SubscriptionViewModel viewModel) =>
      SafeArea(child: _buildBody(viewModel));

  Widget _buildBody(SubscriptionViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(SubscriptionViewModel viewModel) => Column(
        children: [
          verticalSpaceMedium,
          _buildAppBar(viewModel),
          _buildSubscriptionColumnWrapper(viewModel),
        ],
      );

  Widget _buildAppBar(SubscriptionViewModel viewModel) => SmallAppBar(
        showBackButton: true,
        onPop: viewModel.goBack,
      );

  Widget _buildSubscriptionColumnWrapper(SubscriptionViewModel viewModel) =>
      Expanded(child: _buildSubscriptionColumnScrollView(viewModel));

  Widget _buildSubscriptionColumnScrollView(SubscriptionViewModel viewModel) =>
      SingleChildScrollView(
        child: _buildSubscriptionColumn(viewModel),
      );

  Widget _buildSubscriptionColumn(SubscriptionViewModel viewModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildSheetChildren(viewModel),
      );

  List<Widget> _buildSheetChildren(SubscriptionViewModel viewModel) => [
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
        _buildPaymentElevatedButton(viewModel),
        /* verticalSpaceSmall,
        _buildPaymentTextButton(viewModel),*/
        verticalSpaceMedium,
        _buildSecurePaymentWrapper()
      ];

  Widget _buildFirstCard() => LearnSubscriptionCard(
        icon: Icons.school,
        title: LocaleKeys.tutorial_lessons_180.tr(),
        subtitle: LocaleKeys.access_advanced_content.tr(),
      );

  Widget _buildSecondCard() => LearnSubscriptionCard(
        icon: Icons.developer_board,
        title: LocaleKeys.mastery_through_practice.tr(),
        subtitle: LocaleKeys.practice_all_levels.tr(),
      );

  Widget _buildTitleWrapper() => Align(
        alignment: Alignment.center,
        child: _buildTitle(),
      );

  Widget _buildTitle() => Text(
        LocaleKeys.unlock_next_module.tr(),
        style: style18DG700,
      );

  Widget _buildSubtitle() => Text(
        LocaleKeys.enter_payment_phone.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
      );

  Widget _buildPhoneNumberWrapper(SubscriptionViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberChildren(SubscriptionViewModel viewModel) => [
        _buildPhoneNumberPrefix(viewModel),
        horizontalSpaceSmall,
        _buildPhoneNumberFormFieldWrapper(viewModel),
      ];

  Widget _buildPhoneNumberPrefix(SubscriptionViewModel viewModel) =>
      PhoneNumberPrefix(selected: viewModel.focusPhoneNumber);

  Widget _buildPhoneNumberFormFieldWrapper(SubscriptionViewModel viewModel) =>
      Expanded(child: _buildPhoneNumberFormField(viewModel));

  Widget _buildPhoneNumberFormField(SubscriptionViewModel viewModel) =>
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

  Widget _buildPhoneNumberValidatorWrapper(SubscriptionViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(SubscriptionViewModel viewModel) => Text(
        viewModel.phoneNumberValidationMessage!,
        style: style12R700,
      );

  Widget _buildPaymentElevatedButton(SubscriptionViewModel viewModel) =>
      CustomElevatedButton(
        height: 55,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.proceed_to_payment.tr(),
        backgroundColor: phoneNumberController.text.isNotEmpty
            ? kcPrimaryColor
            : kcPrimaryColor.withValues(alpha: 0.1),
        onTap: phoneNumberController.text.isNotEmpty
            ? () async => await viewModel.navigateToPayment(
                method: PaymentMethod.sdk,
                phone: phoneNumberController.text,
                subscription: viewModel.selectedSubscription)
            : null,
      );

  Widget _buildPaymentTextButton(SubscriptionViewModel viewModel) => TextButton(
      onPressed: phoneNumberController.text.isNotEmpty
          ? () async => await viewModel.navigateToPayment(
              method: PaymentMethod.ussd,
              phone: phoneNumberController.text,
              subscription: viewModel.selectedSubscription)
          : null,
      child: _buildPaymentText());

  Widget _buildPaymentText() => Text(
        LocaleKeys.proceed_with_telebirr.tr(),
        style: phoneNumberController.text.isNotEmpty
            ? style16P600
            : style16P600.copyWith(
                color: kcPrimaryColor.withValues(alpha: 0.25)),
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
        LocaleKeys.unlock_all_lessons_practices.tr(),
        style: style14MG400,
        textAlign: TextAlign.center,
      );
}

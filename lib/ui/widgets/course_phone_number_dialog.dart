import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/views/course_practice/course_practice_view.form.dart';
import 'package:yimaru_app/ui/widgets/phone_number_prefix.dart';

import '../common/app_colors.dart';
import '../common/translations/locale_keys.g.dart';
import '../common/ui_helpers.dart';
import '../views/course_practice/course_practice_viewmodel.dart';
import 'custom_elevated_button.dart';

class CoursePhoneNumberDialog extends ViewModelWidget<CoursePracticeViewModel> {
  final GestureTapCallback? onClose;
  final GestureTapCallback? onSubmit;
  final TextEditingController phoneNumberController;

  const CoursePhoneNumberDialog({
    super.key,
    this.onClose,
    this.onSubmit,
    required this.phoneNumberController,
  });

  @override
  Widget build(BuildContext context, CoursePracticeViewModel viewModel) =>
      _buildDialog(viewModel);

  Widget _buildDialog(CoursePracticeViewModel viewModel) => Dialog(
        backgroundColor: kcBackgroundColor,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: _buildColumnWrapper(viewModel),
      );

  Widget _buildColumnWrapper(CoursePracticeViewModel viewModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: _buildColumn(viewModel),
      );

  Widget _buildColumn(CoursePracticeViewModel viewModel) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildDialogChildren(viewModel),
      );

  List<Widget> _buildDialogChildren(CoursePracticeViewModel viewModel) => [
        _buildHeader(),
        verticalSpaceTiny,
        _buildSubtitle(),
        verticalSpaceMedium,
        _buildPhoneNumberWrapper(viewModel),
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          verticalSpaceTiny,
        if (viewModel.hasPhoneNumberValidationMessage &&
            viewModel.focusPhoneNumber)
          _buildPhoneNumberValidatorWrapper(viewModel),
        verticalSpaceMedium,
        _buildContinueButton(),
      ];

  Widget _buildHeader() => Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: _buildTitle(),
          ),
          if (onClose != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onClose,
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: kcVeryLightGrey,
                  child: Icon(Icons.close, size: 16, color: kcMediumGrey),
                ),
              ),
            ),
        ],
      );

  Widget _buildTitle() => Text(
    LocaleKeys.profile_completion.tr(),
    style: style16DG600,
    textAlign: TextAlign.center,
  );

  Widget _buildSubtitle() => Text(
    LocaleKeys.complete_profile.tr(),
    style: style14MG400,
    textAlign: TextAlign.center,
  );

  Widget _buildPhoneNumberWrapper(CoursePracticeViewModel viewModel) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPhoneNumberChildren(viewModel),
      );

  List<Widget> _buildPhoneNumberChildren(CoursePracticeViewModel viewModel) => [
        _buildPhoneNumberPrefix(viewModel),
        horizontalSpaceSmall,
        _buildPhoneNumberFormFieldWrapper(viewModel),
      ];

  Widget _buildPhoneNumberPrefix(CoursePracticeViewModel viewModel) =>
      PhoneNumberPrefix(selected: viewModel.focusPhoneNumber);

  Widget _buildPhoneNumberFormFieldWrapper(CoursePracticeViewModel viewModel) =>
      Expanded(child: _buildPhoneNumberFormField(viewModel));

  Widget _buildPhoneNumberFormField(CoursePracticeViewModel viewModel) =>
      TextFormField(
        maxLength: 9,
        keyboardType: TextInputType.phone,
        controller: phoneNumberController,
        onTap: viewModel.setPhoneNumberFocus,
        decoration: inputDecoration(
          focus: viewModel.focusPhoneNumber,
          filled: phoneNumberController.text.isNotEmpty,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      );

  Widget _buildPhoneNumberValidatorWrapper(CoursePracticeViewModel viewModel) =>
      viewModel.hasPhoneNumberValidationMessage
          ? _buildPhoneNumberValidator(viewModel)
          : Container();

  Widget _buildPhoneNumberValidator(CoursePracticeViewModel viewModel) => Text(
        viewModel.phoneNumberValidationMessage!,
        style: style12R700,
      );

  Widget _buildContinueButton() => CustomElevatedButton(
        height: 50,
        top: false,
        bottom: false,
        onTap: onSubmit,
        borderRadius: 12,
        foregroundColor: kcWhite,
        text: LocaleKeys.submit.tr(),
        backgroundColor: kcPrimaryColor,
      );
}

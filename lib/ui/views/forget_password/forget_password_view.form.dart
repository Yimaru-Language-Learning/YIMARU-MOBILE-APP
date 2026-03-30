// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/validators/form_validator.dart';

const bool _autoTextFieldValidation = true;

const String EmailValueKey = 'email';
const String ResetCodeValueKey = 'resetCode';
const String PasswordValueKey = 'password';
const String ConfirmPasswordValueKey = 'confirmPassword';

final Map<String, TextEditingController>
    _ForgetPasswordViewTextEditingControllers = {};

final Map<String, FocusNode> _ForgetPasswordViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _ForgetPasswordViewTextValidations = {
  EmailValueKey: FormValidator.validateEmailForm,
  ResetCodeValueKey: FormValidator.validateForm,
  PasswordValueKey: FormValidator.validateForm,
  ConfirmPasswordValueKey: FormValidator.validateForm,
};

mixin $ForgetPasswordView {
  TextEditingController get emailController =>
      _getFormTextEditingController(EmailValueKey);
  TextEditingController get resetCodeController =>
      _getFormTextEditingController(ResetCodeValueKey);
  TextEditingController get passwordController =>
      _getFormTextEditingController(PasswordValueKey);
  TextEditingController get confirmPasswordController =>
      _getFormTextEditingController(ConfirmPasswordValueKey);

  FocusNode get emailFocusNode => _getFormFocusNode(EmailValueKey);
  FocusNode get resetCodeFocusNode => _getFormFocusNode(ResetCodeValueKey);
  FocusNode get passwordFocusNode => _getFormFocusNode(PasswordValueKey);
  FocusNode get confirmPasswordFocusNode =>
      _getFormFocusNode(ConfirmPasswordValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_ForgetPasswordViewTextEditingControllers.containsKey(key)) {
      return _ForgetPasswordViewTextEditingControllers[key]!;
    }

    _ForgetPasswordViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ForgetPasswordViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ForgetPasswordViewFocusNodes.containsKey(key)) {
      return _ForgetPasswordViewFocusNodes[key]!;
    }
    _ForgetPasswordViewFocusNodes[key] = FocusNode();
    return _ForgetPasswordViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    emailController.addListener(() => _updateFormData(model));
    resetCodeController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    emailController.addListener(() => _updateFormData(model));
    resetCodeController.addListener(() => _updateFormData(model));
    passwordController.addListener(() => _updateFormData(model));
    confirmPasswordController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          EmailValueKey: emailController.text,
          ResetCodeValueKey: resetCodeController.text,
          PasswordValueKey: passwordController.text,
          ConfirmPasswordValueKey: confirmPasswordController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ForgetPasswordViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ForgetPasswordViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ForgetPasswordViewTextEditingControllers.clear();
    _ForgetPasswordViewFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get emailValue => this.formValueMap[EmailValueKey] as String?;
  String? get resetCodeValue => this.formValueMap[ResetCodeValueKey] as String?;
  String? get passwordValue => this.formValueMap[PasswordValueKey] as String?;
  String? get confirmPasswordValue =>
      this.formValueMap[ConfirmPasswordValueKey] as String?;

  set emailValue(String? value) {
    this.setData(
      this.formValueMap..addAll({EmailValueKey: value}),
    );

    if (_ForgetPasswordViewTextEditingControllers.containsKey(EmailValueKey)) {
      _ForgetPasswordViewTextEditingControllers[EmailValueKey]?.text =
          value ?? '';
    }
  }

  set resetCodeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ResetCodeValueKey: value}),
    );

    if (_ForgetPasswordViewTextEditingControllers.containsKey(
        ResetCodeValueKey)) {
      _ForgetPasswordViewTextEditingControllers[ResetCodeValueKey]?.text =
          value ?? '';
    }
  }

  set passwordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PasswordValueKey: value}),
    );

    if (_ForgetPasswordViewTextEditingControllers.containsKey(
        PasswordValueKey)) {
      _ForgetPasswordViewTextEditingControllers[PasswordValueKey]?.text =
          value ?? '';
    }
  }

  set confirmPasswordValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ConfirmPasswordValueKey: value}),
    );

    if (_ForgetPasswordViewTextEditingControllers.containsKey(
        ConfirmPasswordValueKey)) {
      _ForgetPasswordViewTextEditingControllers[ConfirmPasswordValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasEmail =>
      this.formValueMap.containsKey(EmailValueKey) &&
      (emailValue?.isNotEmpty ?? false);
  bool get hasResetCode =>
      this.formValueMap.containsKey(ResetCodeValueKey) &&
      (resetCodeValue?.isNotEmpty ?? false);
  bool get hasPassword =>
      this.formValueMap.containsKey(PasswordValueKey) &&
      (passwordValue?.isNotEmpty ?? false);
  bool get hasConfirmPassword =>
      this.formValueMap.containsKey(ConfirmPasswordValueKey) &&
      (confirmPasswordValue?.isNotEmpty ?? false);

  bool get hasEmailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey]?.isNotEmpty ?? false;
  bool get hasResetCodeValidationMessage =>
      this.fieldsValidationMessages[ResetCodeValueKey]?.isNotEmpty ?? false;
  bool get hasPasswordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey]?.isNotEmpty ?? false;
  bool get hasConfirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey]?.isNotEmpty ??
      false;

  String? get emailValidationMessage =>
      this.fieldsValidationMessages[EmailValueKey];
  String? get resetCodeValidationMessage =>
      this.fieldsValidationMessages[ResetCodeValueKey];
  String? get passwordValidationMessage =>
      this.fieldsValidationMessages[PasswordValueKey];
  String? get confirmPasswordValidationMessage =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey];
}

extension Methods on FormStateHelper {
  setEmailValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[EmailValueKey] = validationMessage;
  setResetCodeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ResetCodeValueKey] = validationMessage;
  setPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PasswordValueKey] = validationMessage;
  setConfirmPasswordValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ConfirmPasswordValueKey] =
          validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    emailValue = '';
    resetCodeValue = '';
    passwordValue = '';
    confirmPasswordValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      ResetCodeValueKey: getValidationMessage(ResetCodeValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _ForgetPasswordViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _ForgetPasswordViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      EmailValueKey: getValidationMessage(EmailValueKey),
      ResetCodeValueKey: getValidationMessage(ResetCodeValueKey),
      PasswordValueKey: getValidationMessage(PasswordValueKey),
      ConfirmPasswordValueKey: getValidationMessage(ConfirmPasswordValueKey),
    });

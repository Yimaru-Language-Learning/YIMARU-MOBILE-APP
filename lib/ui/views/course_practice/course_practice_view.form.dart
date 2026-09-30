// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/validators/form_validator.dart';

const bool _autoTextFieldValidation = true;

const String PracticeValueKey = 'practice';
const String PhoneNumberValueKey = 'phoneNumber';

final Map<String, TextEditingController>
    _CoursePracticeViewTextEditingControllers = {};

final Map<String, FocusNode> _CoursePracticeViewFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CoursePracticeViewTextValidations = {
  PracticeValueKey: FormValidator.validateForm,
  PhoneNumberValueKey: FormValidator.validatePhoneNumberForm,
};

mixin $CoursePracticeView {
  TextEditingController get practiceController =>
      _getFormTextEditingController(PracticeValueKey);
  TextEditingController get phoneNumberController =>
      _getFormTextEditingController(PhoneNumberValueKey);

  FocusNode get practiceFocusNode => _getFormFocusNode(PracticeValueKey);
  FocusNode get phoneNumberFocusNode => _getFormFocusNode(PhoneNumberValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CoursePracticeViewTextEditingControllers.containsKey(key)) {
      return _CoursePracticeViewTextEditingControllers[key]!;
    }

    _CoursePracticeViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CoursePracticeViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CoursePracticeViewFocusNodes.containsKey(key)) {
      return _CoursePracticeViewFocusNodes[key]!;
    }
    _CoursePracticeViewFocusNodes[key] = FocusNode();
    return _CoursePracticeViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    practiceController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    practiceController.addListener(() => _updateFormData(model));
    phoneNumberController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          PracticeValueKey: practiceController.text,
          PhoneNumberValueKey: phoneNumberController.text,
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

    for (var controller in _CoursePracticeViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CoursePracticeViewFocusNodes.values) {
      focusNode.dispose();
    }

    _CoursePracticeViewTextEditingControllers.clear();
    _CoursePracticeViewFocusNodes.clear();
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

  String? get practiceValue => this.formValueMap[PracticeValueKey] as String?;
  String? get phoneNumberValue =>
      this.formValueMap[PhoneNumberValueKey] as String?;

  set practiceValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PracticeValueKey: value}),
    );

    if (_CoursePracticeViewTextEditingControllers.containsKey(
        PracticeValueKey)) {
      _CoursePracticeViewTextEditingControllers[PracticeValueKey]?.text =
          value ?? '';
    }
  }

  set phoneNumberValue(String? value) {
    this.setData(
      this.formValueMap..addAll({PhoneNumberValueKey: value}),
    );

    if (_CoursePracticeViewTextEditingControllers.containsKey(
        PhoneNumberValueKey)) {
      _CoursePracticeViewTextEditingControllers[PhoneNumberValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasPractice =>
      this.formValueMap.containsKey(PracticeValueKey) &&
      (practiceValue?.isNotEmpty ?? false);
  bool get hasPhoneNumber =>
      this.formValueMap.containsKey(PhoneNumberValueKey) &&
      (phoneNumberValue?.isNotEmpty ?? false);

  bool get hasPracticeValidationMessage =>
      this.fieldsValidationMessages[PracticeValueKey]?.isNotEmpty ?? false;
  bool get hasPhoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey]?.isNotEmpty ?? false;

  String? get practiceValidationMessage =>
      this.fieldsValidationMessages[PracticeValueKey];
  String? get phoneNumberValidationMessage =>
      this.fieldsValidationMessages[PhoneNumberValueKey];
}

extension Methods on FormStateHelper {
  void setPracticeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PracticeValueKey] = validationMessage;
  void setPhoneNumberValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[PhoneNumberValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    practiceValue = '';
    phoneNumberValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      PracticeValueKey: getValidationMessage(PracticeValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CoursePracticeViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CoursePracticeViewTextEditingControllers[key]?.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      PracticeValueKey: getValidationMessage(PracticeValueKey),
      PhoneNumberValueKey: getValidationMessage(PhoneNumberValueKey),
    });

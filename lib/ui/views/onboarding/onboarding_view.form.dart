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

const String FullNameValueKey = 'fullName';
const String RegionValueKey = 'region';

final Map<String, TextEditingController> _OnboardingViewTextEditingControllers =
    {};

final Map<String, FocusNode> _OnboardingViewFocusNodes = {};

final Map<String, String? Function(String?)?> _OnboardingViewTextValidations = {
  FullNameValueKey: FormValidator.validateFullNameForm,
  RegionValueKey: FormValidator.validateForm,
};

mixin $OnboardingView {
  TextEditingController get fullNameController =>
      _getFormTextEditingController(FullNameValueKey);
  TextEditingController get regionController =>
      _getFormTextEditingController(RegionValueKey);

  FocusNode get fullNameFocusNode => _getFormFocusNode(FullNameValueKey);
  FocusNode get regionFocusNode => _getFormFocusNode(RegionValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_OnboardingViewTextEditingControllers.containsKey(key)) {
      return _OnboardingViewTextEditingControllers[key]!;
    }

    _OnboardingViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _OnboardingViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_OnboardingViewFocusNodes.containsKey(key)) {
      return _OnboardingViewFocusNodes[key]!;
    }
    _OnboardingViewFocusNodes[key] = FocusNode();
    return _OnboardingViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    fullNameController.addListener(() => _updateFormData(model));
    regionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    fullNameController.addListener(() => _updateFormData(model));
    regionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          FullNameValueKey: fullNameController.text,
          RegionValueKey: regionController.text,
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

    for (var controller in _OnboardingViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _OnboardingViewFocusNodes.values) {
      focusNode.dispose();
    }

    _OnboardingViewTextEditingControllers.clear();
    _OnboardingViewFocusNodes.clear();
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

  String? get fullNameValue => this.formValueMap[FullNameValueKey] as String?;
  String? get regionValue => this.formValueMap[RegionValueKey] as String?;

  set fullNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({FullNameValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(FullNameValueKey)) {
      _OnboardingViewTextEditingControllers[FullNameValueKey]?.text =
          value ?? '';
    }
  }

  set regionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({RegionValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(RegionValueKey)) {
      _OnboardingViewTextEditingControllers[RegionValueKey]?.text = value ?? '';
    }
  }

  bool get hasFullName =>
      this.formValueMap.containsKey(FullNameValueKey) &&
      (fullNameValue?.isNotEmpty ?? false);
  bool get hasRegion =>
      this.formValueMap.containsKey(RegionValueKey) &&
      (regionValue?.isNotEmpty ?? false);

  bool get hasFullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey]?.isNotEmpty ?? false;
  bool get hasRegionValidationMessage =>
      this.fieldsValidationMessages[RegionValueKey]?.isNotEmpty ?? false;

  String? get fullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey];
  String? get regionValidationMessage =>
      this.fieldsValidationMessages[RegionValueKey];
}

extension Methods on FormStateHelper {
  void setFullNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullNameValueKey] = validationMessage;
  void setRegionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RegionValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    fullNameValue = '';
    regionValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      RegionValueKey: getValidationMessage(RegionValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _OnboardingViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _OnboardingViewTextEditingControllers[key]?.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      RegionValueKey: getValidationMessage(RegionValueKey),
    });

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/validators/form_validator.dart';

const bool _autoTextFieldValidation = true;

const String AssessmentValueKey = 'assessment';

final Map<String, TextEditingController> _DuolingoViewTextEditingControllers =
    {};

final Map<String, FocusNode> _DuolingoViewFocusNodes = {};

final Map<String, String? Function(String?)?> _DuolingoViewTextValidations = {
  AssessmentValueKey: FormValidator.validateForm,
};

mixin $DuolingoView {
  TextEditingController get assessmentController =>
      _getFormTextEditingController(AssessmentValueKey);

  FocusNode get assessmentFocusNode => _getFormFocusNode(AssessmentValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_DuolingoViewTextEditingControllers.containsKey(key)) {
      return _DuolingoViewTextEditingControllers[key]!;
    }

    _DuolingoViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _DuolingoViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_DuolingoViewFocusNodes.containsKey(key)) {
      return _DuolingoViewFocusNodes[key]!;
    }
    _DuolingoViewFocusNodes[key] = FocusNode();
    return _DuolingoViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    assessmentController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    assessmentController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AssessmentValueKey: assessmentController.text,
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

    for (var controller in _DuolingoViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _DuolingoViewFocusNodes.values) {
      focusNode.dispose();
    }

    _DuolingoViewTextEditingControllers.clear();
    _DuolingoViewFocusNodes.clear();
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

  String? get assessmentValue =>
      this.formValueMap[AssessmentValueKey] as String?;

  set assessmentValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AssessmentValueKey: value}),
    );

    if (_DuolingoViewTextEditingControllers.containsKey(AssessmentValueKey)) {
      _DuolingoViewTextEditingControllers[AssessmentValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasAssessment =>
      this.formValueMap.containsKey(AssessmentValueKey) &&
      (assessmentValue?.isNotEmpty ?? false);

  bool get hasAssessmentValidationMessage =>
      this.fieldsValidationMessages[AssessmentValueKey]?.isNotEmpty ?? false;

  String? get assessmentValidationMessage =>
      this.fieldsValidationMessages[AssessmentValueKey];
}

extension Methods on FormStateHelper {
  setAssessmentValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AssessmentValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    assessmentValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AssessmentValueKey: getValidationMessage(AssessmentValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _DuolingoViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _DuolingoViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AssessmentValueKey: getValidationMessage(AssessmentValueKey),
    });

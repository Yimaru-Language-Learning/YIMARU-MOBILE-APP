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

const String TypeValueKey = 'type';
const String SubjectValueKey = 'subject';
const String DescriptionValueKey = 'description';

final Map<String, TextEditingController>
    _InAppSupportViewTextEditingControllers = {};

final Map<String, FocusNode> _InAppSupportViewFocusNodes = {};

final Map<String, String? Function(String?)?> _InAppSupportViewTextValidations =
    {
  TypeValueKey: FormValidator.validateForm,
  SubjectValueKey: FormValidator.validateForm,
  DescriptionValueKey: FormValidator.validateForm,
};

mixin $InAppSupportView {
  TextEditingController get typeController =>
      _getFormTextEditingController(TypeValueKey);
  TextEditingController get subjectController =>
      _getFormTextEditingController(SubjectValueKey);
  TextEditingController get descriptionController =>
      _getFormTextEditingController(DescriptionValueKey);

  FocusNode get typeFocusNode => _getFormFocusNode(TypeValueKey);
  FocusNode get subjectFocusNode => _getFormFocusNode(SubjectValueKey);
  FocusNode get descriptionFocusNode => _getFormFocusNode(DescriptionValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_InAppSupportViewTextEditingControllers.containsKey(key)) {
      return _InAppSupportViewTextEditingControllers[key]!;
    }

    _InAppSupportViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _InAppSupportViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_InAppSupportViewFocusNodes.containsKey(key)) {
      return _InAppSupportViewFocusNodes[key]!;
    }
    _InAppSupportViewFocusNodes[key] = FocusNode();
    return _InAppSupportViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    typeController.addListener(() => _updateFormData(model));
    subjectController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    typeController.addListener(() => _updateFormData(model));
    subjectController.addListener(() => _updateFormData(model));
    descriptionController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TypeValueKey: typeController.text,
          SubjectValueKey: subjectController.text,
          DescriptionValueKey: descriptionController.text,
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

    for (var controller in _InAppSupportViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _InAppSupportViewFocusNodes.values) {
      focusNode.dispose();
    }

    _InAppSupportViewTextEditingControllers.clear();
    _InAppSupportViewFocusNodes.clear();
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

  String? get typeValue => this.formValueMap[TypeValueKey] as String?;
  String? get subjectValue => this.formValueMap[SubjectValueKey] as String?;
  String? get descriptionValue =>
      this.formValueMap[DescriptionValueKey] as String?;

  set typeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TypeValueKey: value}),
    );

    if (_InAppSupportViewTextEditingControllers.containsKey(TypeValueKey)) {
      _InAppSupportViewTextEditingControllers[TypeValueKey]?.text = value ?? '';
    }
  }

  set subjectValue(String? value) {
    this.setData(
      this.formValueMap..addAll({SubjectValueKey: value}),
    );

    if (_InAppSupportViewTextEditingControllers.containsKey(SubjectValueKey)) {
      _InAppSupportViewTextEditingControllers[SubjectValueKey]?.text =
          value ?? '';
    }
  }

  set descriptionValue(String? value) {
    this.setData(
      this.formValueMap..addAll({DescriptionValueKey: value}),
    );

    if (_InAppSupportViewTextEditingControllers.containsKey(
        DescriptionValueKey)) {
      _InAppSupportViewTextEditingControllers[DescriptionValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasType =>
      this.formValueMap.containsKey(TypeValueKey) &&
      (typeValue?.isNotEmpty ?? false);
  bool get hasSubject =>
      this.formValueMap.containsKey(SubjectValueKey) &&
      (subjectValue?.isNotEmpty ?? false);
  bool get hasDescription =>
      this.formValueMap.containsKey(DescriptionValueKey) &&
      (descriptionValue?.isNotEmpty ?? false);

  bool get hasTypeValidationMessage =>
      this.fieldsValidationMessages[TypeValueKey]?.isNotEmpty ?? false;
  bool get hasSubjectValidationMessage =>
      this.fieldsValidationMessages[SubjectValueKey]?.isNotEmpty ?? false;
  bool get hasDescriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey]?.isNotEmpty ?? false;

  String? get typeValidationMessage =>
      this.fieldsValidationMessages[TypeValueKey];
  String? get subjectValidationMessage =>
      this.fieldsValidationMessages[SubjectValueKey];
  String? get descriptionValidationMessage =>
      this.fieldsValidationMessages[DescriptionValueKey];
}

extension Methods on FormStateHelper {
  void setTypeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TypeValueKey] = validationMessage;
  void setSubjectValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[SubjectValueKey] = validationMessage;
  void setDescriptionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[DescriptionValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    typeValue = '';
    subjectValue = '';
    descriptionValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TypeValueKey: getValidationMessage(TypeValueKey),
      SubjectValueKey: getValidationMessage(SubjectValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _InAppSupportViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _InAppSupportViewTextEditingControllers[key]?.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TypeValueKey: getValidationMessage(TypeValueKey),
      SubjectValueKey: getValidationMessage(SubjectValueKey),
      DescriptionValueKey: getValidationMessage(DescriptionValueKey),
    });

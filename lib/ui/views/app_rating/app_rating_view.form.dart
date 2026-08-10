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

const String ReviewValueKey = 'review';

final Map<String, TextEditingController> _AppRatingViewTextEditingControllers =
    {};

final Map<String, FocusNode> _AppRatingViewFocusNodes = {};

final Map<String, String? Function(String?)?> _AppRatingViewTextValidations = {
  ReviewValueKey: FormValidator.validateForm,
};

mixin $AppRatingView {
  TextEditingController get reviewController =>
      _getFormTextEditingController(ReviewValueKey);

  FocusNode get reviewFocusNode => _getFormFocusNode(ReviewValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_AppRatingViewTextEditingControllers.containsKey(key)) {
      return _AppRatingViewTextEditingControllers[key]!;
    }

    _AppRatingViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _AppRatingViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_AppRatingViewFocusNodes.containsKey(key)) {
      return _AppRatingViewFocusNodes[key]!;
    }
    _AppRatingViewFocusNodes[key] = FocusNode();
    return _AppRatingViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    reviewController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    reviewController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          ReviewValueKey: reviewController.text,
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

    for (var controller in _AppRatingViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _AppRatingViewFocusNodes.values) {
      focusNode.dispose();
    }

    _AppRatingViewTextEditingControllers.clear();
    _AppRatingViewFocusNodes.clear();
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

  String? get reviewValue => this.formValueMap[ReviewValueKey] as String?;

  set reviewValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ReviewValueKey: value}),
    );

    if (_AppRatingViewTextEditingControllers.containsKey(ReviewValueKey)) {
      _AppRatingViewTextEditingControllers[ReviewValueKey]?.text = value ?? '';
    }
  }

  bool get hasReview =>
      this.formValueMap.containsKey(ReviewValueKey) &&
      (reviewValue?.isNotEmpty ?? false);

  bool get hasReviewValidationMessage =>
      this.fieldsValidationMessages[ReviewValueKey]?.isNotEmpty ?? false;

  String? get reviewValidationMessage =>
      this.fieldsValidationMessages[ReviewValueKey];
}

extension Methods on FormStateHelper {
  void setReviewValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ReviewValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    reviewValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      ReviewValueKey: getValidationMessage(ReviewValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _AppRatingViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _AppRatingViewTextEditingControllers[key]?.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      ReviewValueKey: getValidationMessage(ReviewValueKey),
    });

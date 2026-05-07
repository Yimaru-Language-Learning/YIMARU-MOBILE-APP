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

const String TopicValueKey = 'topic';
const String FullNameValueKey = 'fullName';
const String RegionValueKey = 'region';
const String ChallengeValueKey = 'challenge';
const String LanguageGoalValueKey = 'languageGoal';

final Map<String, TextEditingController> _OnboardingViewTextEditingControllers =
    {};

final Map<String, FocusNode> _OnboardingViewFocusNodes = {};

final Map<String, String? Function(String?)?> _OnboardingViewTextValidations = {
  TopicValueKey: FormValidator.validateForm,
  FullNameValueKey: FormValidator.validateFullNameForm,
  RegionValueKey: FormValidator.validateForm,
  ChallengeValueKey: FormValidator.validateForm,
  LanguageGoalValueKey: FormValidator.validateForm,
};

mixin $OnboardingView {
  TextEditingController get topicController =>
      _getFormTextEditingController(TopicValueKey);
  TextEditingController get fullNameController =>
      _getFormTextEditingController(FullNameValueKey);
  TextEditingController get regionController =>
      _getFormTextEditingController(RegionValueKey);
  TextEditingController get challengeController =>
      _getFormTextEditingController(ChallengeValueKey);
  TextEditingController get languageGoalController =>
      _getFormTextEditingController(LanguageGoalValueKey);

  FocusNode get topicFocusNode => _getFormFocusNode(TopicValueKey);
  FocusNode get fullNameFocusNode => _getFormFocusNode(FullNameValueKey);
  FocusNode get regionFocusNode => _getFormFocusNode(RegionValueKey);
  FocusNode get challengeFocusNode => _getFormFocusNode(ChallengeValueKey);
  FocusNode get languageGoalFocusNode =>
      _getFormFocusNode(LanguageGoalValueKey);

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
    topicController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    regionController.addListener(() => _updateFormData(model));
    challengeController.addListener(() => _updateFormData(model));
    languageGoalController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    topicController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    regionController.addListener(() => _updateFormData(model));
    challengeController.addListener(() => _updateFormData(model));
    languageGoalController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TopicValueKey: topicController.text,
          FullNameValueKey: fullNameController.text,
          RegionValueKey: regionController.text,
          ChallengeValueKey: challengeController.text,
          LanguageGoalValueKey: languageGoalController.text,
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

  String? get topicValue => this.formValueMap[TopicValueKey] as String?;
  String? get fullNameValue => this.formValueMap[FullNameValueKey] as String?;
  String? get regionValue => this.formValueMap[RegionValueKey] as String?;
  String? get challengeValue => this.formValueMap[ChallengeValueKey] as String?;
  String? get languageGoalValue =>
      this.formValueMap[LanguageGoalValueKey] as String?;

  set topicValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TopicValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(TopicValueKey)) {
      _OnboardingViewTextEditingControllers[TopicValueKey]?.text = value ?? '';
    }
  }

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

  set challengeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ChallengeValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(ChallengeValueKey)) {
      _OnboardingViewTextEditingControllers[ChallengeValueKey]?.text =
          value ?? '';
    }
  }

  set languageGoalValue(String? value) {
    this.setData(
      this.formValueMap..addAll({LanguageGoalValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(
        LanguageGoalValueKey)) {
      _OnboardingViewTextEditingControllers[LanguageGoalValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasTopic =>
      this.formValueMap.containsKey(TopicValueKey) &&
      (topicValue?.isNotEmpty ?? false);
  bool get hasFullName =>
      this.formValueMap.containsKey(FullNameValueKey) &&
      (fullNameValue?.isNotEmpty ?? false);
  bool get hasRegion =>
      this.formValueMap.containsKey(RegionValueKey) &&
      (regionValue?.isNotEmpty ?? false);
  bool get hasChallenge =>
      this.formValueMap.containsKey(ChallengeValueKey) &&
      (challengeValue?.isNotEmpty ?? false);
  bool get hasLanguageGoal =>
      this.formValueMap.containsKey(LanguageGoalValueKey) &&
      (languageGoalValue?.isNotEmpty ?? false);

  bool get hasTopicValidationMessage =>
      this.fieldsValidationMessages[TopicValueKey]?.isNotEmpty ?? false;
  bool get hasFullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey]?.isNotEmpty ?? false;
  bool get hasRegionValidationMessage =>
      this.fieldsValidationMessages[RegionValueKey]?.isNotEmpty ?? false;
  bool get hasChallengeValidationMessage =>
      this.fieldsValidationMessages[ChallengeValueKey]?.isNotEmpty ?? false;
  bool get hasLanguageGoalValidationMessage =>
      this.fieldsValidationMessages[LanguageGoalValueKey]?.isNotEmpty ?? false;

  String? get topicValidationMessage =>
      this.fieldsValidationMessages[TopicValueKey];
  String? get fullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey];
  String? get regionValidationMessage =>
      this.fieldsValidationMessages[RegionValueKey];
  String? get challengeValidationMessage =>
      this.fieldsValidationMessages[ChallengeValueKey];
  String? get languageGoalValidationMessage =>
      this.fieldsValidationMessages[LanguageGoalValueKey];
}

extension Methods on FormStateHelper {
  void setTopicValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TopicValueKey] = validationMessage;
  void setFullNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullNameValueKey] = validationMessage;
  void setRegionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[RegionValueKey] = validationMessage;
  void setChallengeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ChallengeValueKey] = validationMessage;
  void setLanguageGoalValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LanguageGoalValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    topicValue = '';
    fullNameValue = '';
    regionValue = '';
    challengeValue = '';
    languageGoalValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TopicValueKey: getValidationMessage(TopicValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      RegionValueKey: getValidationMessage(RegionValueKey),
      ChallengeValueKey: getValidationMessage(ChallengeValueKey),
      LanguageGoalValueKey: getValidationMessage(LanguageGoalValueKey),
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
      TopicValueKey: getValidationMessage(TopicValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      RegionValueKey: getValidationMessage(RegionValueKey),
      ChallengeValueKey: getValidationMessage(ChallengeValueKey),
      LanguageGoalValueKey: getValidationMessage(LanguageGoalValueKey),
    });

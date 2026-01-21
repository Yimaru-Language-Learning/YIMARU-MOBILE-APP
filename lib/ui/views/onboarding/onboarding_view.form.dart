// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/validators/form_validator.dart';

const bool _autoTextFieldValidation = true;

const String AnswerValueKey = 'answer';
const String FullNameValueKey = 'fullName';
const String ChallengeValueKey = 'challenge';
const String OccupationValueKey = 'occupation';
const String LanguageGoalValueKey = 'languageGoal';
const String TopicValueKey = 'topic';

final Map<String, TextEditingController> _OnboardingViewTextEditingControllers =
    {};

final Map<String, FocusNode> _OnboardingViewFocusNodes = {};

final Map<String, String? Function(String?)?> _OnboardingViewTextValidations = {
  AnswerValueKey: FormValidator.validateForm,
  FullNameValueKey: FormValidator.validateForm,
  ChallengeValueKey: FormValidator.validateForm,
  OccupationValueKey: FormValidator.validateForm,
  LanguageGoalValueKey: FormValidator.validateForm,
  TopicValueKey: FormValidator.validateForm,
};

mixin $OnboardingView {
  TextEditingController get answerController =>
      _getFormTextEditingController(AnswerValueKey);
  TextEditingController get fullNameController =>
      _getFormTextEditingController(FullNameValueKey);
  TextEditingController get challengeController =>
      _getFormTextEditingController(ChallengeValueKey);
  TextEditingController get occupationController =>
      _getFormTextEditingController(OccupationValueKey);
  TextEditingController get languageGoalController =>
      _getFormTextEditingController(LanguageGoalValueKey);
  TextEditingController get topicController =>
      _getFormTextEditingController(TopicValueKey);

  FocusNode get answerFocusNode => _getFormFocusNode(AnswerValueKey);
  FocusNode get fullNameFocusNode => _getFormFocusNode(FullNameValueKey);
  FocusNode get challengeFocusNode => _getFormFocusNode(ChallengeValueKey);
  FocusNode get occupationFocusNode => _getFormFocusNode(OccupationValueKey);
  FocusNode get languageGoalFocusNode =>
      _getFormFocusNode(LanguageGoalValueKey);
  FocusNode get topicFocusNode => _getFormFocusNode(TopicValueKey);

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
    answerController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    challengeController.addListener(() => _updateFormData(model));
    occupationController.addListener(() => _updateFormData(model));
    languageGoalController.addListener(() => _updateFormData(model));
    topicController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    answerController.addListener(() => _updateFormData(model));
    fullNameController.addListener(() => _updateFormData(model));
    challengeController.addListener(() => _updateFormData(model));
    occupationController.addListener(() => _updateFormData(model));
    languageGoalController.addListener(() => _updateFormData(model));
    topicController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          AnswerValueKey: answerController.text,
          FullNameValueKey: fullNameController.text,
          ChallengeValueKey: challengeController.text,
          OccupationValueKey: occupationController.text,
          LanguageGoalValueKey: languageGoalController.text,
          TopicValueKey: topicController.text,
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

  String? get answerValue => this.formValueMap[AnswerValueKey] as String?;
  String? get fullNameValue => this.formValueMap[FullNameValueKey] as String?;
  String? get challengeValue => this.formValueMap[ChallengeValueKey] as String?;
  String? get occupationValue =>
      this.formValueMap[OccupationValueKey] as String?;
  String? get languageGoalValue =>
      this.formValueMap[LanguageGoalValueKey] as String?;
  String? get topicValue => this.formValueMap[TopicValueKey] as String?;

  set answerValue(String? value) {
    this.setData(
      this.formValueMap..addAll({AnswerValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(AnswerValueKey)) {
      _OnboardingViewTextEditingControllers[AnswerValueKey]?.text = value ?? '';
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

  set challengeValue(String? value) {
    this.setData(
      this.formValueMap..addAll({ChallengeValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(ChallengeValueKey)) {
      _OnboardingViewTextEditingControllers[ChallengeValueKey]?.text =
          value ?? '';
    }
  }

  set occupationValue(String? value) {
    this.setData(
      this.formValueMap..addAll({OccupationValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(OccupationValueKey)) {
      _OnboardingViewTextEditingControllers[OccupationValueKey]?.text =
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

  set topicValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TopicValueKey: value}),
    );

    if (_OnboardingViewTextEditingControllers.containsKey(TopicValueKey)) {
      _OnboardingViewTextEditingControllers[TopicValueKey]?.text = value ?? '';
    }
  }

  bool get hasAnswer =>
      this.formValueMap.containsKey(AnswerValueKey) &&
      (answerValue?.isNotEmpty ?? false);
  bool get hasFullName =>
      this.formValueMap.containsKey(FullNameValueKey) &&
      (fullNameValue?.isNotEmpty ?? false);
  bool get hasChallenge =>
      this.formValueMap.containsKey(ChallengeValueKey) &&
      (challengeValue?.isNotEmpty ?? false);
  bool get hasOccupation =>
      this.formValueMap.containsKey(OccupationValueKey) &&
      (occupationValue?.isNotEmpty ?? false);
  bool get hasLanguageGoal =>
      this.formValueMap.containsKey(LanguageGoalValueKey) &&
      (languageGoalValue?.isNotEmpty ?? false);
  bool get hasTopic =>
      this.formValueMap.containsKey(TopicValueKey) &&
      (topicValue?.isNotEmpty ?? false);

  bool get hasAnswerValidationMessage =>
      this.fieldsValidationMessages[AnswerValueKey]?.isNotEmpty ?? false;
  bool get hasFullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey]?.isNotEmpty ?? false;
  bool get hasChallengeValidationMessage =>
      this.fieldsValidationMessages[ChallengeValueKey]?.isNotEmpty ?? false;
  bool get hasOccupationValidationMessage =>
      this.fieldsValidationMessages[OccupationValueKey]?.isNotEmpty ?? false;
  bool get hasLanguageGoalValidationMessage =>
      this.fieldsValidationMessages[LanguageGoalValueKey]?.isNotEmpty ?? false;
  bool get hasTopicValidationMessage =>
      this.fieldsValidationMessages[TopicValueKey]?.isNotEmpty ?? false;

  String? get answerValidationMessage =>
      this.fieldsValidationMessages[AnswerValueKey];
  String? get fullNameValidationMessage =>
      this.fieldsValidationMessages[FullNameValueKey];
  String? get challengeValidationMessage =>
      this.fieldsValidationMessages[ChallengeValueKey];
  String? get occupationValidationMessage =>
      this.fieldsValidationMessages[OccupationValueKey];
  String? get languageGoalValidationMessage =>
      this.fieldsValidationMessages[LanguageGoalValueKey];
  String? get topicValidationMessage =>
      this.fieldsValidationMessages[TopicValueKey];
}

extension Methods on FormStateHelper {
  setAnswerValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[AnswerValueKey] = validationMessage;
  setFullNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[FullNameValueKey] = validationMessage;
  setChallengeValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[ChallengeValueKey] = validationMessage;
  setOccupationValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[OccupationValueKey] = validationMessage;
  setLanguageGoalValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[LanguageGoalValueKey] = validationMessage;
  setTopicValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TopicValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    answerValue = '';
    fullNameValue = '';
    challengeValue = '';
    occupationValue = '';
    languageGoalValue = '';
    topicValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      AnswerValueKey: getValidationMessage(AnswerValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      ChallengeValueKey: getValidationMessage(ChallengeValueKey),
      OccupationValueKey: getValidationMessage(OccupationValueKey),
      LanguageGoalValueKey: getValidationMessage(LanguageGoalValueKey),
      TopicValueKey: getValidationMessage(TopicValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _OnboardingViewTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _OnboardingViewTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      AnswerValueKey: getValidationMessage(AnswerValueKey),
      FullNameValueKey: getValidationMessage(FullNameValueKey),
      ChallengeValueKey: getValidationMessage(ChallengeValueKey),
      OccupationValueKey: getValidationMessage(OccupationValueKey),
      LanguageGoalValueKey: getValidationMessage(LanguageGoalValueKey),
      TopicValueKey: getValidationMessage(TopicValueKey),
    });

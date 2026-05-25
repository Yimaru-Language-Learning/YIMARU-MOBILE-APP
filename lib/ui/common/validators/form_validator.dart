import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';

class FormValidator {
  // Form validator
  static String? validateForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return LocaleKeys.required_field.tr();
    }

    return null;
  }

  // Full name validator
  static String? validateFullNameForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return LocaleKeys.required_field.tr();
    }
    final regex = RegExp(r'^\S+\s+\S+.*$');

    if (!regex.hasMatch(value.trim())) {
      return LocaleKeys.enter_full_name.tr();
    }
    return null;
  }

  // Email validator
  static String? validateEmailForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return LocaleKeys.required_field.tr();
    }

    if (!EmailValidator.validate(value)) {
      return LocaleKeys.invalid_email.tr();
    }

    return null;
  }

  // Password validator
  static String? validatePasswordForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return  LocaleKeys.required_field.tr();
    }
    return null;
  }

  // Phone number validator
  static String? validatePhoneNumberForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return LocaleKeys.required_field.tr();
    }

    // Regex validation
    final regex = RegExp(r'^251');

    if (!regex.hasMatch(value)) {
      return LocaleKeys.phone_must_start_with.tr();
    }

    // Length check first (optional but recommended)
    if (value.length != 12) {
      return LocaleKeys.phone_must_be.tr();
    }
    return null;
  }
}

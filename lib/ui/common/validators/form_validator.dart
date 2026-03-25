import 'package:email_validator/email_validator.dart';

class FormValidator {
  // Form validator
  static String? validateForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }

    return null;
  }

  // Form validator
  static String? validateFullNameForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }
    final regex = RegExp(r'^\S+\s+\S+.*$');

    if (!regex.hasMatch(value.trim())) {
      return "Enter your full name";
    }
    return null;
  }

  // Email validator
  static String? validateEmailForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }

    if (!EmailValidator.validate(value)) {
      return 'Invalid email format';
    }

    return null;
  }

  // Password validator
  static String? validatePasswordForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }
    return null;
  }

  // Phone number validator
  static String? validatePhoneNumberForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }

    // Regex validation
    final regex = RegExp(r'^251');

    if (!regex.hasMatch(value)) {
      return 'Phone number must start with 251';
    }

    // Length check first (optional but recommended)
    if (value.length != 12) {
      return 'Phone number must be 12 digits';
    }
    return null;
  }
}

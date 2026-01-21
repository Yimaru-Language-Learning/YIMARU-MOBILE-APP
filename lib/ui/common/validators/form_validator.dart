import 'package:email_validator/email_validator.dart';

class FormValidator {
  static String? validateForm(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
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

  static String? validateEmail(String? value) {
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

  static String? validatePassword(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'The field is required';
    }
    return null;
  }
}

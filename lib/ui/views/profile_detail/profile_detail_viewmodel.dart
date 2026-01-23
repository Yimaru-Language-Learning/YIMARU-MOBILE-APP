import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/authentication_service.dart';

class ProfileDetailViewModel extends FormViewModel {
  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  late final UserModel? _user = _authenticationService.user;

  UserModel? get user => _user;

  // First name
  bool _focusFirstName = false;

  bool get focusFirstName => _focusFirstName;

  // Last name
  bool _focusLastName = false;

  bool get focusLastName => _focusLastName;

  // Gender
  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  // Birthday
  String? _selectedBirthday;

  String? get selectedBirthday => _selectedBirthday;

  // First name
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  // First name
  void setFirstNameFocus() {
    _focusFirstName = true;
    rebuildUi();
  }

  // Last name
  void setLastNameFocus() {
    _focusLastName = true;
    rebuildUi();
  }

  // Gender
  void setGender(String value) {
    _selectedGender = value;
    rebuildUi();
  }

  // Birthday
  void setBirthday(String value) {
    _selectedBirthday = value;
    rebuildUi();
  }

  // Phone number
  void setPhoneNumberFocus() {
    _focusPhoneNumber = true;
    rebuildUi();
  }

  // Email
  void setEmailFocus() {
    _focusEmail = true;
    rebuildUi();
  }

  // Country
  Future<List<String>> getCountries() async => ['Ethiopia', 'Djibouti'];

  // Region
  Future<List<String>> getRegions(String country) async =>
      ['Addis Ababa', 'Oromia'];

  // Occupation
  Future<List<String>> getOccupations(String country) async =>
      ['Student', 'Worker'];

  void pop() => _navigationService.back();
}

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/image_picker_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class ProfileDetailViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _navigationService = locator<NavigationService>();

  final _imagePickerService = locator<ImagePickerService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  User? get _user => _authenticationService.user;

  User? get user => _user;

  // First name
  bool _focusFirstName = false;

  bool get focusFirstName => _focusFirstName;

  // Last name
  bool _focusLastName = false;

  bool get focusLastName => _focusLastName;

  // Gender
  String? _selectedGender;

  String? get selectedGender => _selectedGender;


  // First name
  bool _focusPhoneNumber = false;

  bool get focusPhoneNumber => _focusPhoneNumber;

  // Email
  bool _focusEmail = false;

  bool get focusEmail => _focusEmail;

  // Country
  String _selectedCountry = 'Ethiopia';

  String get selectedCountry => _selectedCountry;


  // Occupation
  bool _focusOccupation = false;

  bool get focusOccupation => _focusOccupation;

  // Region
  bool _focusRegion = false;

  bool get focusRegion => _focusRegion;

  // User data
  final Map<String, dynamic> _userData = {};

  Map<String, dynamic> get userData => _userData;

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
  // Country
  List<String> getCountries() => [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahrain",
    "Bangladesh",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Guatemala",
    "Guinea",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Liberia",
    "Libya",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Korea",
    "Norway",
    "Oman",
    "Pakistan",
    "Panama",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Somalia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Tunisia",
    "Turkey",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  void setSelectedCountry(String value) {
    _selectedCountry = value;


    rebuildUi();
  }


  // Occupation
  void setOccupationFocus() {
    _focusOccupation = true;
    rebuildUi();
  }

  // Region
  void setRegionFocus() {
    _focusRegion = true;
    rebuildUi();
  }

  // User data
  void addUserData(Map<String, dynamic> data) {
    _userData.addAll(data);
  }

  void clearUserData() {
    _userData.clear();
  }

  // Image picker
  Future<void> openCamera() async =>
      runBusyFuture(_openCamera(), busyObject: StateObjects.profileImage);

  Future<void> _openCamera() async {
    String? image = await _imagePickerService.camera();
    pop();
    if (image != null) {
      await updateProfilePicture(image);
      await _authenticationService.saveProfilePicture(image);
    }
  }

  Future<void> openGallery() async =>
      runBusyFuture(_openGallery(), busyObject: StateObjects.profileImage);

  Future<void> _openGallery() async {
    String? image = await _imagePickerService.gallery();
    pop();
    if (image != null) {
      await updateProfilePicture(image);
      await _authenticationService.saveProfilePicture(image);
    }
  }

  // Navigation
  void pop() => _navigationService.back();

  // Remote api call

  // Get profile
  Future<void> getProfile() async => await runBusyFuture(_getProfile());

  Future<void> _getProfile() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.getProfileData(_user?.userId);
      if (response['status'] == ResponseStatus.success) {
        addUserData(response['data']);
      }
    }
  }

  // Update  profile
  Future<void> updateProfile() async => await runBusyFuture(_updateProfile(),
      busyObject: StateObjects.profileUpdate);

  Future<void> _updateProfile() async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> response =
          await _apiService.completeProfile(_userData);
      if (response['status'] == ResponseStatus.success) {
        await _authenticationService.updateUserData(_userData);
        pop();
        showSuccessToast(response['message']);
      } else {
        showErrorToast(response['message']);
      }
    }
  }

  // Update profile picture
  Future<void> updateProfilePicture(String image) async =>
      await runBusyFuture(_updateProfilePicture(image));

  Future<void> _updateProfilePicture(String image) async {
    if (await _statusChecker.checkConnection()) {
      Map<String, dynamic> data = {'profile_picture_url': image};
      await _apiService.updateProfileImage(data: data, userId: _user?.userId);
    }
  }
}

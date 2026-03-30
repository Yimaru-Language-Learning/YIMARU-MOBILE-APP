import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
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
  UserModel? get _user => _authenticationService.user;

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

  // Country
  String _selectedCountry = 'Ethiopia';

  String get selectedCountry => _selectedCountry;

  // Region
  String _selectedRegion = 'Addis Ababa';

  String get selectedRegion => _selectedRegion;

  // Occupation
  bool _focusOccupation = false;

  bool get focusOccupation => _focusOccupation;

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
  List<String> getCountries() => ['Ethiopia', 'Other'];

  void setSelectedCountry(String value) {
    _selectedCountry = value;
    if (selectedCountry != 'Ethiopia') {
      _selectedRegion = 'Other';
    } else {
      _selectedRegion = 'Addis Ababa';
    }

    rebuildUi();
  }

  // Region
  List<String> getRegions(String country) {
    if (country == 'Ethiopia') {
      return [
        'Afar',
        'SNNPR',
        'Amhara',
        'Harari',
        'Oromia',
        'Sidama',
        'Somali',
        'Tigray',
        'Gambela',
        'Dire Dawa',
        'Addis Ababa',
        'Central Ethiopia',
        'Benishangul-Gumuz',
        'South West Ethiopia',
      ];
    } else {
      return ['Other'];
    }
  }

  void setSelectedRegion(String value) {
    _selectedRegion = value;
    rebuildUi();
  }

  // Occupation
  void setOccupationFocus() {
    _focusOccupation = true;
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

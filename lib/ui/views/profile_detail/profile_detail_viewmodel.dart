import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/field_option.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/authentication_service.dart';
import '../../../services/image_picker_service.dart';
import '../../../services/onboarding_service.dart';
import '../../../services/status_checker_service.dart';
import '../../common/enmus.dart';
import '../../common/ui_helpers.dart';

class ProfileDetailViewModel extends ReactiveViewModel
    with FormStateHelper
    implements FormViewModel {
  final _apiService = locator<ApiService>();

  final _statusChecker = locator<StatusCheckerService>();

  final _onboardingService = locator<OnboardingService>();

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

  // Occupation
  FieldOption? _selectedOccupation;

  FieldOption? get selectedOccupation => _selectedOccupation;

  // Country
  FieldOption? _selectedCountry;

  FieldOption? get selectedCountry => _selectedCountry;

  // Region
  bool _focusRegion = false;

  bool get focusRegion => _focusRegion;

  bool _dropdownRegion = true;

  bool get dropdownRegion => _dropdownRegion;

  FieldOption? _selectedRegion;

  FieldOption? get selectedRegion => _selectedRegion;

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
  void setSelectedGender(String value) {
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

  // Occupation
  List<FieldOption> get _occupations => _onboardingService.occupations;

  List<FieldOption> get occupations => _occupations;

  void setSelectedOccupation(FieldOption? value) {
    _selectedOccupation = value;
    rebuildUi();
  }

  // Country
  List<FieldOption> get _countries => _onboardingService.countries;

  List<FieldOption> get countries => _countries;

  void setSelectedCountry(FieldOption? value) {
    _selectedCountry = value;
    if (value?.label?.toLowerCase().trim() == 'ethiopia') {
      _dropdownRegion = true;
      _selectedRegion = _regions
          .firstWhere((e) => e.label?.toLowerCase().trim() == 'addis ababa');
    } else {
      _dropdownRegion = false;
    }

    rebuildUi();
  }

  // Region
  List<FieldOption> get _regions => _onboardingService.regions;

  List<FieldOption> get regions => _regions;

  void setSelectedRegion(FieldOption? value) {
    _selectedRegion = value;
    rebuildUi();
  }

  bool checkRegion({required String region, required String country}) {
    if (country.toLowerCase().contains('ethiopia')) {
      return _regions.contains(region);
    }
    return false;
  }


  void setRegionFocus() {
    _focusRegion = true;
    rebuildUi();
  }

  void unsetRegionFocus() {
    _focusRegion = false;
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

  // Profile detail fields
  Future<void> getProfileDetailFields() async =>
      await runBusyFuture(_getProfileDetailFields(),busyObject: StateObjects.profileDetail);

  Future<void> _getProfileDetailFields() async {
    await _onboardingService.getProfileDetailFields();
  }
}

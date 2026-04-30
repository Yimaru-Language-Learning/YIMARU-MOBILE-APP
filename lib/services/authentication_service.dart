import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

class AuthenticationService with ListenableServiceMixin {
  // Dependency injection
  final _secureService = locator<SecureStorageService>();

  // User data
  User? _user;

  User? get user => _user;

  // Initialization
  AuthenticationService() {
    listenToReactiveValues([_user]);
  }

  // Check user logged in
  Future<bool> userLoggedIn() async {
    if (await _secureService.getString('userId') != null) {
      return true;
    }
    return false;
  }

  // Get access token
  Future<String?> getAccessToken() async =>
      await _secureService.getString('accessToken');

  // Get refresh token
  Future<String?> getRefreshToken() async =>
      await _secureService.getString('refreshToken');

  // Get user id
  Future<int?> getUserId() async => await _secureService.getInt('userId');

  // Save tokens
  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _secureService.setString('accessToken', access);
    await _secureService.setString('refreshToken', refresh);
  }

  // Save user credential
  Future<void> saveUserCredential(Map<String, dynamic> data) async {
    await _secureService.setInt('userId', data['userId']);
    await _secureService.setString('accessToken', data['accessToken']);
    await _secureService.setString('refreshToken', data['refreshToken']);

    _user = User(
      userId: await _secureService.getInt('userId'),
      accessToken: await _secureService.getString('accessToken'),
      refreshToken: await _secureService.getString('refreshToken'),
    );
  }

  // Save profile status
  Future<void> saveProfileStatus(bool value) async {
    await _secureService.setBool('profileCompleted', value);

    _user = _user?.copyWith(
      userInfoLoaded: _user?.userInfoLoaded ?? false,
      profileCompleted: await _secureService.getBool('profileCompleted'),
    );

    notifyListeners();
  }

  // Save profile picture
  Future<void> saveProfilePicture(String image) async {
    await _secureService.setString('profilePicture', image);
    _user = _user?.copyWith(
      userInfoLoaded: _user?.userInfoLoaded ?? false,
      profilePicture: await _secureService.getString('profilePicture'),
    );

    notifyListeners();
  }

  // Save user data
  Future<void> saveUserData(User data) async {
    await _secureService.setBool('userInfoLoaded', true);
    await _secureService.setBool(
        'profileCompleted', data.profileCompleted ?? false);
    await _secureService.setString('email', data.email ?? '');
    await _secureService.setString('region', data.region ?? '');
    await _secureService.setString('gender', data.gender ?? '');
    await _secureService.setString('country', data.country ?? '');
    await _secureService.setString('birthday', data.birthday ?? '');
    await _secureService.setString('lastName', data.lastName ?? '');
    await _secureService.setString('firstName', data.firstName ?? '');
    await _secureService.setString('occupation', data.occupation ?? '');

    _user = User(
      email: data.email,
      gender: data.gender,
      region: data.region,
      userInfoLoaded: true,
      userId: _user?.userId,
      country: data.country,
      lastName: data.lastName,
      birthday: data.birthday,
      firstName: data.firstName,
      occupation: data.occupation,
      accessToken: _user?.accessToken,
      refreshToken: _user?.refreshToken,
      profileCompleted: data.profileCompleted,
    );

    notifyListeners();
  }

  // Update user data
  Future<void> updateUserData(Map<String, dynamic> data) async {
    await _secureService.setString('region', data['region']);
    await _secureService.setString('gender', data['gender']);
    await _secureService.setString('country', data['country']);
    await _secureService.setString('lastName', data['last_name']);
    await _secureService.setString('birthday', data['birth_day']);
    await _secureService.setString('firstName', data['first_name']);
    await _secureService.setString('occupation', data['occupation']);

    _user = _user?.copyWith(
      region: await _secureService.getString('region'),
      gender: await _secureService.getString('gender'),
      country: await _secureService.getString('country'),
      lastName: await _secureService.getString('lastName'),
      birthday: await _secureService.getString('birthday'),
      firstName: await _secureService.getString('firstName'),
      occupation: await _secureService.getString('occupation'),
    );

    notifyListeners();
  }

  // Check first time install
  Future<bool> isFirstTimeInstall() async =>
      await _secureService.getBool('firstTimeInstall') ?? true;

  // Set first time install
  Future<void> setFirstTimeInstall(bool value) async {
    await _secureService.setBool('firstTimeInstall', value);
  }

  // Get user data
  Future<User?> getUser() async {
    _user = User(
      userId: await _secureService.getInt('userId'),
      email: await _secureService.getString('email'),
      region: await _secureService.getString('region'),
      gender: await _secureService.getString('gender'),
      country: await _secureService.getString('country'),
      lastName: await _secureService.getString('lastName'),
      birthday: await _secureService.getString('birthday'),
      firstName: await _secureService.getString('firstName'),
      occupation: await _secureService.getString('occupation'),
      accessToken: await _secureService.getString('accessToken'),
      refreshToken: await _secureService.getString('refreshToken'),
      userInfoLoaded: await _secureService.getBool('userInfoLoaded'),
      profilePicture: await _secureService.getString('profilePicture'),
      profileCompleted: await _secureService.getBool('profileCompleted'),
    );
    return _user;
  }

  // Logout
  Future<void> logout() async {
    bool firstTimeInstall = await isFirstTimeInstall();
    _user = null;
    await _secureService.clear();
    await setFirstTimeInstall(firstTimeInstall);
    notifyListeners();
  }
}

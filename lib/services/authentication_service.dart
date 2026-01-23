import 'package:stacked/stacked.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

class AuthenticationService with ListenableServiceMixin {
  final _secureService = locator<SecureStorageService>();

  AuthenticationService() {
    listenToReactiveValues([_user]);
  }

  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> userLoggedIn() async {
    if (await _secureService.getString('userId') != null) {
      return true;
    }
    return false;
  }

  Future<String?> getAccessToken() async =>
      await _secureService.getString('accessToken');

  Future<String?> getRefreshToken() async =>
      await _secureService.getString('refreshToken');

  Future<int?> getUserId() async => await _secureService.getInt('userId');

  Future<void> saveTokens({
    required String access,
    required String refresh,
  }) async {
    await _secureService.setString('accessToken', access);
    await _secureService.setString('refreshToken', refresh);
  }

  Future<void> saveUserName(Map<String, dynamic> data) async {
    await _secureService.setString('firstName', data['firstName']);
    _user = UserModel(
      userId: _user?.userId,
      accessToken: _user?.accessToken,
      refreshToken: _user?.refreshToken,
      profileCompleted: _user?.profileCompleted,
      firstName: await _secureService.getString('firstName'),
    );
  }

  Future<void> saveBasicUserData(Map<String, dynamic> data) async {
    await _secureService.setInt('userId', data['userId']);
    await _secureService.setString('accessToken', data['accessToken']);
    await _secureService.setString('refreshToken', data['refreshToken']);

    _user = UserModel(
      firstName: _user?.firstName,
      profileImage: _user?.profileImage,
      profileCompleted: _user?.profileCompleted,
      userId: await _secureService.getInt('userId'),
      accessToken: await _secureService.getString('accessToken'),
      refreshToken: await _secureService.getString('refreshToken'),
    );
  }

  Future<void> saveProfileStatus(bool value) async {
    await _secureService.setBool('profileCompleted', value);

    _user = UserModel(
        userId: _user?.userId,
        firstName: _user?.firstName,
        accessToken: _user?.accessToken,
        refreshToken: _user?.refreshToken,
        profileImage: _user?.profileImage,
        profileCompleted: await _secureService.getBool('profileCompleted'));
  }

  Future<void> saveProfileImage(String image) async {
    await _secureService.setString('profileImage', image);
    _user = UserModel(
      userId: _user?.userId,
      firstName: _user?.firstName,
      accessToken: _user?.accessToken,
      refreshToken: _user?.refreshToken,
      profileCompleted: _user?.profileCompleted,
      profileImage: await _secureService.getString('profileImage'),
    );

    notifyListeners();
  }

  Future<void> saveFullName(Map<String, dynamic> data) async {
    await _secureService.setBool('profileCompleted', true);
    await _secureService.setString('firstName', data['firstName']);
    _user = UserModel(
      userId: _user?.userId,
      accessToken: _user?.accessToken,
      refreshToken: _user?.refreshToken,
      profileImage: _user?.profileImage,
      firstName: await _secureService.getString('firstName'),
      profileCompleted: await _secureService.getBool('profileCompleted'),
    );
  }

  Future<bool> isFirstTimeInstall() async =>
      await _secureService.getBool('firstTimeInstall') ?? true;

  Future<void> setFirstTimeInstall(bool value) async {
    await _secureService.setBool('firstTimeInstall', value);
  }

  Future<UserModel?> getUser() async {
    _user = UserModel(
      userId: await _secureService.getInt('userId'),
      firstName: await _secureService.getString('firstName'),
      accessToken: await _secureService.getString('accessToken'),
      refreshToken: await _secureService.getString('refreshToken'),
      profileImage: await _secureService.getString('profileImage'),
      profileCompleted: await _secureService.getBool('profileCompleted'),
    );
    return _user;
  }

  Future<void> logOut() async {
    bool firstTimeInstall = await isFirstTimeInstall();
    await _secureService.clear();
    await setFirstTimeInstall(firstTimeInstall);
  }
}

import 'package:yimaru_app/app/app.locator.dart';
import 'package:yimaru_app/models/user_model.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';

class AuthenticationService {
  final _secureService = locator<SecureStorageService>();

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

  Future<void> saveUserData(Map<String, dynamic> data) async {
    await _secureService.setInt('userId', data['userId']);
    await _secureService.setString('accessToken', data['accessToken']);
    await _secureService.setString('refreshToken', data['refreshToken']);
  }

  Future<void> saveProfileCompleted(bool value) async {
    await _secureService.setBool('profileCompleted', value);
  }

  Future<bool> isFirstTimeInstall() async =>
      await _secureService.getBool('firstTimeInstall') ?? true;

  Future<void> setFirstTimeInstall(bool value) async {
    await _secureService.setBool('firstTimeInstall', value);
  }

  Future<UserModel> getUser() async {
    UserModel user = UserModel(
      userId: await _secureService.getInt('userId'),
      accessToken: await _secureService.getString('accessToken'),
      refreshToken: await _secureService.getString('refreshToken'),
      profileCompleted: await _secureService.getBool('profileCompleted'),
    );
    return user;
  }

  Future<void> logOut() async {
    bool firstTimeInstall = await isFirstTimeInstall();
    await _secureService.clear();
    await setFirstTimeInstall(firstTimeInstall);
  }
}

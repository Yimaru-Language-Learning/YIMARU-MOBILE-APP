import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

class GoogleAuthService with ListenableServiceMixin {
  // Initialization
  final GoogleSignIn _signIn = GoogleSignIn.instance;

  GoogleSignInAccount? _googleUser;

  GoogleSignInAccount? get googleUser => _googleUser;

  // Initialization
  GoogleAuthService() {
    listenToReactiveValues([_googleUser]);
  }

  // Google logout
  Future<void> logout() async {
    await _signIn.signOut();
    _googleUser = null;
    notifyListeners();
  }

  // Google authentication
  Future<void> googleAuth() async {
    try {
      await _signIn.initialize(serverClientId: kServerClientId).then((_) async {
        _googleUser = await _signIn.attemptLightweightAuthentication();

        _googleUser ??=
            await _signIn.authenticate(scopeHint: ['email', 'profile']);
        print('GOOGLE AUTH');
        print(_googleUser?.email);
        print(_googleUser?.displayName);
        print(_googleUser?.authentication.idToken);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

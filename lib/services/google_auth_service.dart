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
  }

  // Google authentication
  Future<void> googleAuth() async {
    try {
      await _signIn.initialize(serverClientId: kServerClientId).then((_) async {
        _googleUser = await _signIn.attemptLightweightAuthentication();

        _googleUser ??=
            await _signIn.authenticate(scopeHint: ['email', 'profile']);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

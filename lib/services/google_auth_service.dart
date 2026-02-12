import 'package:google_sign_in/google_sign_in.dart';
import 'package:yimaru_app/ui/common/app_constants.dart';

class GoogleAuthService {
  final GoogleSignIn signIn = GoogleSignIn.instance;

  Future<GoogleSignInAccount?> googleAuth() async {
    try {
      GoogleSignInAccount? googleUser;
      await signIn.initialize(serverClientId: kServerClientId).then((_) async {
        googleUser = await signIn.attemptLightweightAuthentication();

        googleUser ??=
            await signIn.authenticate(scopeHint: ['email', 'profile']);
      });
      return googleUser;
    } catch (e) {
      return null;
    }
  }
}

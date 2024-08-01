import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static var googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  init() {
    if (Platform.isIOS) {
      googleSignIn = GoogleSignIn(
        clientId:
            '1096694114056-2ekun04p12vv3ivnn7r2sm7cmp5fsu5s.apps.googleusercontent.com',
        scopes: ['email'],
      );
    }
  }

  Future<String?> loginWithGoogle() async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.signOut();
      return null;
    }
    final account = await googleSignIn.signIn();
    return account?.email;
  }
}

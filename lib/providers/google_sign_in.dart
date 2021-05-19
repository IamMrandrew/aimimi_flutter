import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:aimimi/models/user.dart";

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  OurUser _createUser(User user) {
    return user != null ? OurUser(uid: user.uid) : null;
  }

  Stream<OurUser> get user {
    return FirebaseAuth.instance.authStateChanges().map(_createUser);
  }

  Future login() async {
    isSigningIn = true;

    final user = await googleSignIn.signIn();

    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      isSigningIn = false;

      return _createUser(result.user);
    }
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

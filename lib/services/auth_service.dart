import 'package:aimimi/services/user_document.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:aimimi/models/user.dart";

class AuthService extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _isSigningIn;

  AuthService() {
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

  Future signUp(
      String email, String password, String name, BuildContext context) async {
    isSigningIn = true;

    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser.updateProfile(displayName: name);
      await UserDocument(uid: auth.currentUser.uid)
          .createUserDocuments(FieldValue.serverTimestamp(), name);
      isSigningIn = false;
      return _createUser(result.user);
    } catch (e) {
      showError(e.message, context);
      print(e);
      isSigningIn = false;
    }
  }

  Future emailLogin(String email, String password, BuildContext context) async {
    isSigningIn = true;

    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      isSigningIn = false;
      return _createUser(result.user);
    } catch (e) {
      showError(e.message, context);
      print(e);
      isSigningIn = false;
    }
  }

  showError(String errormessage, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  Future googleLogin() async {
    isSigningIn = true;

    await googleSignIn.disconnect();
    final user = await googleSignIn.signIn();

    if (user == null) {
      isSigningIn = false;
      return;
    } else {
      print("here" + user.toString());
      final googleAuth = await user.authentication;
      print("there");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      await UserDocument(uid: auth.currentUser.uid).createUserDocuments(
          FieldValue.serverTimestamp(), result.user.displayName);
      isSigningIn = false;

      return _createUser(result.user);
    }
  }

  Future logout() async {
    // print(auth.currentUser.providerData[0]);
    if (auth.currentUser.providerData[0].providerId == 'google.com') {
      return await Future.wait([
        FirebaseAuth.instance.signOut(),
        googleSignIn.disconnect(),
      ]);
    }
    return FirebaseAuth.instance.signOut();
  }
}

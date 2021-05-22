import 'package:cloud_firestore/cloud_firestore.dart';

class UserDocument {
  final String uid;
  bool newUser = false;

  UserDocument({this.uid});

  final CollectionReference userDocument =
      FirebaseFirestore.instance.collection('users');

  Future createUserDocuments(createdAt, String username) async {
    userDocument.doc(uid).get().then((value) {
      if (value == null) {
        newUser = true;
      }
    });
    if (newUser) {
      return await userDocument.doc(uid).set({
        'createdAt': createdAt,
        'username': username,
      });
    } else {
      return;
    }
  }
}

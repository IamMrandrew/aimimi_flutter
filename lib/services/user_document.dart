import 'package:cloud_firestore/cloud_firestore.dart';

class UserDocument {
  final String uid;
  bool isNewUser = false;
  UserDocument({this.uid});

  final CollectionReference userDocument =
      FirebaseFirestore.instance.collection('users');

  Future createUserDocuments(createdAt, String username, photoURL) async {
    var a = await userDocument.doc(uid).get();
    if (!a.exists) {
      return await userDocument.doc(uid).set({
        'createdAt': createdAt,
        'username': username,
        'photoURL': photoURL,
      });
    } else {
      return;
    }
  }
}

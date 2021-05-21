import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aimimi/models/feed.dart';

class FeedService {
  final CollectionReference<Map<String, dynamic>> feedCollection =
      FirebaseFirestore.instance.collection("feeds");

  Stream<List<Feed>> get feeds {
    return feedCollection.snapshots().map(
        (QuerySnapshot<Map<String, dynamic>> querySnapshot) =>
            querySnapshot.docs
                .map((DocumentSnapshot<Map<String, dynamic>> feed) => (Goal(
                      content: feed.data()["content"],
                      createdAt: feed.data()["createdAt"],
                      uid: feed.data()["uid"],
                      username: feed.data()["username"],
                      goalID: feed.data()["goalID"],
                    )))
                .toList());
  }
}

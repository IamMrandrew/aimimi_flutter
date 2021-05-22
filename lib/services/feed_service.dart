import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aimimi/models/feed.dart';
import 'package:aimimi/models/user.dart';

class FeedService {
  final List<UserGoal> userGoals;
  final String feedID;
  final String uid;

  FeedService({this.uid, this.feedID, this.userGoals});

  final CollectionReference<Map<String, dynamic>> feedCollection =
      FirebaseFirestore.instance.collection("feeds");

  Future<List<Feed>> _createFeeds(
          QuerySnapshot<Map<String, dynamic>> querySnapshot) =>
      Future.wait(querySnapshot.docs.map<Future<Feed>>(
          (DocumentSnapshot<Map<String, dynamic>> feed) async {
        return Feed(
            content: feed.data()["content"],
            createdAt: feed.data()["createdAt"].toDate(),
            createdBy: CreatedBy(
              uid: feed.data()["createdBy"]["uid"],
              username: feed.data()["createdBy"]["username"],
            ),
            goalID: feed.data()["goalID"],
            likes: feed.data()["likes"],
            feedID: feed.reference.id);
      }).toList());

  Stream<List<Feed>> get feeds {
    return feedCollection
        .where("goalID", whereIn: userGoals.map((goal) => goal.goalID).toList())
        .snapshots()
        .asyncMap(_createFeeds);
  }

  List<LikedUser> _createLikedUsers(
          DocumentSnapshot<Map<String, dynamic>> feed) =>
      feed
          .data()["likes"]
          .map<LikedUser>((user) => LikedUser(uid: user))
          .toList();

  Stream<List<LikedUser>> get likedUsers {
    return feedCollection.doc(feedID).snapshots().map(_createLikedUsers);
  }

  Future like(feed) async {
    return feedCollection.doc(feedID).update({
      "likes": FieldValue.arrayUnion([FirebaseAuth.instance.currentUser.uid])
    });
  }

  Future dislike(feed) async {
    return feedCollection.doc(feedID).update({
      "likes": FieldValue.arrayRemove([FirebaseAuth.instance.currentUser.uid])
    });
  }
}

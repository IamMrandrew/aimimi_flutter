import 'package:aimimi/models/ad.dart';
import 'package:aimimi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdService {
  AdService();
  final adCollection = FirebaseFirestore.instance.collection("ads");

  List<Ad> _createAds(QuerySnapshot<Map<String, dynamic>> querySnapshot) =>
      querySnapshot.docs
          .map<Ad>(
            (DocumentSnapshot<Map<String, dynamic>> ad) => Ad(
                content: ad.data()["content"],
                category: ad.data()["category"],
                createdAt: ad.data()["createdAt"].toDate(),
                createdBy: CreatedBy(
                  uid: ad.data()["createdBy"]["uid"],
                  username: ad.data()["createdBy"]["username"],
                ),
                goalID: ad.data()["goalID"],
                title: ad.data()["title"]),
          )
          .toList();

  Stream<List<Ad>> get ads {
    return adCollection.snapshots().map(_createAds);
  }
}

// AdItem(
//   title: "Tips from MYPROTON",
//   category: "Fitness",
//   content:
//       "Buy high quality supplements from Europe's top sports nutrition brand. An incredible range, with the best prices on the market plus free delivery.",
//   createdBy: "MYPROTON",
// ),

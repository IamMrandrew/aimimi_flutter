import 'package:aimimi/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GoalService {
  final CollectionReference<Map<String, dynamic>> goalCollection =
      FirebaseFirestore.instance.collection("goals");

  Stream<List<Goal>> get goals {
    return goalCollection.snapshots().map(
        (QuerySnapshot<Map<String, dynamic>> querySnapshot) =>
            querySnapshot.docs
                .map((DocumentSnapshot<Map<String, dynamic>> goal) => (Goal(
                      title: goal.data()["title"],
                      category: goal.data()["category"],
                      period: goal.data()["period"],
                      frequency: goal.data()["frequency"],
                      timespan: goal.data()["timespan"],
                      publicity: goal.data()["publicity"],
                      description: goal.data()["description"],
                    )))
                .toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  // Collection reference
  final CollectionReference goalCollection =
      FirebaseFirestore.instance.collection('goals');
}

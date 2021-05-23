import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoalService {
  final String uid;
  final String username;
  final String goalID;

  GoalService({this.uid, this.goalID, this.username});

  final CollectionReference<Map<String, dynamic>> goalCollection =
      FirebaseFirestore.instance.collection("goals");

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference<Map<String, dynamic>> feedCollection =
      FirebaseFirestore.instance.collection("feeds");

  // Get all shared goals for SharesView
  Future<List<SharedGoal>> _createSharedGoals(
          QuerySnapshot<Map<String, dynamic>> querySnapshot) =>
      Future.wait(querySnapshot.docs.map<Future<SharedGoal>>(
          (DocumentSnapshot<Map<String, dynamic>> sharedGoal) async {
        return SharedGoal(
          goalID: sharedGoal.id,
          title: sharedGoal.data()["title"],
          category: sharedGoal.data()["category"],
          period: sharedGoal.data()["period"],
          frequency: sharedGoal.data()["frequency"],
          timespan: sharedGoal.data()["timespan"],
          publicity: sharedGoal.data()["publicity"],
          description: sharedGoal.data()["description"],
          createdBy: CreatedBy(
            uid: sharedGoal.data()["createdBy"]["uid"],
            username: sharedGoal.data()["createdBy"]["username"],
          ),
          createAt: sharedGoal.data()["createdAt"].toDate(),
          users: await goalCollection
              .doc(sharedGoal.id)
              .collection("users")
              .get()
              .then((QuerySnapshot querySnapshot) => querySnapshot.docs
                  .map((DocumentSnapshot user) => user)
                  .toList()),
        );
      }).toList());

  Stream<List<SharedGoal>> get sharedGoals {
    return goalCollection
        .where("publicity", isEqualTo: true)
        .snapshots()
        .asyncMap(_createSharedGoals);
  }

  // Get a shared goal for SharedGoalView
  Future<SharedGoal> _createSharedGoal(
          DocumentSnapshot<Map<String, dynamic>> sharedGoal) async =>
      SharedGoal(
        title: sharedGoal.data()["title"],
        category: sharedGoal.data()["category"],
        period: sharedGoal.data()["period"],
        frequency: sharedGoal.data()["frequency"],
        timespan: sharedGoal.data()["timespan"],
        publicity: sharedGoal.data()["publicity"],
        description: sharedGoal.data()["description"],
        createdBy: CreatedBy(
          uid: sharedGoal.data()["createdBy"]["uid"],
          username: sharedGoal.data()["createdBy"]["username"],
        ),
        createAt: sharedGoal.data()["createdAt"].toDate(),
        // Dont use this users. Not real time is rubbish
        users: await goalCollection
            .doc(sharedGoal.id)
            .collection("users")
            .get()
            .then((QuerySnapshot querySnapshot) => querySnapshot.docs
                .map((DocumentSnapshot user) => user)
                .toList()),
      );

  Stream<SharedGoal> get sharedGoal {
    return goalCollection.doc(goalID).snapshots().asyncMap(_createSharedGoal);
  }

  // Get users of particular goal
  List<JoinedUser> _createJoinedUsers(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map<JoinedUser>(
            (DocumentSnapshot<Map<String, dynamic>> user) => JoinedUser(
                  uid: user.id,
                  username: user.data()["username"],
                  accuracy: user.data()["accuracy"].toDouble(),
                ))
        .toList();
  }

  Stream<List<JoinedUser>> get joinedUsers {
    return goalCollection
        .doc(goalID)
        .collection("users")
        .snapshots()
        .map(_createJoinedUsers);
  }

  // Get all goals for that user
  List<UserGoal> _createUserGoals(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map<UserGoal>(
            (DocumentSnapshot<Map<String, dynamic>> userGoal) => (UserGoal(
                  accuracy: userGoal.data()["accuracy"].toDouble(),
                  checkIn: userGoal.data()["checkIn"],
                  checkInSuccess: userGoal.data()["checkInSuccess"],
                  checkedIn: userGoal.data()["checkedIn"],
                  dayPassed: userGoal.data()["dayPassed"],
                  goalID: userGoal.id,
                  goal: Goal(
                    title: userGoal.data()["goal"]["title"],
                    category: userGoal.data()["goal"]["category"],
                    period: userGoal.data()["goal"]["period"],
                    frequency: userGoal.data()["goal"]["frequency"],
                    timespan: userGoal.data()["goal"]["timespan"],
                    publicity: userGoal.data()["goal"]["publicity"],
                    description: userGoal.data()["goal"]["description"],
                  ),
                )))
        .toList();
  }

  Stream<List<UserGoal>> get userGoals {
    return userCollection
        .doc(uid)
        .collection("goals")
        .snapshots()
        .map(_createUserGoals);
  }

  UserGoal _createUserGoal(DocumentSnapshot<Map<String, dynamic>> userGoal) =>
      UserGoal(
        accuracy: userGoal.data()["accuracy"].toDouble(),
        checkIn: userGoal.data()["checkIn"],
        checkInSuccess: userGoal.data()["checkInSuccess"],
        checkedIn: userGoal.data()["checkedIn"],
        dayPassed: userGoal.data()["dayPassed"],
        goalID: userGoal.id,
        goal: Goal(
          title: userGoal.data()["goal"]["title"],
          category: userGoal.data()["goal"]["category"],
          period: userGoal.data()["goal"]["period"],
          frequency: userGoal.data()["goal"]["frequency"],
          timespan: userGoal.data()["goal"]["timespan"],
          publicity: userGoal.data()["goal"]["publicity"],
          description: userGoal.data()["goal"]["description"],
        ),
      );
  // Get a UserGoal
  Stream<UserGoal> get userGoal {
    return userCollection
        .doc(uid)
        .collection("goals")
        .doc(goalID)
        .snapshots()
        .map(_createUserGoal);
  }

  // Get the length of completed goal
  List<String> _completed(QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map<String>((DocumentSnapshot<Map<String, dynamic>> userGoal) => ('A'))
        .toList();
  }

  Stream<List<String>> get completedGoals {
    return userCollection
        .doc(uid)
        .collection("completed")
        .snapshots()
        .map(_completed);
  }

  Future addGoal(title, category, description, publicity, period, frequency,
      timespan) async {
    Future addGoalToGoals() {
      return goalCollection.add({
        'title': title,
        'category': category,
        'description': description,
        'publicity': publicity,
        'period': period,
        'frequency': frequency,
        'timespan': timespan,
        'createdBy': {
          'uid': FirebaseAuth.instance.currentUser.uid,
          'username': FirebaseAuth.instance.currentUser.displayName,
        },
        "createdAt": Timestamp.now(),
      });
    }

    DocumentReference doc = await addGoalToGoals();

    Future addUserGoalToUser() {
      return userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection("goals")
          .doc(doc.id.toString())
          .set({
        "accuracy": 0,
        "checkIn": 0,
        "checkInSuccess": 0,
        "checkedIn": false,
        "dayPassed": 0,
        "goal": {
          'description': description,
          'frequency': frequency,
          'period': period,
          'publicity': publicity,
          'timespan': timespan,
          'title': title,
        },
      });
    }

    Future addUserToGoalUsers() {
      return goalCollection.doc(doc.id).collection("users").doc(uid).set({
        "accuracy": 0,
        "username": username,
      });
    }

    return Future.wait([
      addUserGoalToUser(),
      addUserToGoalUsers(),
    ]);
  }

  // Check in action
  Future checkInGoal(int checkIn, UserGoal selectedGoal) {
    final bool doEnoughTimes = checkIn >= selectedGoal.goal.frequency;

    print(selectedGoal.goalID);
    print(uid);
    if (doEnoughTimes) {
      double newAccuracy =
          ((selectedGoal.checkInSuccess + 1) / (selectedGoal.dayPassed + 1)) *
              100;

      Future updateCheckInToUser() {
        return userCollection
            .doc(uid)
            .collection("goals")
            .doc(selectedGoal.goalID)
            .update({
          "checkIn": checkIn,
          "checkInSuccess": FieldValue.increment(1),
          "checkedIn": true,
          "dayPassed": FieldValue.increment(1),
          "accuracy": newAccuracy,
        });
      }

      Future updateAccuracyToGoal() {
        return goalCollection
            .doc(selectedGoal.goalID)
            .collection("users")
            .doc(uid)
            .update({"accuracy": newAccuracy});
      }

      return Future.wait([
        updateCheckInToUser(),
        updateAccuracyToGoal(),
        _createFeed(
            content: "$username  check-in for ${selectedGoal.goal.title}!!")
      ]);
    }

    return userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("goals")
        .doc(selectedGoal.goalID)
        .update({"checkIn": checkIn});
  }

  // Join goal action
  Future joinGoal(SharedGoal goal) {
    Future addJoinedUserToGoalUsers() {
      return goalCollection.doc(goalID).collection("users").doc(uid).set({
        "accuracy": 0,
        "username": FirebaseAuth.instance.currentUser.displayName,
      });
    }

    Future addUserGoalToUserGoals(SharedGoal goal) {
      return userCollection.doc(uid).collection("goals").doc(goalID).set({
        "accuracy": 0,
        "checkIn": 0,
        "checkInSuccess": 0,
        "checkedIn": false,
        "dayPassed": 0,
        "goal": {
          'description': goal.description,
          'frequency': goal.frequency,
          'period': goal.period,
          'publicity': goal.publicity,
          'timespan': goal.timespan,
          'title': goal.title,
        },
      });
    }

    return Future.wait([
      addJoinedUserToGoalUsers(),
      addUserGoalToUserGoals(goal),
      _createFeed(
        content: "$username joined ${goal.title}.",
      ),
    ]);
  }

  // Publish a goal (Change to public)
  Future publishGoal() {
    Future updateGoalInGoals() {
      return goalCollection.doc(goalID).update({"publicity": true});
    }

    Future updateGoalInUserGoals() {
      return userCollection.doc(uid).collection("goals").doc(goalID).update(
        {"goal.publicity": true},
      );
    }

    return Future.wait([
      updateGoalInGoals(),
      updateGoalInUserGoals(),
    ]);
  }

  // Quit a goal (Goal remain there, but user quit)
  Future quitGoal(UserGoal userGoal) {
    Future deleteUserInGoalUsers() {
      return goalCollection.doc(goalID).collection("users").doc(uid).delete();
    }

    Future deleteGoalInUserGoals() {
      return userCollection.doc(uid).collection("goals").doc(goalID).delete();
    }

    return Future.wait([
      _createFeed(content: "$username quit ${userGoal.goal.title}"),
      deleteUserInGoalUsers(),
      deleteGoalInUserGoals(),
    ]);
  }

  // Create a feed
  Future _createFeed({String content}) {
    return feedCollection.add({
      "content": content,
      "createdAt": Timestamp.now(),
      "createdBy": {
        "uid": uid,
        "username": username,
      },
      "goalID": goalID,
      "likes": [],
    });
  }
}

import 'package:aimimi/models/goal.dart';

class OurUser {
  String uid;
  String username;
  DateTime createdAt;
  List<UserGoal> goals;

  OurUser({this.uid, this.username});
}

class UserGoal {
  double accuracy;
  int checkIn;
  int checkInSuccess;
  bool checkedIn;
  int dayPassed;
  String goalID;
  Goal goal;

  UserGoal({
    this.accuracy,
    this.checkIn,
    this.checkInSuccess,
    this.checkedIn,
    this.dayPassed,
    this.goal,
    this.goalID,
  });
}

class JoinedUser {
  String uid;
  String username;
  double accuracy;

  JoinedUser({this.uid, this.username, this.accuracy});
}

class CreatedBy {
  String uid;
  String username;

  CreatedBy({this.uid, this.username});
}

import 'package:aimimi/models/user.dart';

class Goal {
  String category;
  String description;
  int frequency;
  String period;
  bool publicity;
  int timespan;
  String title;

  Goal({
    this.category,
    this.description,
    this.frequency,
    this.period,
    this.publicity,
    this.timespan,
    this.title,
  });
}

class SharedGoal {
  String title;
  String category;
  String period;
  int frequency;
  int timespan;
  String description;
  bool publicity;
  CreatedBy createdBy;
  DateTime createAt;
  List users;

  SharedGoal({
    this.title,
    this.category,
    this.period,
    this.frequency,
    this.timespan,
    this.description,
    this.publicity,
    this.createdBy,
    this.createAt,
    this.users,
  });
}

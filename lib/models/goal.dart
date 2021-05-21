import 'package:aimimi/models/user.dart';
import 'package:provider/provider.dart';

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
  List<OurUser> users;

  SharedGoal({
    this.title,
    this.category,
    this.period,
    this.frequency,
    this.timespan,
    this.description,
    this.publicity,
    this.createdBy,
    this.users,
  });
}

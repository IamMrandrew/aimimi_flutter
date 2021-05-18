import 'package:flutter/material.dart';
import 'package:aimimi/models/goal.dart';

class GoalsProvider extends ChangeNotifier {
  List<Goal> goalList = [
    Goal("Lifestyle", "This is the first goal", 3, "Daily", false, 30,
        "AAA goal")
  ];

  addGoalInList(
      category, title, period, frequency, publicity, description, timespan) {
    Goal goalModel = Goal(
        category, description, frequency, period, publicity, timespan, title);
    goalList.add(goalModel);

    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:aimimi/models/goals_model.dart';

class TodayGoalsModel extends ChangeNotifier {
  List<GoalModel> goalList = [
    GoalModel("Lifestyle", "This is the first goal", 3, "Daily", false, 30,
        "AAA goal")
  ];

  addGoalInList(
      category, title, period, frequency, publicity, description, timespan) {
    GoalModel goalModel = GoalModel(
        category, description, frequency, period, publicity, timespan, title);
    goalList.add(goalModel);

    notifyListeners();
  }
}

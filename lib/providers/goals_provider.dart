import 'package:flutter/material.dart';
import 'package:aimimi/models/goal.dart';

class GoalsProvider extends ChangeNotifier {
  List<Goal> goalList = [
    Goal(
        category: "Lifestyle",
        description: "This is the first goal",
        frequency: 3,
        period: "Daily",
        publicity: false,
        timespan: 30,
        title: "AAA goal")
  ];

  addGoalInList(
      category, title, period, frequency, publicity, description, timespan) {
    Goal goalModel = Goal(
      category: category,
      description: description,
      frequency: frequency,
      period: period,
      publicity: publicity,
      timespan: timespan,
      title: title,
    );
    goalList.add(goalModel);

    notifyListeners();
  }
}

import 'package:aimimi/models/todayGoals_model.dart';
import 'package:aimimi/widgets/goal/goal_today.dart';
import 'package:aimimi/widgets/modal/modal_add_goal.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/models/goals_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TodayView extends StatefulWidget {
  TodayView({
    Key key,
  }) : super(key: key);
  @override
  _TodayViewState createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  // final goals = [
  //   GoalModel(
  //       category: "Lifestyle",
  //       description: "This is the first goal",
  //       frequency: 3,
  //       period: "Daily",
  //       publicity: false,
  //       timespan: 30,
  //       title: "AAA goal")
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 28, left: 25, right: 25),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Two task left for today",
              style: TextStyle(
                  fontSize: 16,
                  color: themeShadedColor.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Consumer<TodayGoalsModel>(builder: (context, goal, child) {
              return ListView.builder(
                  itemCount: goal.goalList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TodayGoal(
                        title: goal.goalList[index].title,
                        category: goal.goalList[index].category,
                        description: goal.goalList[index].description,
                        publicity: goal.goalList[index].publicity,
                        period: goal.goalList[index].period,
                        frequency: goal.goalList[index].frequency,
                        timespan: goal.goalList[index].timespan);
                  });
            }),
          ]),
    );
  }
}

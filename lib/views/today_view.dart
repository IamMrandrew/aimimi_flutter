import 'package:aimimi/providers/goals_provider.dart';
import 'package:aimimi/widgets/goal/goal_today.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:provider/provider.dart';

class TodayView extends StatefulWidget {
  TodayView({
    Key key,
  }) : super(key: key);
  @override
  _TodayViewState createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
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
            Consumer<GoalsProvider>(builder: (context, goal, child) {
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

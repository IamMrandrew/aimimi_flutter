import 'package:aimimi/widgets/goal/goal_today.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/styles/colors.dart';

class TodayView extends StatefulWidget {
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
              TodayGoal(),
              SizedBox(height: 8),
              TodayGoal(),
              SizedBox(height: 8),
              TodayGoal()
            ]));
  }
}

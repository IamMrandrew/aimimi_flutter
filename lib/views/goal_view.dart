import 'package:flutter/material.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/widgets/goal/goal.dart';

class GoalView extends StatefulWidget {
  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 28, left: 25, right: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              Goal(),
              SizedBox(height: 8),
              Goal(),
              SizedBox(height: 8),
              Goal()
            ]));
  }
}

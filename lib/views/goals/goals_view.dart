import 'package:aimimi/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/widgets/goal/goal.dart';
import 'package:aimimi/models/goal.dart';
import 'package:provider/provider.dart';
import 'package:aimimi/services/goal_service.dart';

class GoalView extends StatefulWidget {
  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  Widget build(BuildContext context) {
    List<UserGoal> goals = Provider.of<List<UserGoal>>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 28, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16),
            ListView.builder(
                itemCount: goals.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  UserGoal goal = Provider.of<List<UserGoal>>(context)[index];
                  return GoalItem(
                    title: goal.goal.title,
                    category: goal.goal.category,
                    description: goal.goal.description,
                    publicity: goal.goal.publicity,
                    period: goal.goal.period,
                    frequency: goal.goal.frequency,
                    timespan: goal.goal.timespan,
                  );
                }),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

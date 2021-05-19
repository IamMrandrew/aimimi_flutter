import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/providers/goals_provider.dart';
import 'package:aimimi/widgets/goal/goal_today.dart';
import 'package:aimimi/widgets/modal/modal_check_in.dart';
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
  void _modalCheckInHandler() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalCheckIn();
      },
    );
  }

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
              List<UserGoal> goals = Provider.of<List<UserGoal>>(context);
              return ListView.builder(
                  itemCount: goals.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    UserGoal goal = Provider.of<List<UserGoal>>(context)[index];
                    return TodayGoal(
                        title: goal.goal.title,
                        category: goal.goal.category,
                        description: goal.goal.description,
                        publicity: goal.goal.publicity,
                        period: goal.goal.period,
                        frequency: goal.goal.frequency,
                        timespan: goal.goal.timespan,
                        modalCheckInHandler: _modalCheckInHandler);
                  });
            }),
          ]),
    );
  }
}

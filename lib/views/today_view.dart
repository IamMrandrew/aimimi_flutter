import 'package:aimimi/models/goal.dart';
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
              List<Goal> goals = Provider.of<List<Goal>>(context);
              return ListView.builder(
                  itemCount: goals.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Goal goal = Provider.of<List<Goal>>(context)[index];
                    return TodayGoal(
                        title: goal.title,
                        category: goal.category,
                        description: goal.description,
                        publicity: goal.publicity,
                        period: goal.period,
                        frequency: goal.frequency,
                        timespan: goal.timespan,
                        modalCheckInHandler: _modalCheckInHandler);
                  });
            }),
          ]),
    );
  }
}

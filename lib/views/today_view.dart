import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/widgets/goal/goal_today.dart';
import 'package:aimimi/widgets/modal/modal_check_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodayView extends StatefulWidget {
  TodayView({Key key}) : super(key: key);

  @override
  _TodayViewState createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  void _modalCheckInHandler(UserGoal selectedGoal) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return ModalCheckIn(
          selectedGoal: selectedGoal,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<UserGoal> goals = Provider.of<List<UserGoal>>(context);
    return Container(
      padding: EdgeInsets.only(top: 28, left: 25, right: 25),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${_buildTaskLeft(goals)} task left for today",
              style: TextStyle(
                  fontSize: 16,
                  color: themeShadedColor.withOpacity(0.6),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ListView.builder(
                itemCount: goals.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  UserGoal goal = Provider.of<List<UserGoal>>(context)[index];
                  return TodayGoal(
                    goal: goal.goal,
                    accuracy: goal.accuracy,
                    checkIn: goal.checkIn,
                    checkInSuccess: goal.checkInSuccess,
                    checkedIn: goal.checkedIn,
                    dayPassed: goal.dayPassed,
                    goalID: goal.goalID,
                    modalCheckInHandler: _modalCheckInHandler,
                  );
                })
          ]),
    );
  }

  int _buildTaskLeft(List<UserGoal> goals) => goals
      .where((goal) => goal.checkIn != goal.goal.frequency)
      .toList()
      .length;
}

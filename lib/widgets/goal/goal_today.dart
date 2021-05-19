import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:flutter/material.dart';

class TodayGoal extends StatefulWidget {
  final double accuracy;
  final int checkIn;
  final int checkInSuccess;
  final bool checkedIn;
  final int dayPassed;
  final String goalID;
  final Goal goal;
  final modalCheckInHandler;

  TodayGoal({
    Key key,
    this.accuracy,
    this.checkIn,
    this.checkInSuccess,
    this.checkedIn,
    this.dayPassed,
    this.goal,
    this.goalID,
    this.modalCheckInHandler,
  }) : super(key: key);

  @override
  State<TodayGoal> createState() => _TodayGoalState();
}

class _TodayGoalState extends State<TodayGoal> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UserGoal selectedGoal = UserGoal(
          accuracy: widget.accuracy,
          checkIn: widget.checkIn,
          checkInSuccess: widget.checkInSuccess,
          checkedIn: widget.checkedIn,
          dayPassed: widget.dayPassed,
          goalID: widget.goalID,
          goal: widget.goal,
        );
        widget.modalCheckInHandler(selectedGoal);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: 76,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.goal.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeShadedColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.goal.period,
                      style: TextStyle(
                        fontSize: 14,
                        color: themeShadedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${widget.goal.timespan} days left",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: themeShadedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "0/${widget.goal.frequency}",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeShadedColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

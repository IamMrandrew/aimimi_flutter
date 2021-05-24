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
        final bool notCheckedIn = !widget.checkedIn;

        if (notCheckedIn) {
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
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              height: 76,
              child: Stack(
                children: [
                  Positioned(
                    child: OverflowBox(
                      maxHeight: 200,
                      maxWidth: (MediaQuery.of(context).size.width - 40) + 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Cubic(0.67, 0, 0.11, 1.2),
                          width: _buildProgressWidth(context),
                          height: 200,
                          decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
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
                                  "${widget.goal.timespan - widget.dayPassed} days left",
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
                              "${widget.checkIn}/${widget.goal.frequency}",
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
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          )
        ],
      ),
    );
  }

  double _buildProgressWidth(BuildContext context) {
    int offset = 10;
    double percentage = widget.checkIn / widget.goal.frequency;
    return (MediaQuery.of(context).size.width - 40) * percentage + offset;
  }
}

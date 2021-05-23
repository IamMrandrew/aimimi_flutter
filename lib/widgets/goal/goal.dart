import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/views/goals/goal_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoalItem extends StatelessWidget {
  final String goalID;
  final String category;
  final String description;
  final int frequency;
  final String period;
  final bool publicity;
  final int timespan;
  final String title;

  const GoalItem({
    Key key,
    this.goalID,
    this.category,
    this.description,
    this.frequency,
    this.period,
    this.publicity,
    this.timespan,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GoalView(
                  goalID: goalID,
                ),
              ));
        },
        child: new Container(
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
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeShadedColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    new Row(
                      children: [
                        Text(
                          period,
                          style: TextStyle(
                            fontSize: 14,
                            color: themeShadedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${timespan} days left",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: themeShadedColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.chevronRight,
                      color: themeShadedColor,
                      size: 18,
                    )
                  ],
                )
              ],
            )));
  }
}

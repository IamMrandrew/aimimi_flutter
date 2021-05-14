import 'package:aimimi/styles/colors.dart';
import 'package:flutter/material.dart';

class TodayGoal extends StatelessWidget {
  const TodayGoal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: 76,
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Drink Water",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeShadedColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                new Row(
                  children: [
                    Text(
                      "Everyday",
                      style: TextStyle(
                        fontSize: 14,
                        color: themeShadedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "30 days left",
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
            SizedBox(width: 145),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "0/8",
                  style: TextStyle(
                    fontSize: 16,
                    color: themeShadedColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

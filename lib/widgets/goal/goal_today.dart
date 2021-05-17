import 'package:aimimi/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/models/goals_model.dart';

class TodayGoal extends StatefulWidget {
  final goals;
  final String category;
  final String description;
  final int frequency;
  final String period;
  final bool publicity;
  final int timespan;
  final String title;

  TodayGoal(
      {Key key,
      this.goals,
      this.category,
      this.description,
      this.frequency,
      this.period,
      this.publicity,
      this.timespan,
      this.title})
      : super(key: key);

  @override
  State<TodayGoal> createState() => _TodayGoalState();
}

// class _TodayGoalState extends State<TodayGoal> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: goals.length,
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 color: Colors.white,
//               ),
//               width: MediaQuery.of(context).size.width,
//               height: 76,
//               padding: const EdgeInsets.only(left: 15),
//               child: Row(
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         widget.title,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: themeShadedColor,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       new Row(
//                         children: [
//                           Text(
//                             widget.period,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: themeShadedColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 8),
//                           Text(
//                             "${widget.timespan} days left",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: themeShadedColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   SizedBox(width: 145),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "0/${widget.frequency}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: themeShadedColor,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ));
//         });
//   }
// }

class _TodayGoalState extends State<TodayGoal> {
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
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: themeShadedColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                new Row(
                  children: [
                    Text(
                      widget.period,
                      style: TextStyle(
                        fontSize: 14,
                        color: themeShadedColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${widget.timespan} days left",
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
                  "0/${widget.frequency}",
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

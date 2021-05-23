import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class GoalView extends StatefulWidget {
  final String goalID;

  GoalView({this.goalID});
  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  bool _shared;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserGoal>(
        stream: GoalService(
          uid: Provider.of<OurUser>(context).uid,
          goalID: widget.goalID,
        ).userGoal,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: themeShadedColor),
              elevation: 0,
            ),
            body: _buildBody(snapshot),
          );
        });
  }

  _buildBody(snapshot) {
    if (snapshot.hasData) {
      final UserGoal userGoal = snapshot.data;

      _shared = userGoal.goal.publicity;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSharedGoalHeader(userGoal),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: 100),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                          color: themeShadedColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Grow bigger.Pull up is really great. 3 sets a day is enough for beginners",
                        style: TextStyle(
                          color: Color(0xff4B4B4B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(minHeight: 100),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _shared ? "Your goal is public" : "Not shared yet",
                        style: TextStyle(
                          color: themeShadedColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _shared
                            ? "Your goal is public"
                            : "Do you want to share it now?",
                        style: TextStyle(
                          color: Color(0xff4B4B4B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          await GoalService(
                                  goalID: widget.goalID,
                                  uid: Provider.of<OurUser>(context,
                                          listen: false)
                                      .uid)
                              .publishGoal();
                        },
                        child: _buildButtonText(_shared),
                        style: shareButtonStyle(_shared),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Quit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: quitButtonStyle(),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: SpinKitFadingFour(size: 35.0, color: themeColor),
      );
    }
  }

  Container _buildSharedGoalHeader(UserGoal userGoal) {
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userGoal.goal.title,
                style: TextStyle(
                  color: themeShadedColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    userGoal.goal.category,
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    userGoal.goal.period,
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "${userGoal.goal.timespan} days left",
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text _buildButtonText(bool shared) {
    if (shared) {
      return Text(
        "Shared",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "Share",
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  ButtonStyle shareButtonStyle(bool shared) {
    return ElevatedButton.styleFrom(
      primary: shared ? monoButtonTextColor : themeColor,
      shadowColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  ButtonStyle quitButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: Color(0xffF1908e),
      shadowColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }
}

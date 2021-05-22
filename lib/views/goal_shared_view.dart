import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SharedGoalView extends StatefulWidget {
  final goalID;

  SharedGoalView({this.goalID});
  @override
  _SharedGoalViewState createState() => _SharedGoalViewState();
}

class _SharedGoalViewState extends State<SharedGoalView> {
  bool joined;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SharedGoal>(
        stream: GoalService(goalID: widget.goalID).sharedGoal,
        builder: (context, snapshot) {
          return StreamBuilder<List<JoinedUser>>(
              stream: GoalService(goalID: widget.goalID).joinedUsers,
              builder: (context, joinedUsersSnapshot) {
                return Scaffold(
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: themeShadedColor),
                    elevation: 0,
                  ),
                  body: _buildBody(snapshot, joinedUsersSnapshot),
                );
              });
        });
  }

  Widget _buildBody(snapshot, joinedUsersSnapshot) {
    if (snapshot.hasData) {
      final SharedGoal sharedGoal = snapshot.data;
      _checkIfUserJoined(joinedUsersSnapshot, context);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSharedGoalHeader(sharedGoal),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "Descriptions",
              style: TextStyle(
                color: Color(0xff202020),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
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
            child: Text(
              sharedGoal.description,
              style: TextStyle(
                color: Color(0xff4B4B4B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  if (!joined) {
                    await GoalService(
                      goalID: widget.goalID,
                      uid: Provider.of<OurUser>(context, listen: false).uid,
                      username:
                          Provider.of<OurUser>(context, listen: false).username,
                    ).joinGoal(sharedGoal);
                    setState(() {
                      joined = true;
                    });
                  }
                },
                child: _buildButtonText(joined),
                style: joinButtonStyle(joined),
              ),
            ),
          )
        ],
      );
    } else {
      return Center(
        child: SpinKitFadingFour(size: 35.0, color: themeColor),
      );
    }
  }

  void _checkIfUserJoined(AsyncSnapshot<List<JoinedUser>> joinedUsersSnapshot,
      BuildContext context) {
    List<JoinedUser> joinedUsers = joinedUsersSnapshot.data;
    JoinedUser checkJoined = joinedUsers.firstWhere(
        (user) => user.uid == Provider.of<OurUser>(context).uid,
        orElse: () => null);
    if (checkJoined != null) {
      joined = true;
    } else {
      joined = false;
    }
  }

  Container _buildSharedGoalHeader(sharedGoal) {
    return Container(
      padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sharedGoal.title,
                    style: TextStyle(
                      color: themeShadedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    sharedGoal.category,
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                height: 42,
                width: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffFF9C9C),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: FaIcon(
                  FontAwesomeIcons.walking,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildDateCircles(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 20,
                    color: monoSecondaryColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    sharedGoal.users.length.toString(),
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 14),
                  Icon(
                    Icons.date_range,
                    size: 20,
                    color: monoSecondaryColor,
                  ),
                  SizedBox(width: 5),
                  Text(
                    sharedGoal.timespan.toString(),
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 15,
                  ),
                  SizedBox(width: 7),
                  Text(
                    sharedGoal.createdBy.username,
                    style: TextStyle(
                      color: themeShadedColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildDateCircles() {
    List<String> days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];

    return days.map((day) {
      return _buildDateCircle(day);
    }).toList();
  }

  Container _buildDateCircle(String dayText) {
    return Container(
      height: 42,
      width: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        dayText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Text _buildButtonText(bool joined) {
    if (joined) {
      return Text(
        "Joined",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "Join",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  ButtonStyle joinButtonStyle(bool joined) {
    return ElevatedButton.styleFrom(
      primary: joined ? monoButtonTextColor : themeColor,
      shadowColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:aimimi/views/shares/goal_shared_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SharedGoalItem extends StatefulWidget {
  final String goalID;
  final String title;
  final String category;
  final String period;
  final int frequency;
  final int timespan;
  final String description;
  final bool publicity;
  final dynamic createdBy;
  final dynamic createdByUid;
  final users;

  SharedGoalItem({
    Key key,
    this.goalID,
    this.title,
    this.category,
    this.period,
    this.frequency,
    this.timespan,
    this.description,
    this.publicity,
    this.createdBy,
    this.users,
    this.createdByUid,
  }) : super(key: key);

  @override
  State<SharedGoalItem> createState() => _SharedGoalItemState();
}

class _SharedGoalItemState extends State<SharedGoalItem> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: getImage(widget.createdByUid),
        builder: (context, upperSnapshot) {
          return StreamBuilder<List<JoinedUser>>(
              stream: GoalService(goalID: widget.goalID).joinedUsers,
              builder: (context, snapshot) {
                List<JoinedUser> joinedUsers = snapshot.data ?? [];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SharedGoalView(
                            goalID: widget.goalID,
                          ),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
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
                                  widget.title,
                                  style: TextStyle(
                                    color: themeShadedColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.category,
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
                              child: _buildCategoryIcon(),
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
                                  joinedUsers.length.toString(),
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
                                  widget.timespan.toString(),
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
                                  // maxRadius: 15,
                                  maxRadius: 15,
                                  backgroundColor: themeColor,
                                  backgroundImage: upperSnapshot.data,
                                  child: upperSnapshot.data != null
                                      ? getText(
                                          widget.createdBy, upperSnapshot.data)
                                      : SizedBox(width: 0),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  widget.createdBy,
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
                  ),
                );
              });
        });
  }

  FaIcon _buildCategoryIcon() {
    switch (widget.category) {
      case "Fitness":
        return FaIcon(
          FontAwesomeIcons.running,
          size: 23,
          color: Colors.white,
        );
        break;
      case "Lifestyle":
        return FaIcon(
          FontAwesomeIcons.procedures,
          size: 18,
          color: Colors.white,
        );
      case "Financial":
        return FaIcon(
          FontAwesomeIcons.coins,
          size: 18,
          color: Colors.white,
        );
      case "Educational":
        return FaIcon(
          FontAwesomeIcons.book,
          size: 18,
          color: Colors.white,
        );
      default:
        return FaIcon(
          FontAwesomeIcons.shapes,
          size: 18,
          color: Colors.white,
        );
    }
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

  Future<NetworkImage> getImage(uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (data.data()["photoURL"].toString() != null) {
      return NetworkImage(data.data()["photoURL"].toString());
    } else {
      return NetworkImage("null", scale: 1.0);
    }
  }

  Text getText(String username, NetworkImage data) {
    if (data.url != "null") {
      return null;
    } else {
      return Text(
        username[0].toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }
}

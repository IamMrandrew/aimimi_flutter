import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdItem extends StatelessWidget {
  final String title;
  final String category;
  final String content;
  final CreatedBy createdBy;

  AdItem({this.title, this.category, this.content, this.createdBy});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: getImage(createdBy.uid),
        builder: (context, snapshot) {
          return Container(
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
                          title,
                          style: TextStyle(
                            color: themeShadedColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          category,
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
                        child: _buildCategoryIcon()),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  content,
                  style: TextStyle(
                    color: monoSecondaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: themeColor,
                      maxRadius: 15,
                      backgroundImage: snapshot.data,
                      child: snapshot.data == null
                          ? getText(createdBy.username)
                          : SizedBox(width: 0),
                    ),
                    SizedBox(width: 7),
                    Text(
                      createdBy.username,
                      style: TextStyle(
                        color: themeShadedColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  FaIcon _buildCategoryIcon() {
    switch (category) {
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

  Future getImage(uid) async {
    DocumentSnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (data.data() != null) {
      if (data.data()["photoURL"] != null) {
        print(data.data()["photoURL"]);
        return NetworkImage(data.data()["photoURL"]);
      } else {
        return null;
      }
    }
  }

  Text getText(String username) {
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

import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/widgets/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: themeShadedColor),
        title: Text("Activity", style: appBarTitleTextStyle),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            FeedItem(
              createdBy: "Jason",
              content: "Jason joined your group",
              createdAt:
                  Timestamp.now().toDate().subtract(Duration(minutes: 30)),
            ),
          ],
        ),
      ),
    );
  }
}

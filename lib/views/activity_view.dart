import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/feed.dart';
import 'package:aimimi/widgets/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityView extends StatefulWidget {
  final userGoal;
  ActivityView({this.userGoal});

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  @override
  Widget build(BuildContext context) {
    List<Feed> feeds = Provider.of<List<Feed>>(context);

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
            ListView.builder(
                itemCount: feeds.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Feed feed = Provider.of<List<Feed>>(context)[index];

                  return FeedItem(
                    createdBy: feed.createdBy.username,
                    uid: feed.createdBy.uid,
                    content: feed.content,
                    createdAt: feed.createdAt,
                    feedID: feed.feedID,
                    feed: feed,
                    userGoal: widget.userGoal,
                  );
                }),
          ],
        ),
      ),
    );
  }
}

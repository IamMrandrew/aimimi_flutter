import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/feed.dart';
import 'package:aimimi/widgets/feed/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Feed> feeds = Provider.of<List<Feed>>(context);
    print(feeds);
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
                    content: feed.content,
                    createdAt: Timestamp.now()
                        .toDate()
                        .subtract(Duration(minutes: 30)),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

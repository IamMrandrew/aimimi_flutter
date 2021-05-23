import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/feed.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/views/comment_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import "package:timeago/timeago.dart" as timeago;
import 'package:aimimi/services/feed_service.dart';

class FeedItem extends StatefulWidget {
  final String createdBy;
  final DateTime createdAt;
  final String content;
  final String feedID;
  final String uid;
  final feed;
  final userGoal;
  final int length;
  FeedItem(
      {this.createdBy,
      this.createdAt,
      this.content,
      this.feedID,
      this.uid,
      this.feed,
      this.userGoal,
      this.length});

  @override
  State<FeedItem> createState() => _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: getImage(widget.uid),
        builder: (context, snapshot) {
          return StreamBuilder<List<LikedUser>>(
              stream: FeedService(feedID: widget.feedID).likedUsers,
              builder: (context, likedUsersSnapshot) {
                return _buildBody(likedUsersSnapshot, snapshot.data);
              });
        });
  }

  Widget _buildBody(likedUsersSnapshot, userImage) {
    if (likedUsersSnapshot.hasData) {
      _checkIfUserLiked(likedUsersSnapshot, context);
      return Column(
        children: [
          Container(
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: themeColor,
                  backgroundImage: userImage,
                  child: getText(widget.createdBy, userImage),
                ),
                SizedBox(width: 7),
                Text(
                  this.widget.createdBy,
                  style: TextStyle(
                    color: monoPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(timeago.format(widget.createdAt),
                    style: TextStyle(
                      color: monoSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ),
          ),
          SizedBox(height: 4),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.widget.content,
                      style: TextStyle(
                        color: themeShadedColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        _buildLikeButton("Like", Icons.favorite),
                        SizedBox(
                          width: 10,
                        ),
                        _buildFeedButton("Comment", Icons.question_answer, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentView(
                                      content: widget.content,
                                      createdAt: widget.createdAt,
                                      createdBy: this.widget.createdBy,
                                      feedID: widget.feedID,
                                      userGoal: widget.userGoal,
                                      length: likedUsersSnapshot.data.length)));
                        }),
                      ],
                    )
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
                    FontAwesomeIcons.dumbbell,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
        ],
      );
    } else {
      return Center(
        child: SpinKitFadingFour(size: 35.0, color: themeColor),
      );
    }
  }

  GestureDetector _buildFeedButton(String text, IconData icon, onPressHandler) {
    return GestureDetector(
      onTap: onPressHandler,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Row(
          children: [
            IconButton(
              color: monoButtonTextColor,
              icon: Icon(
                icon,
                size: 17,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: null,
            ),
            SizedBox(width: 4),
            Text(text,
                style: TextStyle(
                  color: monoButtonTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }

  GestureDetector _buildLikeButton(String text, IconData icon) {
    return GestureDetector(
      onTap: () async {
        if (!_liked) {
          print("not liked");
          await FeedService(
                  uid: Provider.of<OurUser>(context, listen: false).uid,
                  feedID: widget.feedID)
              .like(widget.feed);
          setState(() {
            _liked = true;
          });
        } else {
          await FeedService(
                  uid: Provider.of<OurUser>(context, listen: false).uid,
                  feedID: widget.feedID)
              .dislike(widget.feed);
          setState(() {
            _liked = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Row(
          children: [
            if (_liked)
              IconButton(
                color: Color(0xffFE7400),
                icon: Icon(
                  icon,
                  size: 17,
                  color: Color(0xffFE7400),
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: null,
              )
            else
              IconButton(
                color: monoButtonTextColor,
                icon: Icon(
                  icon,
                  size: 17,
                  color: monoButtonTextColor,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: null,
              ),
            SizedBox(width: 4),
            if (_liked)
              Text(text,
                  style: TextStyle(
                    color: Color(0xffFE7400),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))
            else
              (Text(text,
                  style: TextStyle(
                    color: monoButtonTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))),
          ],
        ),
      ),
    );
  }

  void _checkIfUserLiked(likedUsersSnapshot, BuildContext context) {
    List<LikedUser> likedUsers = likedUsersSnapshot.data;
    print(likedUsers);
    LikedUser checkLiked = likedUsers.firstWhere((user) {
      print(user.uid);
      print(Provider.of<OurUser>(context).uid);
      print(user.uid == Provider.of<OurUser>(context).uid);
      return user.uid == Provider.of<OurUser>(context).uid;
    }, orElse: () => null);
    if (checkLiked != null) {
      _liked = true;
    } else {
      _liked = false;
    }
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

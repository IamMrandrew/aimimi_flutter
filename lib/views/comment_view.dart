import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/feed.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/feed_service.dart';
import 'package:aimimi/widgets/feed/comment.dart';
import 'package:aimimi/widgets/feed/comment_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CommentView extends StatefulWidget {
  final String createdBy;
  final DateTime createdAt;
  final String content;
  final String feedID;
  final userGoal;
  final int length;
  CommentView(
      {this.createdBy,
      this.createdAt,
      this.content,
      this.feedID,
      this.userGoal,
      this.length});
  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final user = FirebaseAuth.instance.currentUser;
  String _comment;
  bool _incoming = false;
  NetworkImage getImage() {
    if (user.providerData[0].providerId == 'google.com') {
      return NetworkImage(user.photoURL);
    } else {
      return null;
    }
  }

  Text getText() {
    if (user.providerData[0].providerId == 'google.com') {
      return Text('');
    } else {
      return Text(
        user.displayName[0],
        style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    print(widget.userGoal);
    return StreamBuilder<List<Feed>>(
        stream: FeedService(userGoals: widget.userGoal).feeds,
        builder: (context, snapshot) {
          return StreamBuilder<List<Comment>>(
              stream: FeedService(feedID: widget.feedID).comments,
              builder: (context, commentSnapshot) {
                print("This is the snap shot " + commentSnapshot.toString());
                return Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    iconTheme: IconThemeData(color: themeShadedColor),
                    title: Text("Comment", style: appBarTitleTextStyle),
                  ),
                  body: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Column(
                      children: [
                        CommentTitle(
                          createdBy: widget.createdBy,
                          content: widget.content,
                          createdAt: widget.createdAt,
                          length: widget.length,
                          commentLength: commentSnapshot.data != null
                              ? commentSnapshot.data.length
                              : 0,
                        ),
                        SizedBox(height: 24),
                        Expanded(
                          child: ListView.builder(
                              itemCount: commentSnapshot.data != null
                                  ? commentSnapshot.data.length
                                  : 0,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (commentSnapshot.data[index].createdBy.uid ==
                                    FirebaseAuth.instance.currentUser.uid)
                                  _incoming = true;
                                else
                                  _incoming = false;
                                return CommentItem(
                                  username: commentSnapshot
                                      .data[index].createdBy.username,
                                  content: commentSnapshot.data[index].content,
                                  createdAt:
                                      commentSnapshot.data[index].createdAt,
                                  uid:
                                      commentSnapshot.data[index].createdBy.uid,
                                );
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Type something...",
                                      fillColor: backgroundColor,
                                      filled: true,
                                      border: textFieldBorder,
                                      contentPadding: new EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      isDense: true,
                                      hintStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: monoSecondaryColor,
                                      ),
                                    ),
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return " Comment is empty";
                                      }
                                      return null;
                                    },
                                    onSaved: (String value) {
                                      setState(() {
                                        _comment = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff4b4b4b),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.send),
                                color: Colors.white,
                                onPressed: () async {
                                  if (!_formKey.currentState.validate()) {
                                    return;
                                  }
                                  _formKey.currentState.save();
                                  print(_comment);
                                  FeedService(feedID: widget.feedID)
                                      .addComment(_comment);
                                },
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                );
              });
        });
  }
}

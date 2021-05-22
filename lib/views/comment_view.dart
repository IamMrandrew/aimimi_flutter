import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/widgets/feed/comment.dart';
import 'package:aimimi/widgets/feed/comment_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentView extends StatefulWidget {
  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final user = FirebaseAuth.instance.currentUser;
  String _comment;
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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: themeShadedColor),
        title: Text("Comment", style: appBarTitleTextStyle),
      ),
      body: Container(
        // width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            CommentTitle(
              createdBy: "Jason",
              content: "Joe joined your group",
              createdAt:
                  Timestamp.now().toDate().subtract(Duration(minutes: 30)),
            ),
            SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CommentItem(
                      createdBy: "Joe",
                      content: "Add oil! My friend.",
                      createdAt: Timestamp.now()
                          .toDate()
                          .subtract(Duration(minutes: 30)),
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
                      child: _buildCommentField(),
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff4b4b4b),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                )
              ],
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  TextFormField _buildCommentField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Type something...",
        fillColor: backgroundColor,
        filled: true,
        border: textFieldBorder,
        contentPadding: new EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
    );
  }
}

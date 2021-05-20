import 'package:aimimi/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:timeago/timeago.dart" as timeago;

class FeedItem extends StatelessWidget {
  final String createdBy;
  final DateTime createdAt;
  final String content;

  FeedItem({this.createdBy, this.createdAt, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              CircleAvatar(
                maxRadius: 15,
              ),
              SizedBox(width: 7),
              Text(
                this.createdBy,
                style: TextStyle(
                  color: monoPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(timeago.format(createdAt),
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
                    "$createdBy joined your group",
                    style: TextStyle(
                      color: themeShadedColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      _buildFeedButton("Like", Icons.favorite, () {}),
                      SizedBox(
                        width: 10,
                      ),
                      _buildFeedButton("Comment", Icons.question_answer, () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentView()));
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
      ],
    );
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
}

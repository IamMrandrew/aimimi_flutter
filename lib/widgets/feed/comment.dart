import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/user.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/views/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:timeago/timeago.dart" as timeago;

class CommentItem extends StatelessWidget {
  final String username;
  final DateTime createdAt;
  final String content;

  CommentItem({this.username, this.createdAt, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    maxRadius: 15,
                  ),
                  SizedBox(width: 7),
                  Text(
                    this.username,
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
                      )),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.only(top: 19, left: 10, bottom: 10),
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
                    content,
                    style: TextStyle(
                      color: themeShadedColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 11),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 17,
        )
      ],
    );
  }
}

import 'package:aimimi/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/views/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:timeago/timeago.dart" as timeago;

class CommentTitle extends StatelessWidget {
  final String createdBy;
  final DateTime createdAt;
  final String content;
  final int length;
  final int commentLength;
  CommentTitle(
      {this.createdBy,
      this.createdAt,
      this.content,
      this.length,
      this.commentLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        )),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      color: monoButtonTextColor,
                      icon: Icon(
                        Icons.favorite,
                        size: 15,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: null,
                    ),
                    SizedBox(width: 7),
                    Text("${length} Like",
                        style: TextStyle(
                          color: monoButtonTextColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )
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
                    Row(
                      children: [
                        FaIcon(
                          Icons.question_answer,
                          size: 15,
                          color: monoButtonTextColor,
                        ),
                        SizedBox(width: 12),
                        Text("${commentLength} Comments",
                            style: TextStyle(
                              color: monoButtonTextColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ))
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
      ),
    );
  }
}

import 'package:aimimi/constants/styles.dart';
import 'package:flutter/material.dart';

class TopRank extends StatelessWidget {
  final String uid;
  final String username;
  final double accuracy;
  final int index;

  TopRank({this.uid, this.username, this.accuracy, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 100,
        height: _buildTopRankHeight(context),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(),
            SizedBox(height: 14),
            Text(
              username,
              style: TextStyle(
                color: themeShadedColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text("$accuracy%",
                style: TextStyle(
                  color: themeShadedColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ));
  }

  double _buildTopRankHeight(context) {
    switch (index) {
      case 0:
        return 151;
        break;
      case 1:
        return 135;
        break;
      case 2:
        return 120;
        break;
      default:
        return 120;
    }
  }
}

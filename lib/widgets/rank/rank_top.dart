import 'package:aimimi/constants/styles.dart';
import 'package:flutter/material.dart';

class TopRank extends StatelessWidget {
  final String uid;
  final String username;
  final double accuracy;
  final int index;
  final int length;

  TopRank({this.uid, this.username, this.accuracy, this.index, this.length});

  @override
  Widget build(BuildContext context) {
    if (length == 2) {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 100,
          height: _buildTopRankHeight(context, length),
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
              CircleAvatar(
                backgroundColor: themeColor,
                maxRadius: 20,
                child: getText(username),
              ),
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
    } else {
      return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          width: 100,
          height: _buildTopRankHeight(context, length),
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
              CircleAvatar(
                backgroundColor: themeColor,
                maxRadius: 20,
                child: getText(username),
              ),
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
  }

  double _buildTopRankHeight(context, length) {
    if (length == 2) {
      switch (index) {
        case 0:
          return 135;
          break;
        case 1:
          return 151;
          break;
        case 2:
          return 120;
          break;
        default:
          return 120;
      }
    } else {
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

  Text getText(String username) {
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

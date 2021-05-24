import 'package:aimimi/constants/styles.dart';
import 'package:flutter/material.dart';

class RankItem extends StatelessWidget {
  final String uid;
  final String username;
  final double accuracy;
  final int index;

  RankItem({this.uid, this.username, this.accuracy, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "#$index",
            style: TextStyle(
              color: themeShadedColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("$username",
              style: TextStyle(
                color: monoPrimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
          Text(
            accuracy.toStringAsFixed(1) + "%",
            style: TextStyle(
              color: monoPrimaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

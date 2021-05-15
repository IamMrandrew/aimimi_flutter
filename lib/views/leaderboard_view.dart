import 'package:flutter/material.dart';

class LeaderboardView extends StatefulWidget {
  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(child: new Text("LeaderBoard")),
    );
  }
}

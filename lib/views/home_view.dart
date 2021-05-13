import 'package:aimimi/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffFFFFFF),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
              color: monoSecondaryColor,
            ),
            label: "Today",
            activeIcon: Icon(Icons.today, color: themeShadedColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events,
              color: monoSecondaryColor,
            ),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: monoSecondaryColor,
            ),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userCircle,
              color: monoSecondaryColor,
            ),
            label: "Profile",
          ),
        ],
        selectedLabelStyle: TextStyle(
          color: themeShadedColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: TextStyle(
          color: monoSecondaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        selectedItemColor: themeShadedColor,
      ),
    );
  }
}

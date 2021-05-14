import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/views/today_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.bullseye),
            color: themeShadedColor,
            onPressed: () {
              //print("Pressed");
            },
          ),
          centerTitle: true,
          title: Text(
            "Today",
            style: TextStyle(
              color: themeShadedColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.solidBell),
              color: themeShadedColor,
              onPressed: () {
                //print("Pressed");
              },
            )
          ]),
      body: TodayView(),
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
              Icons.indeterminate_check_box_outlined,
              color: monoSecondaryColor,
            ),
            label: "Goals",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: monoSecondaryColor,
            ),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
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

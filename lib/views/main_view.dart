import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/views/leaderboard_view.dart';
import 'package:aimimi/views/profile_view.dart';
import 'package:aimimi/views/today_view.dart';
import 'package:aimimi/views/goal_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final List<Widget> _views = [
    TodayView(),
    GoalView(),
    LeaderboardView(),
    ProfileView(),
  ];
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          leadingWidth: 60,
          leading: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.bullseye),
                color: themeShadedColor,
                onPressed: () {
                  //print("Pressed");
                },
              ),
            ],
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
            ),
            SizedBox(
              width: 10,
            )
          ]),
      //body: GoalView(),
      body: _views[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xffFFFFFF),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.today,
              //color: monoSecondaryColor,
            ),
            label: "Today",
            activeIcon: Icon(Icons.today, color: themeShadedColor),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.indeterminate_check_box_outlined,
              //color: monoSecondaryColor,
            ),
            label: "Goals",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.emoji_events_outlined,
              //color: monoSecondaryColor,
            ),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              //color: monoSecondaryColor,
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
        unselectedItemColor: monoSecondaryColor,
      ),
    );
  }
}

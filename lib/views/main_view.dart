import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/auth_service.dart';
import 'package:aimimi/services/feed_service.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:aimimi/views/shares_view.dart';
import 'package:aimimi/views/activity_view.dart';
import 'package:aimimi/views/today_view.dart';
import 'package:aimimi/widgets/modal/modal_add_goal.dart';
import 'package:aimimi/views/leaderboard_view.dart';
import 'package:aimimi/views/profile_view.dart';
import 'package:aimimi/views/goals_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:aimimi/models/feed.dart';

List<String> title = ["Today", "Goals", "Leaderboard", "Profile"];

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  void _modalHandler(ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return ModalAddGoal(ctx: ctx);
      },
    );
  }

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          StreamProvider<List<SharedGoal>>.value(
                            initialData: [],
                            value: GoalService().sharedGoals,
                          ),
                        ],
                        child: SharesView(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          centerTitle: true,
          title: Text(
            title[_currentIndex],
            style: appBarTitleTextStyle,
          ),
          elevation: 0,
          actions: [
            IconButton(
              icon: FaIcon(FontAwesomeIcons.solidBell),
              color: themeShadedColor,
              onPressed: () {
                var userGoal =
                    Provider.of<List<UserGoal>>(context, listen: false);
                // print(userGoal);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          StreamProvider<List<Feed>>.value(
                            initialData: [],
                            value: FeedService(userGoals: userGoal).feeds,
                          ),
                        ],
                        child: ActivityView(),
                      ),
                    ));
              },
            ),
            SizedBox(
              width: 10,
            )
          ]),
      body: _views[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _currentIndex < 2
          ? FloatingActionButton(
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
              onPressed: () => _modalHandler(context),
              elevation: 0,
            )
          : null,
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
              Icons.leaderboard_outlined,
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

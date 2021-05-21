import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/widgets/goal/goal_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharesView extends StatefulWidget {
  @override
  _SharesViewState createState() => _SharesViewState();
}

class _SharesViewState extends State<SharesView> {
  @override
  Widget build(BuildContext context) {
    List<SharedGoal> sharedGoals = Provider.of<List<SharedGoal>>(context);
    List items = [
      Text(
        "Recommended For You",
        style: TextStyle(
          color: themeShadedColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    ];
    items += sharedGoals;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: themeShadedColor),
        title: Text("Shares", style: appBarTitleTextStyle),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  print(index);
                  final item = items?.elementAt(index) ?? "";
                  if (item is SharedGoal)
                    return SharedGoalItem(
                      title: item.title,
                      category: item.category,
                      period: item.period,
                      frequency: item.frequency,
                      description: item.description,
                      createdBy: item.createdBy.username,
                      publicity: item.publicity,
                      timespan: item.timespan,
                      users: ["asdasda", "dsadsaads"],
                    );
                  else
                    return item;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

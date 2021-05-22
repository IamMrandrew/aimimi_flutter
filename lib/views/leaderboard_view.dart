import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/rank.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/widgets/rank/rank.dart';
import 'package:aimimi/widgets/rank/rank_top.dart';
import 'package:flutter/material.dart';

class LeaderboardView extends StatefulWidget {
  @override
  _LeaderboardViewState createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<LeaderboardView> {
  String _selectedGoalID;
  // mock data
  List<Rank> ranks = [
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "Andrew Li",
        accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "Terrence Au",
        accuracy: 100),
    Rank(uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "Nam", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "BadAndrew",
        accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadBob", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadNam", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "BadAndrew",
        accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadBob", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadNam", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "BadAndrew",
        accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadBob", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadNam", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3",
        username: "BadAndrew",
        accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadBob", accuracy: 100),
    Rank(
        uid: "xmpHtZYsXHN9wMLTs01pi9q7f6H3", username: "BadNam", accuracy: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Column(children: [
        _buildSelectDropdown(),
        SizedBox(height: 10),
        _buildTopRankContainer(),
        SizedBox(height: 15),
        _buildRankContainer()
      ]),
    );
  }

  Expanded _buildRankContainer() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18))),
        padding: EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 20),
        child: ListView(
          children: _buildRanks(),
        ),
      ),
    );
  }

  Container _buildTopRankContainer() {
    return Container(
      width: double.infinity,
      height: 167,
      decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.all(Radius.circular(18))),
      padding: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: _buildTopRanks(),
      ),
    );
  }

  List<Widget> _buildTopRanks() {
    List<Widget> rearrange(list) {
      list.insert(0, list.removeAt(1));
      return list;
    }

    return rearrange(ranks.sublist(0, 3).asMap().entries.map((entry) {
      int index = entry.key;
      Rank rank = entry.value;
      return TopRank(
        uid: rank.uid,
        username: rank.username,
        accuracy: rank.accuracy,
        index: index,
      );
    }).toList());
  }

  List<Widget> _buildRanks() {
    return ranks.sublist(3).asMap().entries.map((entry) {
      int index = entry.key;
      Rank rank = entry.value;
      return RankItem(
        uid: rank.uid,
        username: rank.username,
        accuracy: rank.accuracy,
        index: index,
      );
    }).toList();
  }

  Align _buildSelectDropdown() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: DropdownButton<String>(
          value: _selectedGoalID,
          dropdownColor: Colors.white,
          isDense: true,
          underline: SizedBox(),
          hint: Text("Select"),
          style: TextStyle(
            fontFamily: "Roboto",
            color: monoPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
          icon: Icon(
            Icons.arrow_drop_down_outlined,
            color: monoSecondaryColor,
          ),
          iconSize: 28,
          items: ["Learn Flutter", "Read a book", "Drink water"].map((item) {
            return DropdownMenuItem(
              child: Text(item),
              value: item,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedGoalID = value;
            });
          },
        ),
      ),
    );
  }
}

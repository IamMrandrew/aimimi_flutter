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
  List<SharedGoal> _searchResult = [];
  TextEditingController _controller = TextEditingController();
  FocusNode _focus = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {
        _focused = !_focused;
      });
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

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
      appBar: singleViewAppBar("Shares"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(sharedGoals),
            SizedBox(height: 15),
            _buildListView(items)
          ],
        ),
      ),
    );
  }

  ListView _buildListView(List items) {
    return ListView.separated(
      itemCount: _focused ? _searchResult.length : items.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = _focused
            ? _searchResult?.elementAt(index) ?? ""
            : items?.elementAt(index) ?? "";
        if (item is SharedGoal)
          return SharedGoalItem(
            goalID: item.goalID,
            title: item.title,
            category: item.category,
            period: item.period,
            frequency: item.frequency,
            description: item.description,
            createdBy: item.createdBy.username,
            publicity: item.publicity,
            timespan: item.timespan,
            users: item.users,
          );
        else
          return item;
      },
    );
  }

  Row _buildSearchBar(List<SharedGoal> sharedGoals) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (String input) {
              _search(input, sharedGoals);
            },
            controller: _controller,
            focusNode: _focus,
            decoration: InputDecoration(
              hintText: "Read a book, Lifestyle ...",
              fillColor: backgroundColor,
              filled: true,
              border: searchFieldBorder,
              contentPadding: EdgeInsets.all(12),
              isDense: true,
              prefixIconConstraints: BoxConstraints(minWidth: 40),
              prefixIcon: Icon(
                Icons.search,
                color: monoSecondaryColor,
              ),
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: monoSecondaryColor,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _focus.unfocus();
            _controller.clear();
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Text(
            "Cancel",
            style: TextStyle(
              color: monoSecondaryColor,
            ),
          ),
        )
      ],
    );
  }

  void _search(String input, List<SharedGoal> sharedGoals) {
    final result = sharedGoals.where((SharedGoal goal) {
      final String query = input.toLowerCase();
      final String title = goal.title.toLowerCase();
      final String category = goal.category.toLowerCase();

      return title.contains(query) || category.contains(query);
    }).toList();

    setState(() {
      _searchResult = result;
    });
  }
}

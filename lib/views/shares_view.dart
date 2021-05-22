import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/widgets/goal/goal_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharesView extends StatefulWidget {
  @override
  _SharesViewState createState() => _SharesViewState();
}

class _SharesViewState extends State<SharesView>
    with SingleTickerProviderStateMixin {
  List<SharedGoal> _searchResult = [];
  TextEditingController _controller = TextEditingController();
  FocusNode _focus = FocusNode();
  AnimationController _animationController;
  CurvedAnimation _curve;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _curve = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCubic);
    _focus.addListener(() {
      setState(() {
        _focused = !_focused;
      });
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<SharedGoal> sharedGoals = Provider.of<List<SharedGoal>>(context);
    print(sharedGoals);
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
      // appBar: singleViewAppBar("Shares"),
      body: Container(
        color: Colors.white,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: SafeArea(
          bottom: false,
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, -56 * _curve.value),
                      child: SingleChildScrollView(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 56),
                            _buildSearchBar(sharedGoals),
                            SizedBox(height: 15),
                            _buildListView(items)
                          ],
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 100),
                      child: _focused
                          ? Container(key: UniqueKey(), width: 0, height: 0)
                          : Container(
                              // key: UniqueKey(),
                              height: 56,
                              child: singleViewAppBar("Shares"),
                            ),
                    ),
                  ],
                );
              }),
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

  Widget _buildSearchBar(List<SharedGoal> sharedGoals) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 50,
            ),
            Positioned(
              right: 0,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: _focused
                    ? TextButton(
                        key: UniqueKey(),
                        onPressed: () {
                          _focus.unfocus();
                          _controller.clear();
                        },
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: monoSecondaryColor,
                          ),
                        ),
                      )
                    : Container(key: UniqueKey(), width: 0, height: 0),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _focused
                  ? MediaQuery.of(context).size.width - 120
                  : MediaQuery.of(context).size.width - 50,
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
          ],
        ),
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

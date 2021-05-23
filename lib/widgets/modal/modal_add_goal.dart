import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ModalAddGoal extends StatefulWidget {
  final ctx;

  ModalAddGoal({this.ctx, Key key}) : super(key: key);

  @override
  _ModalAddGoalState createState() => _ModalAddGoalState();
}

class _ModalAddGoalState extends State<ModalAddGoal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CollectionReference<Map<String, dynamic>> goalCollection =
      FirebaseFirestore.instance.collection("goals");
  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  String _title;
  String _category;
  int _frequency;
  String _period = "Daily";
  int _timespan;
  String _description;
  bool _publicity = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.92,
      child: Container(
        padding: EdgeInsets.all(20),
        // height: MediaQuery.of(context).size.height * 0.92,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            // Modal title bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.times,
                    color: themeShadedColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "Add Goal",
                  style: appBarTitleTextStyle,
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.check,
                    color: themeShadedColor,
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();

                    print(FirebaseAuth.instance.currentUser.uid);

                    await GoalService(
                            uid: Provider.of<OurUser>(context, listen: false)
                                .uid,
                            username:
                                Provider.of<OurUser>(context, listen: false)
                                    .username)
                        .addGoal(_title, _category, _description, _publicity,
                            _period, _frequency, _timespan);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    // Add goal input form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitleField(),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "In what category?",
                            style: textFieldTitleTextStyle,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _buildCategoryDropdown(),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Repeating period?",
                            style: textFieldTitleTextStyle,
                          ),
                          _buildPeriodButtons(),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "How many times?",
                            style: textFieldTitleTextStyle,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _buildFrequencyField(),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Last for how long?",
                            style: textFieldTitleTextStyle,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _buildTimespanField(),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Description",
                            style: textFieldTitleTextStyle,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          _buildDescriptionField(),
                          SizedBox(
                            height: 12,
                          ),
                          _buildPublicityCheckbox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField _buildTitleField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "What is your goal?",
        fillColor: backgroundColor,
        filled: true,
        border: textFieldBorder,
        contentPadding: EdgeInsets.all(10),
        isDense: true,
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: monoSecondaryColor,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Goal title is empty";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _title = value;
        });
      },
    );
  }

  Container _buildCategoryDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: DropdownButton<String>(
        value: _category,
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
        items: ["Lifestyle", "Sport"].map((item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _category = value;
          });
        },
      ),
    );
  }

  Row _buildPeriodButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _period = "Daily";
            });
          },
          child: Text(
            "Daily",
            style: selectButtonTextStyle(_period == "Daily"),
          ),
          style: selectButtonStyle(_period == "Daily"),
        ),
        SizedBox(width: 8),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _period = "Weekly";
              });
            },
            child: Text(
              "Weekly",
              style: selectButtonTextStyle(_period == "Weekly"),
            ),
            style: selectButtonStyle(
              _period == "Weekly",
            ))
      ],
    );
  }

  TextFormField _buildFrequencyField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "1",
        fillColor: backgroundColor,
        filled: true,
        border: textFieldBorder,
        contentPadding: EdgeInsets.all(10),
        isDense: true,
        hintStyle: textFieldHintTextStyle,
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int frequency = int.tryParse(value);

        if (frequency == null || frequency <= 0) {
          return "Frequency is empty or invalid";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _frequency = int.tryParse(value);
        });
      },
    );
  }

  TextFormField _buildTimespanField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "3",
        fillColor: backgroundColor,
        filled: true,
        border: textFieldBorder,
        contentPadding: EdgeInsets.all(10),
        isDense: true,
        hintStyle: textFieldHintTextStyle,
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        int timespan = int.tryParse(value);

        if (timespan == null || timespan <= 0) {
          return "Timespan is empty or invalid";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _timespan = int.tryParse(value);
        });
      },
    );
  }

  TextFormField _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Typing something about your goal ...",
        fillColor: backgroundColor,
        filled: true,
        border: textFieldBorder,
        contentPadding: EdgeInsets.all(10),
        isDense: true,
        hintStyle: textFieldHintTextStyle,
      ),
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      validator: (String value) {
        if (value.isEmpty) {
          return "Description is empty";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _description = value;
        });
      },
    );
  }

  CheckboxListTile _buildPublicityCheckbox() {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        "Shared goal?",
        style: textFieldTitleTextStyle,
      ),
      value: _publicity,
      contentPadding: EdgeInsets.zero,
      onChanged: (value) {
        setState(() {
          _publicity = !_publicity;
        });
      },
    );
  }

  // Button styles
  TextStyle selectButtonTextStyle(bool selected) {
    return TextStyle(color: selected ? Colors.white : monoPrimaryColor);
  }

  ButtonStyle selectButtonStyle(bool selected) {
    return ElevatedButton.styleFrom(
      primary: selected ? themeColor : backgroundColor,
      shadowColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

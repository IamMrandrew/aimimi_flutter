import 'package:aimimi/styles/buttons.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/styles/text_fields.dart';
import 'package:aimimi/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModalAddGoal extends StatefulWidget {
  @override
  _ModalAddGoalState createState() => _ModalAddGoalState();
}

class _ModalAddGoalState extends State<ModalAddGoal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _title;
  String _category;
  String _frequency;
  String _period = "Daily";
  String _timespan;
  String _description;
  bool _publicity = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print({
                    "title": _title,
                    "category": _category,
                    "period": _period,
                    "frequency": _frequency,
                    "timespan": _timespan,
                    "description": _description,
                    "publicity": _publicity,
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
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
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.92,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
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
          _frequency = value;
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
          _timespan = value;
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
      keyboardType: TextInputType.number,
      maxLines: 3,
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
}

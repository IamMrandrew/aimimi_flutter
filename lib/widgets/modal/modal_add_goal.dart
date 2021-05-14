import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/styles/text_fields.dart';
import 'package:aimimi/styles/text_styles.dart';
import 'package:dropdown_below/dropdown_below.dart';
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
  String _period;
  String _timespan;
  String _description;
  bool _publicity = false;

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
          return "Name is Required";
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

  DropdownBelow<String> _buildCategoryDropdown() {
    return DropdownBelow(
      // dropdownColor: Colors.white,
      boxPadding: EdgeInsets.symmetric(horizontal: 10),
      boxWidth: 180,
      boxHeight: 45,
      itemWidth: 180,
      itemTextstyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      boxTextstyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: monoSecondaryColor,
      ),
      hint: Text("Select"),
      // icon: Icon(
      //   Icons.arrow_drop_down_outlined,
      //   color: monoSecondaryColor,
      // ),
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
          return "Name is Required";
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
        if (value.isEmpty) {
          return "Name is Required";
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
          return "Name is Required";
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

  Container _buildModal() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.times,
                  color: themeShadedColor,
                ),
                onPressed: () {},
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

                  print(_title);
                },
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Everyday"),
                      style: ElevatedButton.styleFrom(
                        primary: themeColor,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Weekly",
                        style: TextStyle(color: monoPrimaryColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: backgroundColor,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                  ],
                ),
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

  @override
  Widget build(BuildContext context) {
    return _buildModal();
  }
}

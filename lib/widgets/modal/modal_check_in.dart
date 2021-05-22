import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/models/goal.dart';
import 'package:aimimi/models/user.dart';
import 'package:aimimi/services/goal_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ModalCheckIn extends StatefulWidget {
  final selectedGoal;
  ModalCheckIn({Key key, UserGoal this.selectedGoal}) : super(key: key);

  @override
  _ModalCheckInState createState() => _ModalCheckInState();
}

class _ModalCheckInState extends State<ModalCheckIn> {
  int _checkIn;

  @override
  void initState() {
    super.initState();
    _checkIn = widget.selectedGoal.checkIn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 40, right: 40, bottom: 40),
            child: Column(
              children: [
                Text(
                  "Add Progress",
                  style: TextStyle(
                    color: monoPrimaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                _buildSlider(context),
                SizedBox(
                  height: 14,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Check-in function
                      await GoalService(
                              uid: Provider.of<OurUser>(context, listen: false)
                                  .uid)
                          .checkInGoal(_checkIn, widget.selectedGoal);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Check in",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: themeColor,
                      elevation: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 10,
            child: Container(
              height: 4,
              width: 90,
              decoration: BoxDecoration(
                color: Color(0xffE8E8E8),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
      height: 255,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
    );
  }

  Padding _buildSlider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Text(
            "0",
            style: TextStyle(
              color: monoPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: themeColor,
                inactiveTrackColor: Color(0xffDDDDDD),
                trackHeight: 8,
                thumbColor: Colors.white,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayColor: Colors.transparent,
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: themeColor,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.white,
                inactiveTickMarkColor: Colors.white,
              ),
              child: Slider(
                value: _checkIn.toDouble(),
                max: widget.selectedGoal.goal.frequency.toDouble(),
                min: 0,
                divisions: widget.selectedGoal.goal.frequency,
                label: _checkIn.toString(),
                onChanged: (double value) {
                  setState(() {
                    _checkIn = value.toInt();
                  });
                },
              ),
            ),
          ),
          Text(
            widget.selectedGoal.goal.frequency.toString(),
            style: TextStyle(
              color: monoPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

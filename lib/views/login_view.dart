import 'package:aimimi/styles/text_fields.dart';
import 'package:aimimi/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: themeColor,
        ),
        child: FractionallySizedBox(
          heightFactor: 0.85,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 70),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        fontSize: 40,
                        color: monoPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _emailField,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: monoSecondaryColor,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                      color: monoSecondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordField,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: monoSecondaryColor,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    hintText: "Enter your password",
                    hintStyle: TextStyle(
                      color: monoSecondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: themeColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: themeColor,
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                          fontSize: 15,
                          color: monoSecondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          color: themeShadedColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Container(
                      width: 159,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: monoTintedColor,
                        width: 1,
                      )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "or",
                      style: TextStyle(
                          fontSize: 15,
                          color: monoTintedColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 159,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: monoTintedColor,
                        width: 1,
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: monoTintedColor,
                        width: 1,
                      )),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "lib/image/google.png",
                          height: 23,
                          width: 23,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Color(0xff4B4B4B),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: monoPrimaryColor,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: monoTintedColor,
                        width: 1,
                      )),
                  child: MaterialButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.apple,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Sign in with Apple",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

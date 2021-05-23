import 'package:aimimi/services/auth_service.dart';
import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/views/signup_view.dart';
import 'package:aimimi/widgets/background_painter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String email, password;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
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
                  Form(
                      key: formkey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
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
                              errorBorder: _buildErrorBorder(),
                              focusedErrorBorder: _buildFocusedErrorBorder(),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "This Field Is Required"),
                              EmailValidator(
                                  errorText: "Invalid Email Address"),
                            ]),
                            onChanged: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          TextFormField(
                            obscureText: true,
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
                              errorBorder: _buildErrorBorder(),
                              focusedErrorBorder: _buildFocusedErrorBorder(),
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password Is Required"),
                              MinLengthValidator(6,
                                  errorText: "Minimum 6 Characters Required"),
                            ]),
                            onChanged: (val) {
                              password = val;
                            },
                          ),
                        ],
                      )),
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
                      onPressed: () async {
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          var result = await Provider.of<AuthService>(context,
                                  listen: false)
                              .emailLogin(email, password, context);
                          print(result.uid);
                        }
                      },
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
                        onPressed: navigateToSignUp,
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5 -
                            20 -
                            10 -
                            7,
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
                        width: MediaQuery.of(context).size.width * 0.5 -
                            20 -
                            10 -
                            7,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: monoTintedColor,
                          width: 1,
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
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
                      onPressed: () async {
                        var result = await Provider.of<AuthService>(context,
                                listen: false)
                            .googleLogin();
                        print(result.uid);
                      },
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
                      onPressed: () {
                        print(email);
                        print(password);
                      },
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
      ),
    );
  }

  OutlineInputBorder _buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        color: Colors.red[400],
        width: 2.0,
      ),
    );
  }

  OutlineInputBorder _buildFocusedErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: BorderSide(
        color: Colors.red[400],
        width: 2.0,
      ),
    );
  }

  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );

  navigateToSignUp() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupView()));
  }
}

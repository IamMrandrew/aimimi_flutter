import 'package:aimimi/constants/styles.dart';
import 'package:aimimi/providers/auth.dart';
import 'package:aimimi/views/login_view.dart';
import 'package:aimimi/widgets/background_painter.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String email, password, name, password1;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign Up",
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
                              Icons.account_circle_outlined,
                              color: monoSecondaryColor,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            hintText: "Enter your name",
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
                          ]),
                          onChanged: (val) {
                            name = val;
                          },
                        ),
                        SizedBox(
                          height: 7,
                        ),
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
                                errorText: "Password Is Required"),
                            EmailValidator(errorText: "Invalid Email Address"),
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
                            password1 = val;
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
                            hintText: "Confirm Your Password",
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
                          validator: (val) {
                            if (val != password1) {
                              return 'Password not match.';
                            }
                          },
                          onChanged: (val) {
                            password = val;
                          },
                        )
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
                        final provider =
                            Provider.of<AuthService>(context, listen: false);
                        var result = await provider.signUp(
                            email, password, name, context);
                        print(result.uid);
                      }
                    },
                    child: Text(
                      "Sign Up",
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
                      "Already have an account?",
                      style: TextStyle(
                          fontSize: 15,
                          color: monoSecondaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: navigateToLogin,
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 15,
                          color: themeShadedColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
  navigateToLogin() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginView()));
  }
}

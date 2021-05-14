import 'package:aimimi/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:aimimi/views/main_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aimimi',
      theme: ThemeData(
        // Default colors
        primaryColor: Colors.white,
        accentColor: themeColor,

        // Default font
        fontFamily: "Roboto",
        textTheme: TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: MainView(),
    );
  }
}

import 'package:aimimi/providers/google_sign_in.dart';
import 'package:aimimi/providers/goals_provider.dart';
import 'package:aimimi/styles/colors.dart';
import 'package:aimimi/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aimimi/views/main_view.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        scaffoldBackgroundColor: backgroundTintedColor,
        canvasColor: Colors.transparent,

        // Default font
        fontFamily: "Roboto",
        // textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      // home: MainView(),
      home: ChangeNotifierProvider<GoalsProvider>(
        create: (_) => GoalsProvider(),
        child: LoginView(),
      ),
    );
  }
}

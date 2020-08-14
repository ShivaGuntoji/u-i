import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:helping_hands/Screens/Welcome/welcome_screen.dart';
import 'package:helping_hands/Screens/visit_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Helping hands',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: VisitPage(),
    );
  }
}

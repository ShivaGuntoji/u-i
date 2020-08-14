import 'package:flutter/material.dart';
import 'package:helping_hands/Screens/Login/login_screen.dart';
import 'package:helping_hands/components/rounded_button.dart';
import 'package:helping_hands/Screens/Login/components/background.dart';
import 'package:helping_hands/Screens/Login/login_donor.dart';
import 'package:helping_hands/Screens/Login/login_donee.dart';

class LoginTypePage extends StatefulWidget {
  @override
  _LoginTypePageState createState() => _LoginTypePageState();
}

class _LoginTypePageState extends State<LoginTypePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN PAGE",
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: 'DONOR',
                press: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginDonor();
                  }));
                },
              ),
              RoundedButton(
                text: 'DONEE',
                press: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginDonee();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helping_hands/Screens/Signup/components/background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helping_hands/components/rounded_input_field.dart';
import 'package:helping_hands/components/rounded_button.dart';
import 'package:helping_hands/Screens/Login/login_donor.dart';
import 'package:helping_hands/Screens/Login/login_donee.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  String userName;
  String userMobile;
  String userEmail;
  String userType;
  String userAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedInputField(
              hintText: "Name",
              onChanged: (value) {
                userName = value;
              },
            ),
            RoundedInputField(
              hintText: 'mobile',
              onChanged: (value) {
                userMobile = value;
              },
            ),
            RoundedInputField(
              hintText: 'email',
              onChanged: (value) {
                userEmail = value;
              },
            ),
            RoundedInputField(
              hintText: 'address',
              onChanged: (value) {
                userAddress = value;
              },
            ),
            RoundedInputField(
              hintText: 'type',
              onChanged: (value) {
                userType = value;
              },
            ),
            RoundedButton(
              text: "SUBMIT",
              press: () {
                _firestore.collection("donation").add({
                  'name': userName,
                  'mobile': userMobile,
                  'email': userEmail,
                  'address': userAddress,
                  'type': userType
                });
                if (userType == 'donor') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginDonor();
                  }));
                }
                if (userType == 'donee') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginDonee();
                  }));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

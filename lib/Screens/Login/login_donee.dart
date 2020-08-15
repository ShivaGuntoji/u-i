import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Screens/Login/components/background.dart';
import 'package:helping_hands/Screens/visit_page.dart';
import 'package:helping_hands/components/rounded_input_field.dart';
import 'package:helping_hands/components/rounded_button.dart';
import 'package:helping_hands/components/rounded_password_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helping_hands/components/already_have_an_account_acheck.dart';
import 'package:helping_hands/Screens/Signup/signup_screen.dart';
import 'package:helping_hands/doner_visit_page.dart';

class LoginDonee extends StatefulWidget {
  @override
  _LoginDoneeState createState() => _LoginDoneeState();
}

class _LoginDoneeState extends State<LoginDonee> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN DONEE",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DonerVisitPage();
                      }));
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

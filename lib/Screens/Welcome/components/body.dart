import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helping_hands/Screens/Login/login_type_page.dart';
import 'package:helping_hands/Screens/Signup/signup_screen.dart';
import 'package:helping_hands/Screens/Welcome/components/background.dart';
import 'package:helping_hands/components/rounded_button.dart';
import 'package:helping_hands/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: size.height*0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    //"WELCOME TO U&I",
                    "HELPING HANDS IN NEED",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                  Text(
                    //"WELCOME TO U&I",
                    "AN U&I ORGANISATION",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/helping.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              SizedBox(
                height: 10,
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginTypePage();
                      },
                    ),
                  );
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
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

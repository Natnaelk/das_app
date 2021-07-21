import 'package:das_app/components/default_button.dart';
import 'package:das_app/components/form_error.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/sign_in/components/sign_form.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // ignore: prefer_const_literals_to_create_immutables
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.04,
                  ),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "sign in with your phone number and password",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.08,
                  ),
                  const SignForm(),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                        ),
                      ),
                      Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  )
                ]),
              ),
            ))
      ],
    );
  }
}

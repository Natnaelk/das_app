import 'package:das_app/constants.dart';
import 'package:das_app/screens/sign_in/sign_in_screen.dart';
import 'package:das_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  bool shouldNavigate = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              shouldNavigate = await signOut();
              if (shouldNavigate) {
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (route) => false);
              } else {
                AlertDialog(
                  title: Text(
                    "Error",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

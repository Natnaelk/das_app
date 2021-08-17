import 'package:das_app/screens/create_account/create_account_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: (15),
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, CreateAccountScreen.routeName),
          child: Text(
            "Create Account",
            style: TextStyle(
              fontSize: (15),
              color: kPrimaryColor,
            ),
          ),
        )
      ],
    );
  }
}

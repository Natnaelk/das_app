import 'package:das_app/screens/create_account/create_account_screen.dart';
import 'package:das_app/screens/otp/components/phone_txtform.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: (15),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => PhoneLogIn()));
          },
          // Navigator.pushNamed(context, CreateAccountScreen.routeName),

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

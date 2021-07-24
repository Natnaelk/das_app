import 'package:das_app/screens/otp/components/body.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  static var routeName = '/otp_screen';

  const OtpScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Otp Verification"),
      ),
      body: Body(),
    );
  }
}

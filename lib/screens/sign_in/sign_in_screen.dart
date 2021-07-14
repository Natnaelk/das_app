import 'package:flutter/material.dart';
import '../Sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/create_account";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Log In")), body: const Body());
  }
}

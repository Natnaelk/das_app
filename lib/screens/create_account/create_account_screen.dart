import 'package:flutter/material.dart';

import 'components/body.dart';

class CreateAccountScreen extends StatelessWidget {
  static String routeName = "/create_account";

  const CreateAccountScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account"),
      ),
      body: Body(),
    );
  }
}

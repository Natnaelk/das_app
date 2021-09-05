import 'package:das_app/screens/idirgroup/components/body.dart';
import 'package:flutter/material.dart';

class IdirScreen extends StatelessWidget {
  const IdirScreen({Key key}) : super(key: key);

  static var routeName = '/idirScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

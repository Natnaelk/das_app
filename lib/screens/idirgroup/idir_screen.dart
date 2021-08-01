// ignore: file_names
import 'package:das_app/constants.dart';
import 'package:das_app/screens/idirgroup/components/body.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class IdirScreen extends StatelessWidget {
  const IdirScreen({Key key}) : super(key: key);

  static var routeName = '/idirScreen';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

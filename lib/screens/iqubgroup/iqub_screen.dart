import 'package:das_app/components/default_button.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/components/body.dart';
import 'package:das_app/screens/iqubgroup/components/create_iqub_form.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class IqubScreen extends StatelessWidget {
  const IqubScreen({Key key}) : super(key: key);

  static var routeName = '/iqubScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

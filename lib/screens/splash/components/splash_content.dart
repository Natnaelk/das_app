import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:das_app/constants.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      const Text(
        "DAS",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 36,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        text,
        textAlign: TextAlign.center,
      ),
      const Padding(padding: EdgeInsets.only(top: 10)),
      //const Spacer(flex: 2),
      Image.asset(
        image,
        height: 280,
        width: 280,
      )
    ]);
  }
}

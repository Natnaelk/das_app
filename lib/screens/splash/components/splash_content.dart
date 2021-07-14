import 'package:flutter/material.dart';
import 'package:das_app/constants.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String? text, image;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const Text(
        "DAS",
        style: TextStyle(
          fontSize: 36,
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        text!,
        textAlign: TextAlign.center,
      ),
      const Spacer(flex: 2),
      Image.asset(
        image!,
        height: 190,
        width: 300,
      )
    ]);
  }
}

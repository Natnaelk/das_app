// ignore_for_file: file_names

import 'package:das_app/constants.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationIconBtn extends StatelessWidget {
  const NotificationIconBtn({
    Key key,
    @required this.svgSrc,
    this.numOfItems = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(children: <Widget>[
        Container(
          padding: EdgeInsets.all(12),
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(svgSrc),
        ),
        Positioned(
          top: -1,
          right: 1,
          child: Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                )),
            child: Center(
              child: Text("$numOfItems",
                  style: TextStyle(
                      fontSize: 13,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        )
      ]),
    );
  }
}

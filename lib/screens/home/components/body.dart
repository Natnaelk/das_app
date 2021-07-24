import 'package:das_app/constants.dart';
import 'package:das_app/screens/home/components/Notification_icon_btn.dart';
import 'package:das_app/screens/home/components/home_header.dart';
import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/screens/home/components/trending_idir.dart';
import 'package:das_app/screens/home/components/trending_iqub.dart';
import 'package:das_app/screens/home/search_field.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(height: getProportionateScreenWidth(20)),
          // home header widget that have search field and notification icon button
          const HomeHeader(),
          SizedBox(height: getProportionateScreenWidth(30)),
          TrendingIqub(),
          SizedBox(height: getProportionateScreenWidth(30)),
          TrendingIdir(),
        ],
      ),
    ));
  }
}

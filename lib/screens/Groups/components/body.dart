import 'package:das_app/screens/groups/components/search_field.dart';
import 'package:das_app/screens/groups/components/tabbar.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: getProportionateScreenWidth(20),
      ),
      // SearchField(),
      SizedBox(
        height: getProportionateScreenWidth(10),
      ),
      //GroupScreenTabBar(),
    ]);
  }
}

import 'package:das_app/screens/home/components/Notification_icon_btn.dart';
import 'package:das_app/screens/home/components/notification_list.dart';
import 'package:das_app/screens/home/search_field.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // search filed widget
            IconButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                icon: Icon(Icons.search, color: Colors.orange, size: 25.0),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()));
                }),
            NotificationIconBtn(
              svgSrc: "assets/icons/Bell.svg",
              numOfItems: 3,
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationList()));
              },
            ),
          ],
        ));
  }
}

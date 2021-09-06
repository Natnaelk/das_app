import 'package:das_app/screens/home/search_field.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            // search filed widget
            const SizedBox(
              width: 120,
            ),
            const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              width: 70,
            ),
            IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                icon:
                    const Icon(Icons.search, color: Colors.orange, size: 25.0),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()));
                }),
            // NotificationIconBtn(
            //   svgSrc: "assets/icons/Bell.svg",
            //   numOfItems: 3,
            //   press: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => NotificationList()));
            //   },
            // ),
          ],
        ));
  }
}

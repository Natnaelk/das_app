import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/components/home_header.dart';
import 'package:das_app/screens/home/components/trending_idir.dart';
import 'package:das_app/screens/home/components/trending_iqub.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          var userDocument = snapshot.data;
          return SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                // Text("Hello ${groups.name}"),
                // home header widget that have search field and notification icon button
                const HomeHeader(),
                SizedBox(height: 20),
                Text(
                  "Welcome Back, ${userDocument['firstName'] ?? 'Loading...'}!",
                  style: const TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 20),
                TrendingIqub(),
                const SizedBox(height: 20),
                TrendingIdir(),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ));
        }
      },
    );
  }
}

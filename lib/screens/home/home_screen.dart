import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/components/custom_bottom_nav_bar.dart';
import 'package:das_app/enums.dart';
import 'package:das_app/models/iqub_model.dart';
import 'package:das_app/screens/home/components/body.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static var routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

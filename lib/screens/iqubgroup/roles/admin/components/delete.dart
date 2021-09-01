import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../iqub_drawer_navigation.dart';

class AdmindeletePage extends StatelessWidget {
  String iqubId;
  List members;
  AdmindeletePage({this.iqubId, this.members});

  void _deleteIqub(BuildContext context, String iqubId) async {
    await DatabaseService().deleteIqub(iqubId);
    if (iqubId.isNotEmpty) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("Iqub Deleted successfuly"),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("error"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 270,
            ),
            Text("Are you sure you want to delete this iqub?"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _deleteIqub(context, iqubId);
                  },
                  color: Colors.green,
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 40)),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => iqubAdminScreen(
                              iqub: iqubId,
                              members: members,
                            )));
                  },
                  color: Colors.red,
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ])
        ])));
  }
}

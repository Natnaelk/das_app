import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/idirgroup/roles/admin/idir_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../idir_drawer_navigation.dart';

class IdirAdmindeletePage extends StatelessWidget {
  String idirId;
  List members;
  IdirAdmindeletePage({this.idirId, this.members});

  void _deleteidir(BuildContext context, String idirId) async {
    await DatabaseService().deleteIdir(idirId);
    if (idirId.isNotEmpty) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text("idir Deleted successfuly"),
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
            Text("Are you sure you want to delete this idir?"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _deleteidir(context, idirId);
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
                        builder: (context) => idirAdminScreen(
                              idir: idirId,
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

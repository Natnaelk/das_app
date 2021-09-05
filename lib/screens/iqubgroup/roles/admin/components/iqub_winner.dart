import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../../../../constants.dart';

class IqubWinnerScreen extends StatelessWidget {
  String iqubid;
  List members;
  IqubWinnerScreen({this.iqubid, this.members});

  @override
  Widget build(BuildContext context) {
    int randomIndex = Random().nextInt(members.length);
    String winner = members[randomIndex];
    print(winner);
    //dynamic winner = (members..shuffle()).first ?? '';
    // int len = widget.members.length;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(winner)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              } else {
                var winner = snapshot.data;
                return Scaffold(
                    body: SingleChildScrollView(
                        child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 270,
                    ),
                    Center(child: Text("The winner of the iqub is")),
                    Center(
                      child: Text(winner['firstName'],
                          style: TextStyle(fontSize: 25, color: kPrimaryColor)),
                    )
                  ]),
                )));
              }
            }),
      ),
    );
  }
}

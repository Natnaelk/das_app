import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class IqubWinnerScreen extends StatefulWidget {
  //String iqubid;
  //List members;
  dynamic winner;

  IqubWinnerScreen(
      {

      // this.iqubid,

      // this.members,
      this.winner});

  @override
  _IqubWinnerScreenState createState() => _IqubWinnerScreenState();
}

class _IqubWinnerScreenState extends State<IqubWinnerScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    // int len = widget.members.length;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.winner)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
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
            }),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/iqub_winner.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../iqub_drawer_navigation.dart';

class DrawLot extends StatefulWidget {
  String iqubid;
  List members;

  DrawLot({this.iqubid, this.members});

  @override
  _DrawLotState createState() => _DrawLotState();
}

class _DrawLotState extends State<DrawLot> {
  @override
  Widget build(BuildContext context) {
    // int len = widget.members.length;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                // .where("iqubs", arrayContains: widget.iqubid)
                .where("paidList", arrayContains: widget.iqubid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return Scaffold(
                  drawer: IqubDrawer(
                    iqub: widget.iqubid,
                    members: widget.members,
                  ),
                  appBar: AppBar(
                    title: Text('Draw lot'),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(children: <Widget>[
                        Text("Allowed users for draw"),
                        Column(
                            children: snapshot.data.docs.map((document) {
                          return Column(children: <Widget>[
                            Card(
                                margin: EdgeInsets.fromLTRB(20, 6, 20, 0.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: kPrimaryColor,
                                      child: Text(
                                          document['firstName']
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style:
                                              TextStyle(color: Colors.white))),
                                  title: Text(
                                    document['firstName'],
                                  ),
                                  subtitle: Text(document['email']),
                                )),
                          ]);
                        }).toList()),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => IqubWinnerScreen(
                                            iqubid: widget.iqubid,
                                            members: widget.members,
                                          )));
                            },
                            color: kPrimaryColor,
                            child: Text(
                              "Draw Lot",
                            ))
                      ]),
                    ),
                  ));
            }),
      ),
    );
  }
}

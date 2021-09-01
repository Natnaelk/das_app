import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';
import '../iqub_member_drawer_navigation.dart';

class ViewMembersPage extends StatefulWidget {
  String iqubId;
  List members;
  ViewMembersPage({this.iqubId, this.members});

  @override
  State<ViewMembersPage> createState() => _ViewMembersPageState();
}

class _ViewMembersPageState extends State<ViewMembersPage> {
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
                    .collection("users")
                    .where("iqubs", arrayContains: widget.iqubId)
                    .orderBy('firstName')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('Loading...'));
                  }
                  return Scaffold(
                      drawer: IqubMemberDrawer(
                        iqub: widget.iqubId,
                        members: widget.members,
                      ),
                      appBar: AppBar(
                        title: Text('Members'),
                      ),
                      body: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Column(
                              children: snapshot.data.docs.map((document) {
                            return Column(children: <Widget>[
                              Card(
                                  margin: EdgeInsets.fromLTRB(20, 6, 20, 0.0),
                                  child: ListTile(
                                    // onLongPress: () {
                                    //   setState(() {
                                    //     showAlertDialog(
                                    //         context, widget.iqubid, document['uid']);
                                    //   });
                                    // },
                                    leading: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: kPrimaryColor,
                                        child: Text(
                                            document['firstName']
                                                .substring(0, 1)
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.white))),
                                    title: Text(
                                      document['firstName'],
                                    ),
                                    subtitle: Text(document['email']),
                                  )),
                            ]);
                          }).toList()),
                        ),
                      ));
                })));
  }
}

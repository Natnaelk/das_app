import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/add_member.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/delete.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class AdminmembersPage extends StatefulWidget {
  String iqubId;
  List members;
  AdminmembersPage({this.iqubId, this.members});

  @override
  State<AdminmembersPage> createState() => _AdminmembersPageState();
}

class _AdminmembersPageState extends State<AdminmembersPage> {
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
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return Scaffold(
                drawer: IqubDrawer(
                  iqub: widget.iqubId,
                  members: widget.members,
                ),
                appBar: AppBar(
                  title: Text('Members'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminAddMembersPage(
                                  iqubid: widget.iqubId,
                                  members: widget.members,
                                )));
                      },
                      icon: Icon(Icons.add),
                      color: kPrimaryColor,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdminDeleteMemberPage(
                                  iqubid: widget.iqubId,
                                  members: widget.members,
                                )));
                      },
                      icon: Icon(Icons.delete),
                      color: kPrimaryColor,
                    ),
                  ],
                ),
                body: ListView(
                  children: snapshot.data.docs.map((document) {
                    print(widget.iqubId);
                    return Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "user Name :",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            document['firstName'],
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            "email :",
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 40,
                            width: 40,
                          ),
                          Text(
                            document['email'],
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ]);
                  }).toList(),
                ),
              );
            }),
      ),
    );
  }
}

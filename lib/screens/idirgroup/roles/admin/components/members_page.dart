import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/add_member.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/delete_members.dart';
import 'package:das_app/screens/idirgroup/roles/admin/idir_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class IdirAdminmembersPage extends StatefulWidget {
  String idirId;
  List members;
  IdirAdminmembersPage({this.idirId, this.members});

  @override
  State<IdirAdminmembersPage> createState() => _IdirAdminmembersPageState();
}

class _IdirAdminmembersPageState extends State<IdirAdminmembersPage> {
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
                .where("idirs", arrayContains: widget.idirId)
                .orderBy('firstName')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              print(widget.idirId);
              return Scaffold(
                  drawer: idirDrawer(
                    idir: widget.idirId,
                    members: widget.members,
                  ),
                  appBar: AppBar(
                    title: Text('Members'),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdminAddMembersPage(
                                    idirid: widget.idirId,
                                    members: widget.members,
                                  )));
                        },
                        icon: Icon(Icons.add),
                        color: kPrimaryColor,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => IdirAdminDeleteMemberPage(
                                    idirid: widget.idirId,
                                    members: widget.members,
                                  )));
                        },
                        icon: Icon(Icons.delete),
                        color: kPrimaryColor,
                      ),
                    ],
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
                                //         context, widget.idirid, document['uid']);
                                //   });
                                // },
                                leading: CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: kPrimaryColor,
                                    child: Text(
                                        document['firstName']
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(color: Colors.white))),
                                title: Text(
                                  document['firstName'],
                                ),
                                subtitle: Text(document['email']),
                              )),
                        ]);
                      }).toList()),
                    ),
                  ));
            }),
      ),
    );
  }
}

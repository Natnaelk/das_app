import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/members_page.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constants.dart';

class AdminAddMembersPage extends StatefulWidget {
  String idirid;
  List members;
  AdminAddMembersPage({this.idirid, this.members});

  @override
  State<AdminAddMembersPage> createState() => _AdminAddMembersPageState();
}

class _AdminAddMembersPageState extends State<AdminAddMembersPage> {
  void _addUser(BuildContext context, String idirId, String userid) async {
    try {
      String returnString =
          await DatabaseService().addUserToIdir(idirId, userid);

      if (returnString == 'success') {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => IdirAdminmembersPage(
                  idirId: widget.idirid,
                  members: widget.members,
                )));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("User Added successfuly"),
          duration: Duration(seconds: 2),
        ));
      } else if (returnString == 'error') {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text('already in group'),
          duration: Duration(seconds: 2),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kPrimaryColor,
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;
    return Scaffold(
      body: StreamBuilder(
        stream: DatabaseService()
            .usersCollection
            .where('uid', isNotEqualTo: currentUid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('Loading...'));
          }
          List users = snapshot.data.docs;
          return Scaffold(
              appBar: AppBar(
                title: Text('App Users List'),
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
                            onTap: () {
                              setState(() {
                                showAlertDialog(
                                    context, widget.idirid, document['uid']);
                              });
                            },
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
        },
      ),
    );
  }

  showAlertDialog(BuildContext context, String idirid, String uid) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text("Cancel"),
    );

    Widget continueButton = TextButton(
        onPressed: () {
          _addUser(context, idirid, uid);
          Navigator.of(context).pop();
        },
        child: const Text("Continue"));

    AlertDialog alert = AlertDialog(
      title: const Text("Confirm to Add member"),
      content: const Text("Would you like to Add member to the group?"),
      actions: [cancelButton, continueButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

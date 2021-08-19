import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class AdminmembersPage extends StatelessWidget {
  String iqubId;

  AdminmembersPage({this.iqubId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("iqubs", arrayContains: iqubId)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text('Members'),
                ),
                body: ListView(
                  children: snapshot.data.docs.map((document) {
                    print(iqubId);
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

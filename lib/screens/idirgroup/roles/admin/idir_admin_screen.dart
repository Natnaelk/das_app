import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/idirgroup/roles/admin/idir_drawer_navigation.dart';
import 'package:flutter/material.dart';

class idirAdminScreen extends StatefulWidget {
  String idir;
  List members;
  idirAdminScreen({this.idir, this.members});

  @override
  State<idirAdminScreen> createState() => _idirAdminScreenState();
}

class _idirAdminScreenState extends State<idirAdminScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("idirs")
                .where("idirId", isEqualTo: widget.idir)
                .limit(1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                return Scaffold(
                  drawer: idirDrawer(
                    idir: widget.idir,
                    members: widget.members,
                  ),
                  appBar: AppBar(
                    title: const Text('Admin Page'),
                  ),
                  body: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data.docs.map((document) {
                      return Column(children: <Widget>[
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.asset('assets/images/insurancepic.jpg'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "idir Name :",
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
                              document['idirName'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                      ]);
                    }).toList(),
                  ),
                );
              }
            }),
      ),
    );
  }
}

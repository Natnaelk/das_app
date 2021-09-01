import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_drawer_navigation.dart';
import 'package:flutter/material.dart';

class iqubMemberScreen extends StatefulWidget {
  String iqub;
  List members;
  iqubMemberScreen({this.iqub, this.members});

  @override
  State<iqubMemberScreen> createState() => _iqubMemberScreenState();
}

class _iqubMemberScreenState extends State<iqubMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("iqubs")
                .where("iqubId", isEqualTo: widget.iqub)
                .limit(1)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                return Scaffold(
                  drawer: IqubMemberDrawer(
                    iqub: widget.iqub,
                    members: widget.members,
                  ),
                  appBar: AppBar(
                    title: const Text('Member Page'),
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
                              "Iqub Name :",
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
                              document['iqubName'],
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

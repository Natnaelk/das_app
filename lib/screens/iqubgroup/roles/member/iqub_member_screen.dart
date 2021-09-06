import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_drawer_navigation.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                      Timestamp t = document['startingDate'];
                      DateTime createdOn = t.toDate();
                      String formattedDateTime =
                          DateFormat('yyyy-MM-dd – kk:mm').format(createdOn);
                      var startedDate = createdOn.add(const Duration(days: 3));
                      String threeDaysAfter =
                          DateFormat('yyyy-MM-dd – kk:mm').format(startedDate);
                      var drawDate;
                      var membersLength = snapshot.data.docs.length;
                      var endDate;

                      if (document['Type'] == 'Weekly') {
                        drawDate = startedDate.add(const Duration(days: 7));
                        int value = membersLength * 7;
                        endDate = startedDate.add(Duration(days: value));
                        String weekly = DateFormat('yyyy-MM-dd – kk:mm')
                            .format(startedDate);
                      } else if (document['Type'] == 'Daily') {
                        drawDate = startedDate.add(const Duration(days: 1));
                        int value = membersLength * 1;
                        endDate = startedDate.add(Duration(days: value));
                        String daily = DateFormat('yyyy-MM-dd – kk:mm')
                            .format(startedDate);
                      } else {
                        String monthly = DateFormat('yyyy-MM-dd – kk:mm')
                            .format(startedDate);
                        int value = membersLength * 30;
                        endDate = startedDate.add(Duration(days: value));
                        drawDate = startedDate.add(const Duration(days: 30));
                      }

                      return Column(children: <Widget>[
                        SizedBox(
                          height: 200,
                          width: 200,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "Iqub Type :",
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
                              document['Type'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text(
                              "Pooled Amount :",
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
                              document['poolAmount'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "Created On:",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 40,
                              width: 10,
                            ),
                            Text(
                              formattedDateTime.toString(),
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "Starting Date:",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 40,
                              width: 10,
                            ),
                            Text(
                              threeDaysAfter.toString(),
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "Draw is On:",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 40,
                              width: 10,
                            ),
                            Text(
                              drawDate.toString(),
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            const Text(
                              "End Date:",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 40,
                              width: 10,
                            ),
                            Text(
                              endDate.toString(),
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

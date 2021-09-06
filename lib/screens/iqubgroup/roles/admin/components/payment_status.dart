import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_drawer_navigation.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class PaymentStatusPage extends StatefulWidget {
  String iqubId;
  List members;

  PaymentStatusPage({this.iqubId, this.members});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    // _paymentValueInGroup(currentUid, widget.iqubId);
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    // int len = widget.members.length;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("paidList", arrayContains: widget.iqubId)
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
                    title: Text('Paid List'),
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
                                          style:
                                              TextStyle(color: Colors.white))),
                                  title: Text(
                                    document['firstName'],
                                  ),
                                  subtitle: Text(document['email']),
                                  trailing: Text(
                                    'Paid',
                                    style: TextStyle(color: Colors.green),
                                  ))),
                        ]);
                      }).toList()),
                    ),
                  ));
            }),
      ),
    );
  }
}

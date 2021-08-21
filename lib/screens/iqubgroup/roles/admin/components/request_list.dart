import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/members_page.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class RequestList extends StatefulWidget {
  String senderId;
  String iqubId;
  String requestId;

  RequestList({Key key, this.senderId, this.iqubId, this.requestId})
      : super(key: key);

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  void _acceptMember(BuildContext context, String iqubId, String senderid,
      String status) async {
    try {
      await DatabaseService().joinIqub(iqubId, senderid, status);
      if (senderid.isNotEmpty && iqubId.isNotEmpty) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("Member Accepted successfuly"),
          duration: Duration(seconds: 2),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("error"),
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
    setState(() {
      setState(() {
        FirebaseFirestore.instance.collection('users');
      });
    });
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("uid", isEqualTo: widget.senderId)
                .where("iqubs", isNotEqualTo: widget.iqubId)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loadinggg...'));
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text('requests'),
                ),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data.docs.map((document) {
                    print(document['firstName']);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              _acceptMember(context, widget.iqubId,
                                  widget.senderId, widget.requestId);
                            },
                            color: Colors.green,
                            child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 40)),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.red,
                            child: Text(
                              'Reject',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ]);
                  }).toList(),
                ),
              );
            }),
      ),
    );
  }
}

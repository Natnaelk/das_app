import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/request_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../iqub_drawer_navigation.dart';

class AdminrequestsPage extends StatefulWidget {
  String iqubId;
  List members;
  AdminrequestsPage({this.iqubId, this.members});

  @override
  State<AdminrequestsPage> createState() => _AdminrequestsPageState();
}

class _AdminrequestsPageState extends State<AdminrequestsPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    AuthModel _authStream = Provider.of<AuthModel>(context);

    String currentUid = _authStream.uid;
    return Scaffold(
      drawer: IqubDrawer(
        iqub: widget.iqubId,
        members: widget.members,
      ),
      appBar: AppBar(
        title: Text('requests'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("requests")
              .where("receiver", arrayContains: currentUid)
              .where("iqubId", isEqualTo: widget.iqubId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }

            return Card(
              child: ListView(
                  children: snapshot.data.docs.map((document) {
                return InkWell(
                  child: Center(
                    widthFactor: 23,
                    heightFactor: 5,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            document['senderName'] ?? '',
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "sent you a request",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RequestList(
                                  senderId: document['senderId'] ?? '',
                                  iqubId: document['iqubId'] ?? '',
                                  requestId: document['requestId'] ?? '',
                                )));
                  },
                );
              }).toList()),
            );
          }),
    );
  }
}

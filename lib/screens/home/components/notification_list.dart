import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/components/default_button.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("requests")
              .where("receiver", arrayContains: currentUid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading...'));
            }
            return Row(
              children: snapshot.data.docs.map((document) {
                return Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          document['iqubName'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          document['sender'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        DefaultButton(
                          text: 'Accept',
                          press: () {},
                        ),
                        DefaultButton(
                          text: 'Reject',
                          press: () {},
                        )
                      ]),
                );
              }).toList(),
            );
          }),
    );
  }
}

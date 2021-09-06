import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/payment_list.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/payment_status.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/components/request_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../iqub_drawer_navigation.dart';

class AdminpaymentPage extends StatefulWidget {
  String iqubId;
  List members;
  AdminpaymentPage({this.iqubId, this.members});

  @override
  State<AdminpaymentPage> createState() => _AdminpaymentPageState();
}

class _AdminpaymentPageState extends State<AdminpaymentPage> {
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
        title: Text('payment'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PaymentStatusPage(
                        iqubId: widget.iqubId,
                        members: widget.members,
                      )));
            },
            icon: Icon(Icons.signal_wifi_statusbar_null_rounded),
            color: kPrimaryColor,
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("payment")
              .where("receiver", isEqualTo: currentUid)
              .where("iqubId", isEqualTo: widget.iqubId)
              .where("accepted", isEqualTo: 0)
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
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "sent you a proof of payment",
                            style: TextStyle(color: Colors.blue, fontSize: 18),
                          ),
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaymentList(
                                  senderId: document['senderId'] ?? '',
                                  iqubId: document['iqubId'] ?? '',
                                  paymentId: document['paymentId'] ?? '',
                                  imageUrl: document['image'] ?? '',
                                )));
                  },
                );
              }).toList()),
            );
          }),
    );
  }
}

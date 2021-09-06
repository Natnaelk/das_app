import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/idir_payment_status.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/payment_list.dart';
import 'package:das_app/screens/idirgroup/roles/admin/components/request_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../idir_drawer_navigation.dart';

class IdirAdminpaymentPage extends StatefulWidget {
  String idirId;
  List members;
  IdirAdminpaymentPage({this.idirId, this.members});

  @override
  State<IdirAdminpaymentPage> createState() => _IdirAdminpaymentPageState();
}

class _IdirAdminpaymentPageState extends State<IdirAdminpaymentPage> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      FirebaseFirestore.instance.collection('users');
    });
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return Scaffold(
      drawer: idirDrawer(
        idir: widget.idirId,
        members: widget.members,
      ),
      appBar: AppBar(
        title: Text('payment'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => IdirPaymentStatusPage(
                        idirId: widget.idirId,
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
              .where("idirId", isEqualTo: widget.idirId)
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
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "sent you a proof of payment",
                            style: TextStyle(color: Colors.blue, fontSize: 20),
                          ),
                        ]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IdirPaymentList(
                                  senderId: document['senderId'] ?? '',
                                  idirId: document['idirId'] ?? '',
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

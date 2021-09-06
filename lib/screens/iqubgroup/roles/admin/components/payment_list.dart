import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../../constants.dart';

class PaymentList extends StatefulWidget {
  String senderId;
  String iqubId;
  String paymentId;
  String imageUrl;

  PaymentList(
      {Key key, this.senderId, this.iqubId, this.paymentId, this.imageUrl})
      : super(key: key);

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  void _acceptPayment(BuildContext context, String paymentId) async {
    try {
      await DatabaseService().acceptPayment(paymentId);
      if (paymentId != null) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("payment accepted successfully"),
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

  void _addToPaidList(
      BuildContext context, String iqubId, String senderId, paymentId) async {
    try {
      await DatabaseService().addToPaidList(senderId, paymentId, iqubId);
      if (senderId != null) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("payment accepted successfully"),
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

  void _rejectPayment(BuildContext context, String paymentId) async {
    try {
      await DatabaseService().rejectPayment(paymentId);
      if (paymentId != null) {
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: kPrimaryColor,
          content: Text("payment rejected successfully"),
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
                  title: Text('proof of payment'),
                ),
                body: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: snapshot.data.docs.map((document) {
                    return Column(children: <Widget>[
                      SizedBox(
                          height: 300,
                          width: 300,
                          child: PhotoView(
                            imageProvider:
                                NetworkImage(widget.imageUrl, scale: 1.0),
                            loadingBuilder: (BuildContext context, event) {
                              return Center(child: CircularProgressIndicator());
                            },
                          )),
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
                              _acceptPayment(context, widget.paymentId);
                              _addToPaidList(context, widget.iqubId,
                                  widget.senderId, widget.paymentId);
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
                              _rejectPayment(context, widget.paymentId);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class iqubDetailsScreen extends StatefulWidget {
  String iqubid;
  String uid;
  iqubDetailsScreen({this.iqubid, this.uid});

  @override
  State<iqubDetailsScreen> createState() => _iqubDetailsScreenState();
}

class _iqubDetailsScreenState extends State<iqubDetailsScreen> {
  bool _isJoined = false;
  _joinValueInGroup(uid, iqubId) async {
    bool value = await DatabaseService(uid: uid).isUserJoined(iqubId, uid);
    setState(() {
      _isJoined = value;
    });
  }

  @override
  void initState() {
    _joinValueInGroup(widget.uid, widget.iqubid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;

    void _requestjoinIqub(BuildContext context, String groupId) async {
      try {
        await DatabaseService().requestjoinIqub(
          groupId,
          currentUid,
        );
        if (currentUid.isNotEmpty) {
          Navigator.pushNamed(context, HomeScreen.routeName);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: kPrimaryColor,
            content: Text("request sent successfuly"),
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

    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("iqubs")
                .where("iqubId", isEqualTo: widget.iqubid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data.docs.map((document) {
                        return Column(children: <Widget>[
                          SizedBox(
                            height: 300,
                            width: 300,
                            child:
                                Image.asset('assets/images/insurancepic.jpg'),
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
                          if (_isJoined)
                            Center(
                                child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => iqubMemberScreen(
                                          iqub: widget.iqubid,
                                        )));
                              },
                              color: Colors.black87,
                              height: 40,
                              minWidth: 80,
                              child: const Text(
                                'Joined',
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                          else
                            Center(
                              child: FlatButton(
                                onPressed: () {
                                  _requestjoinIqub(context, widget.iqubid);
                                },
                                color: kPrimaryColor,
                                height: 40,
                                minWidth: 80,
                                child: Text(
                                  'Join Iqub',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}

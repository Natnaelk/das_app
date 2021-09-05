import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class idirDetailsScreen extends StatefulWidget {
  String idirid;
  String uid;
  idirDetailsScreen({this.idirid, this.uid});

  @override
  State<idirDetailsScreen> createState() => _idirDetailsScreenState();
}

class _idirDetailsScreenState extends State<idirDetailsScreen> {
  bool _isJoined = false;
  _joinValueInGroup(uid, idirId) async {
    bool value = await DatabaseService(uid: uid).isUserJoinedIdir(idirId, uid);
    setState(() {
      _isJoined = value;
    });
  }

  @override
  void initState() {
    _joinValueInGroup(widget.uid, widget.idirid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
    String currentUid = _authStream.uid;

    void _requestjoinidir(BuildContext context, String groupId) async {
      try {
        await DatabaseService().requestjoinIdir(
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
                .collection("idirs")
                .where("idirId", isEqualTo: widget.idirid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                return Scaffold(
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
                              "idir Name :",
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
                              document['idirName'],
                              style: const TextStyle(),
                            ),
                          ],
                        ),
                        if (_isJoined)
                          Center(
                              child: FlatButton(
                            onPressed: () {
                              _requestjoinidir(context, widget.idirid);
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
                                _requestjoinidir(context, widget.idirid);
                              },
                              color: kPrimaryColor,
                              height: 40,
                              minWidth: 80,
                              child: const Text(
                                'Join idir',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
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

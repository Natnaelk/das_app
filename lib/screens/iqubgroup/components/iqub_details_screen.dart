import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class iqubDetailsScreen extends StatelessWidget {
  String iqubid;
  iqubDetailsScreen({this.iqubid});

  @override
  Widget build(BuildContext context) {
    void _requestjoinIqub(BuildContext context, String groupId) async {
      try {
        AuthModel _authStream = Provider.of<AuthModel>(context, listen: false);
        String currentUid = _authStream.uid;
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

    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return Scaffold(
      body: Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("iqubs")
                .where("iqubId", isEqualTo: iqubid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading...');
              } else {
                print(iqubid);
                print(currentUid);
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
                        FlatButton(
                          onPressed: () {
                            _requestjoinIqub(context, iqubid);
                          },
                          color: kPrimaryColor,
                          height: 40,
                          minWidth: 80,
                          child: Text(
                            'Join Iqub',
                            style: TextStyle(color: Colors.white),
                          ),
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

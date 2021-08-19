import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/iqubgroup/roles/member/iqub_member_screen.dart';
import 'package:das_app/services/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinedIdir extends StatefulWidget {
  const JoinedIdir({
    Key key,
  }) : super(key: key);

  @override
  State<JoinedIdir> createState() => _JoinedIdirState();
}

class _JoinedIdirState extends State<JoinedIdir> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return StreamBuilder(
        stream: DatabaseService()
            .idirsCollection
            .where("members", arrayContains: currentUid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //var iqub = snapshot.data;
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => iqubMemberScreen()));
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data.docs.map((document) {
                  return Center(
                    child: JoinedIqubsCard(
                      IqubName: document['idirName'],
                      IqubProPic: 'assets/images/insurancepic.jpg',
                      IqubType: 'Monthly',
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}

class JoinedIqubsCard extends StatelessWidget {
  const JoinedIqubsCard({
    Key key,
    @required this.IqubName,
    @required this.PooledMoneyAmount,
    @required this.IqubType,
    @required this.press,
    @required this.IqubProPic,
  }) : super(key: key);
  final String IqubName;
  final String IqubProPic;
  final int PooledMoneyAmount;
  final String IqubType;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: (20)),
      child: SizedBox(
        width: (120),
        height: (120),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  IqubProPic,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: (15), vertical: (10)),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "$IqubName\n",
                          style: const TextStyle(
                            fontSize: (18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$IqubType $PooledMoneyAmount birr",
                            style: const TextStyle(
                              fontSize: (16),
                              fontWeight: FontWeight.bold,
                            ))
                      ])),
                )
              ],
            )),
      ),
    );
  }
}

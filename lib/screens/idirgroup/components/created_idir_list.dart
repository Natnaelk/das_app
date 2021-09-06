import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/idirgroup/roles/admin/idir_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatedIdir extends StatefulWidget {
  @override
  State<CreatedIdir> createState() => _CreatedIdirState();
}

class _CreatedIdirState extends State<CreatedIdir> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    return StreamBuilder(
        stream: DatabaseService()
            .idirsCollection
            .where("admin", isEqualTo: currentUid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //var Idir = snapshot.data;
          // final Idir = snapshot.data.docs;
          if (!snapshot.hasData) {
            return const Text('Loading...');
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data.docs.map((document) {
                  return InkWell(
                      child: Center(
                        child: CreatedIdirsCard(
                          IdirName: document['idirName'],
                          IdirProPic: 'assets/images/insurancepic.jpg',
                          IdirType: 'Monthly',
                          PooledMoneyAmount: document['poolAmount'],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => idirAdminScreen(
                                      idir: document['idirId'],
                                      members: document['members'],
                                    )));
                      });
                }).toList(),
              ),
            );
          }
        });
  }
}

class CreatedIdirsCard extends StatelessWidget {
  const CreatedIdirsCard({
    Key key,
    @required this.IdirName,
    @required this.PooledMoneyAmount,
    @required this.IdirType,
    @required this.press,
    @required this.IdirProPic,
  }) : super(key: key);
  final String IdirName;
  final String IdirProPic;
  final String PooledMoneyAmount;
  final String IdirType;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: (20)),
      child: SizedBox(
        width: (120),
        height: (120),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  IdirProPic,
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
                          text: "$IdirName\n",
                          style: const TextStyle(
                            fontSize: (18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$IdirType $PooledMoneyAmount birr",
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

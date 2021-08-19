import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/screens/idirgroup/roles/idir_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingIdir extends StatefulWidget {
  const TrendingIdir({
    Key key,
  }) : super(key: key);

  @override
  State<TrendingIdir> createState() => _TrendingIdirState();
}

class _TrendingIdirState extends State<TrendingIdir> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    String currentName = '';
    return StreamBuilder(
        stream: DatabaseService()
            .idirsCollection
            .where('idirName', isNotEqualTo: currentName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //var Idir = snapshot.data;
          // final Idir = snapshot.data.docs;
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return Column(children: <Widget>[
            SectionTitle(
              text: "Trending idirs",
              press: () {},
            ),
            SizedBox(height: 20),
            InkWell(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data.docs.map((document) {
                    return Center(
                        child: TrendingIdirsCard(
                      idirName: document['idirName'],
                      idirProPic: 'assets/images/insurancepic.jpg',
                      idirType: 'Monthly',
                    ));
                  }).toList(),
                ),
              ),
              onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           //builder: (context) => idirAdminScreen(),
                //           ));
              },
            )
          ]);
        });
  }
}

class TrendingIdirsCard extends StatelessWidget {
  const TrendingIdirsCard({
    Key key,
    @required this.idirName,
    @required this.pooledMoneyAmount,
    @required this.idirType,
    @required this.press,
    @required this.idirProPic,
  }) : super(key: key);
  final String idirName;
  final String idirProPic;
  final int pooledMoneyAmount;
  final String idirType;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  idirProPic,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "$idirName\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$idirType $pooledMoneyAmount birr",
                            style: TextStyle(
                              fontSize: 16,
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

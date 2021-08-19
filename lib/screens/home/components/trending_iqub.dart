import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_admin_screen.dart';
import 'package:das_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingIqub extends StatefulWidget {
  const TrendingIqub({
    Key key,
  }) : super(key: key);

  @override
  State<TrendingIqub> createState() => _TrendingIqubState();
}

class _TrendingIqubState extends State<TrendingIqub> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    String currentUid = _authStream.uid;
    String currentName = '';
    return StreamBuilder(
        stream: DatabaseService()
            .iqubsCollection
            .where('iqubName', isNotEqualTo: currentName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //var iqub = snapshot.data;
          // final iqub = snapshot.data.docs;
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return Column(children: <Widget>[
            SectionTitle(
              text: "Trending iqubs",
              press: () {},
            ),
            SizedBox(height: 20),
            InkWell(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: snapshot.data.docs.map((document) {
                    return Center(
                        child: TrendingiqubsCard(
                      iqubName: document['iqubName'],
                      iqubProPic: 'assets/images/insurancepic.jpg',
                      iqubType: 'Monthly',
                    ));
                  }).toList(),
                ),
              ),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         // builder: (context) => iqubAdminScreen(),
                //         ));
              },
            )
          ]);
        });
  }
}

class TrendingiqubsCard extends StatelessWidget {
  const TrendingiqubsCard({
    Key key,
    @required this.iqubName,
    @required this.pooledMoneyAmount,
    @required this.iqubType,
    @required this.press,
    @required this.iqubProPic,
  }) : super(key: key);
  final String iqubName;
  final String iqubProPic;
  final int pooledMoneyAmount;
  final String iqubType;
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
                  iqubProPic,
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
                          text: "$iqubName\n",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$iqubType $pooledMoneyAmount birr",
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

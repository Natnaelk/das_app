import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/screens/iqubgroup/components/iqub_details_screen.dart';
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
    return StreamBuilder(
        stream: DatabaseService()
            .iqubsCollection
            .where('admin', isNotEqualTo: currentUid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Loading...');
          }
          return Column(children: <Widget>[
            SectionTitle(
              text: "Trending iqubs",
              press: () {},
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data.docs.map((document) {
                  return InkWell(
                      child: Center(
                          child: TrendingiqubsCard(
                        iqubName: document['iqubName'],
                        iqubProPic: 'assets/images/insurancepic.jpg',
                        iqubType: document['Type'],
                        pooledMoneyAmount: document['poolAmount'],
                      )),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => iqubDetailsScreen(
                                iqubid: document['iqubId'],
                                uid: currentUid,
                              ),
                            ));
                      });
                }).toList(),
              ),
            ),
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
  final String pooledMoneyAmount;
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

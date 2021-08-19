import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:das_app/models/auth_model.dart';
import 'package:das_app/models/iqub_model.dart';
import 'package:das_app/screens/iqubgroup/roles/admin/iqub_admin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatedIqub extends StatefulWidget {
  const CreatedIqub({
    Key key,
  }) : super(key: key);

  @override
  State<CreatedIqub> createState() => _CreatedIqubState();
}

class _CreatedIqubState extends State<CreatedIqub> {
  @override
  Widget build(BuildContext context) {
    AuthModel _authStream = Provider.of<AuthModel>(context);
    // final iqubs = Provider.of<List<IqubModel>>(context);
    String currentUid = _authStream.uid ?? '';
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("iqubs")
            .where("admin", isEqualTo: currentUid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading...');
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: snapshot.data.docs.map((document) {
                  return InkWell(
                    child: Center(
                      child: CreatedIqubsCard(
                        IqubName: document['iqubName'],
                        IqubProPic: 'assets/images/insurancepic.jpg',
                        IqubType: 'Monthly',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => iqubAdminScreen(
                                    iqub: document['iqubId'],
                                  )));
                    },
                  );
                }).toList(),
              ),
            );
          }
        });
  }
}

class CreatedIqubsCard extends StatelessWidget {
  const CreatedIqubsCard({
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
      padding: EdgeInsets.only(left: (20)),
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
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
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

import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class CreatedIqub extends StatelessWidget {
  const CreatedIqub({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
          CreatedIqubsCard(
            IqubName: "yesetoch meredaja",
            IqubProPic: 'assets/images/savingimage.jpg',
            IqubType: "Daily",
            PooledMoneyAmount: 100,
          ),
          CreatedIqubsCard(
            IqubName: "Wereda 8",
            IqubProPic: 'assets/images/insurancepic.jpg',
            IqubType: "Yesetoch",
            PooledMoneyAmount: 1000,
          ),
          CreatedIqubsCard(
            IqubName: "Mercato Wetatoch",
            IqubProPic: 'assets/images/savingimage.jpg',
            IqubType: "yewendoch",
            PooledMoneyAmount: 100,
          ),
          CreatedIqubsCard(
            IqubName: "hawassa 4th year",
            IqubProPic: 'assets/images/insurancepic.jpg',
            IqubType: "yesetoch",
            PooledMoneyAmount: 1000,
          ),
        ]),
      ),
    ]);
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
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(150),
        height: getProportionateScreenWidth(150),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                      vertical: getProportionateScreenWidth(10)),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "$IqubName\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$IqubType $PooledMoneyAmount birr",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
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

import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/screens/home/components/trending_idir.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class TrendingIqub extends StatelessWidget {
  const TrendingIqub({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SectionTitle(
        text: "Trending Iqubs",
        press: () {},
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
          TrendingIqubsCard(
            iqubName: "Mercato Wetatoch",
            iqubProPic: 'assets/images/savingimage.jpg',
            iqubType: "Daily",
            PooledMoneyAmount: 100,
          ),
          TrendingIqubsCard(
            iqubName: "hawassa 4th year",
            iqubProPic: 'assets/images/insurancepic.jpg',
            iqubType: "Monthly",
            PooledMoneyAmount: 1000,
          ),
          TrendingIqubsCard(
            iqubName: "Mercato Wetatoch",
            iqubProPic: 'assets/images/savingimage.jpg',
            iqubType: "Daily",
            PooledMoneyAmount: 100,
          ),
          TrendingIqubsCard(
            iqubName: "hawassa 4th year",
            iqubProPic: 'assets/images/insurancepic.jpg',
            iqubType: "Monthly",
            PooledMoneyAmount: 1000,
          ),
        ]),
      ),
    ]);
  }
}

class TrendingIqubsCard extends StatelessWidget {
  const TrendingIqubsCard({
    Key key,
    @required this.iqubName,
    @required this.PooledMoneyAmount,
    @required this.iqubType,
    @required this.press,
    @required this.iqubProPic,
  }) : super(key: key);
  final String iqubName;
  final String iqubProPic;
  final int PooledMoneyAmount;
  final String iqubType;
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                      vertical: getProportionateScreenWidth(10)),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "$iqubName\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$iqubType $PooledMoneyAmount birr",
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

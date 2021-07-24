import 'package:das_app/screens/home/components/section_title.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';

class TrendingIdir extends StatelessWidget {
  const TrendingIdir({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SectionTitle(
        text: "Trending Idirs",
        press: () {},
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: <Widget>[
          TrendingIdirsCard(
            idirName: "yesetoch meredaja",
            idirProPic: 'assets/images/savingimage.jpg',
            idirType: "Daily",
            PooledMoneyAmount: 100,
          ),
          TrendingIdirsCard(
            idirName: "Wereda 8",
            idirProPic: 'assets/images/insurancepic.jpg',
            idirType: "Yesetoch",
            PooledMoneyAmount: 1000,
          ),
          TrendingIdirsCard(
            idirName: "Mercato Wetatoch",
            idirProPic: 'assets/images/savingimage.jpg',
            idirType: "yewendoch",
            PooledMoneyAmount: 100,
          ),
          TrendingIdirsCard(
            idirName: "hawassa 4th year",
            idirProPic: 'assets/images/insurancepic.jpg',
            idirType: "yesetoch",
            PooledMoneyAmount: 1000,
          ),
        ]),
      ),
    ]);
  }
}

class TrendingIdirsCard extends StatelessWidget {
  const TrendingIdirsCard({
    Key key,
    @required this.idirName,
    @required this.PooledMoneyAmount,
    @required this.idirType,
    @required this.press,
    @required this.idirProPic,
  }) : super(key: key);
  final String idirName;
  final String idirProPic;
  final int PooledMoneyAmount;
  final String idirType;
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
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                      vertical: getProportionateScreenWidth(10)),
                  child: Text.rich(TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "$idirName\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                            text: "$idirType $PooledMoneyAmount birr",
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

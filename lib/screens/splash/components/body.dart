import 'package:das_app/components/default_button.dart';
import 'package:flutter/material.dart';
import '../components/splash_content.dart';
import 'package:das_app/constants.dart';
import 'package:das_app/screens/Sign_in/sign_in_screen.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Das , Let's get started!",
      "image": "assets/images/Das_logo.jpg"
    },
    {
      "text":
          "We help people's saving get higher by modernizing the traditional Iqub",
      "image": "assets/images/dasAppSplashScreen.jpg"
    },
    {
      "text":
          "We help people get insurances by modernizing the traditional Idir",
      "image": "assets/images/dasAppSplashScreen1.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: double.infinity,
          child: Column(children: <Widget>[
            const Spacer(),
            Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      text: splashData[index]["text"]),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          splashData.length, (index) => buildDot(index: index)),
                    ),
                    const Spacer(flex: 2),
                    DefaultButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ])),
            ),
          ])),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
      duration: kAnimationDuration,
    );
  }
}

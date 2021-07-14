import 'package:das_app/constants.dart';
import 'package:das_app/size_config.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // ignore: prefer_const_literals_to_create_immutables
              child: Column(children: <Widget>[
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "sign in with your phone number and password",
                  textAlign: TextAlign.center,
                ),
                const SignForm(),
              ]),
            )));
  }
}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                labelText: "Phone",
                hintText: "Enter your phone no",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(20),
                      getProportionateScreenWidth(20)),
                  child: const Icon(Icons.phone),
                ))),
        TextFormField(
            decoration: const InputDecoration(
          labelText: "Password",
          hintText: "Enter your Password",

          floatingLabelBehavior: FloatingLabelBehavior.always,
          // suffixIcon: SvgPicture.asset("assets/icons/call.svg"
        ))
      ],
    ));
  }
}

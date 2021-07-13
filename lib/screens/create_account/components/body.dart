// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Body extends StatelessWidget{
  Widget build(BuildContext context){
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Text(
              "Welcome Back",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            ),
            const Text("sign in with your phone number and pin code",
               textAlign: TextAlign.center,
            )

          ]
        )
      )
    );
  }
}

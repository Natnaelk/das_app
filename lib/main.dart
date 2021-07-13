import 'package:flutter/material.dart';
import '../screens/splash/splash_screen.dart';
import '../routes.dart';
import 'package:das_app/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
     initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}


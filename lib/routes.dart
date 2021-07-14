import 'package:flutter/widgets.dart';
import '../screens/splash/splash_screen.dart';
import 'package:das_app/screens/Sign_in/sign_in_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
};

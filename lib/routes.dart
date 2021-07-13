import 'package:flutter/widgets.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/create_account/create_account_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
};

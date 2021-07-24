import 'package:das_app/screens/Groups/groups_screen.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/otp/otp_screen.dart';
import 'package:das_app/screens/login_success/login_success_screen.dart';
import 'package:das_app/screens/profile/profile_screen.dart';
import 'package:flutter/widgets.dart';
import '../screens/splash/splash_screen.dart';
import 'package:das_app/screens/Sign_in/sign_in_screen.dart';
import 'package:das_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:das_app/screens/create_account/create_account_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  GroupsScreen.routeName: (context) => GroupsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};

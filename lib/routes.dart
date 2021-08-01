import 'package:das_app/screens/Groups/groups_screen.dart';
import 'package:das_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/otp/otp_screen.dart';
import 'package:das_app/screens/login_success/login_success_screen.dart';
import 'package:das_app/screens/profile/profile_screen.dart';
import 'package:flutter/widgets.dart';
import '../screens/splash/splash_screen.dart';
import 'package:das_app/screens/Sign_in/sign_in_screen.dart';
import 'package:das_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:das_app/screens/create_account/create_account_screen.dart';

import 'screens/idirgroup/components/create_idir_form.dart';
import 'screens/idirgroup/idir_screen.dart';
import 'screens/iqubgroup/components/create_iqub_form.dart';
import 'screens/iqubgroup/iqub_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  CreateAccountScreen.routeName: (context) => const CreateAccountScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  GroupsScreen.routeName: (context) => GroupsScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  IqubScreen.routeName: (context) => IqubScreen(),
  IdirScreen.routeName: (context) => IdirScreen(),
  CreateIqubForm.routeName: (context) => CreateIqubForm(),
  CreateIdirForm.routeName: (context) => CreateIdirForm(),
};

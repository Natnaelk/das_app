import 'package:das_app/models/auth_model.dart';
import 'package:das_app/models/user_model.dart';
import 'package:das_app/screens/home/home_screen.dart';
import 'package:das_app/screens/sign_in/sign_in_screen.dart';
import 'package:das_app/screens/splash/splash_screen.dart';
import 'package:das_app/services/db_stream.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  LoggedIn,
  notLoggedIn,
}

class Root extends StatefulWidget {
  const Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  String currentuid;
  AuthStatus _authStatus = AuthStatus.unknown;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    AuthModel _authStream = Provider.of<AuthModel>(context, listen: true);

    if (_authStream != null) {
      setState(() {
        _authStatus = AuthStatus.LoggedIn;
        currentuid = _authStream.uid;
      });
    } else if (_authStream.uid == null) {
      setState(() {
        _authStatus = AuthStatus.unknown;
      });
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = SplashScreen();
        break;
      case AuthStatus.LoggedIn:
        retVal = HomeScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = SignInScreen();
        break;
      default:
    }
    return retVal;
  }
}

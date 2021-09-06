import 'package:das_app/models/auth_model.dart';
import 'package:das_app/screens/root/root.dart';
import 'package:das_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes.dart';
import 'package:das_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel>.value(
      value: Auth().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Das App',
        theme: theme(),
        home: Root(),
        // initialRoute: Root();
        routes: routes,
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/splash/splash_screen.dart';
import '../routes.dart';
import 'package:das_app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Das App',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           Provider<AuthService>(
//             create: (_) => AuthService(FirebaseAuth.instance),
//           ),
//           StreamProvider(
//             create: (context) => context.read<AuthService>().authStateChanges,
//           ),
//         ],
//         child: MaterialApp(
//           title: 'Das App',
//           theme: theme(),
//           initialRoute: SplashScreen.routeName,
//           routes: routes,
//         ));
//   }
// }

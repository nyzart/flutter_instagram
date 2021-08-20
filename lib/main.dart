import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Requests/authentication_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Views/homepage.dart';
import 'Views/login.dart';
import 'Classes/pageContent.dart';
import 'Classes/user.dart';
import 'dart:async';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
            initialData: null,
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
        ChangeNotifierProvider<UserData>.value(value: UserData()),
        ChangeNotifierProvider<PageContent>.value(value: PageContent())
      ],
      child: MaterialApp(
        title: 'Flutter Instagram',
        theme: new ThemeData(canvasColor: Colors.black),
        home: AuthenticationWrapper(),
      ),
    ),
  );
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return Homepage();
    } else {
      return LoginPage();
    }
  }
}

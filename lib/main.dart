// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:on_spot_mechanic/firebase_options.dart';
import 'package:on_spot_mechanic/pages/welcome.dart';
import 'package:on_spot_mechanic/providers/auth_service.dart';

import 'pages/profile_selection_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUserLoggedIn(),
    );
  }
}

class CheckUserLoggedIn extends StatefulWidget {
  const CheckUserLoggedIn({super.key});

  @override
  State<CheckUserLoggedIn> createState() => _CheckUserLoggedInState();
}

class _CheckUserLoggedInState extends State<CheckUserLoggedIn> {
  @override
  void initState() {
    super.initState();

    AuthService.isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProfileSelectionPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

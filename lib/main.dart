import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';

Future<void> main() async {
  //firebase initializing
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //start the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primary end secondary colors
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      //first screen
      home: WelcomeScreen(),
    );
  }
}

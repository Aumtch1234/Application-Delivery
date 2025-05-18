import 'package:delivery/Login-register/RegisterScreen.dart';
import 'package:delivery/Login-register/WellcomeScreen.dart';
import 'package:delivery/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return // main.dart
    MaterialApp(
      title: 'CSC FOOD',
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => WellcomeScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/home':
            final user = settings.arguments as GoogleSignInAccount;
            return MaterialPageRoute(builder: (_) => Homescreen(user: user));
          default:
            return MaterialPageRoute(
              builder:
                  (_) => const Scaffold(
                    body: Center(child: Text('Page not found')),
                  ),
            );
        }
      },
    );
  }
}

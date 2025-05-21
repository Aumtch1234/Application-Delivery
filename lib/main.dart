import 'package:delivery/Login-register/RegisterScreen.dart';
import 'package:delivery/Login-register/WellcomeScreen.dart';
import 'package:delivery/Login-register/HomeScreen.dart';
import 'package:delivery/SplashScreens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'CSC FOOD',
  initialRoute: '/',
  routes: {
    '/': (context) => const SplashScreen(),
    '/wellcome': (context) =>  WellcomeScreen(),
    '/register': (context) => const RegisterScreen(),
  },
  onGenerateRoute: (settings) {
    if (settings.name == '/home') {
      final user = settings.arguments as GoogleSignInAccount;
      return MaterialPageRoute(
        builder: (_) => Homescreen(user: user),
      );
    }

    // fallback
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Page not found')),
      ),
    );
  },
);

  }
}
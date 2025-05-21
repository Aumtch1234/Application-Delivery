import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
  await Future.delayed(const Duration(seconds: 3));

  GoogleSignInAccount? user = await _googleSignIn.signInSilently();

  if (mounted) {
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    } else {
      Navigator.pushReplacementNamed(context, '/wellcome');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    const String motorbike = 'assets/svg/motorcycle.svg';

    return Scaffold(
      backgroundColor: const Color(0xFF34C759),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              motorbike,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 30),
            Text(
              'CSC FOOD',
              style: GoogleFonts.prompt(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'for you',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 200),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 10),
            const Text(
              'กำลังโหลด ...',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

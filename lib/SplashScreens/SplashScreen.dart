import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/wellcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    const String motorbike = 'assets/svg/motorcycle.svg'; // เปลี่ยนเป็นชื่อไฟล์ SVG ของคุณ

    return Scaffold(
      backgroundColor: const Color(0xFF34C759), // สีพื้นหลังเขียวสด
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SVG Icon
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
            // ข้อความด้านล่าง
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

            CircularProgressIndicator(
              backgroundColor: Color(0xFF34C759),
              color: Colors.white,
            ),

            const SizedBox(height: 10),
            const Text(
              'กำลังโหลด ...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:delivery/HomeScreen.dart';
import 'package:delivery/Login-register/RegisterScreen.dart';
import 'package:delivery/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WellcomeScreen extends StatelessWidget {
   WellcomeScreen({super.key});
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลัง
          SizedBox.expand(
            child: Image.asset(
              'assets/png/login-background.png',
              fit: BoxFit.cover,
            ),
          ),
          // ชั้นสีทับเพื่อให้อ่านง่าย
          Container(color: Colors.black.withOpacity(0.3)),
          // เนื้อหา
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: const TextSpan(
                        text: 'การสั่งอาหารจะเป็นเรื่องง่ายดาย\nเพราะ',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'เราใส่ใจ',
                            style: TextStyle(
                              color: Color(0xFF34C759),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: ' เพื่อคุณทุกคน กับ\nCSC FOOD',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                Column(
                  children: [
                    Text(
                      'CSC FOOD',
                      style: GoogleFonts.prompt(
                        fontSize: 40,
                        color: const Color(0xFF34C759),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'WELCOME',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: เพิ่มหน้าจอ login ถ้ามี
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: const Color(0xFF34C759),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'เข้าสู่ระบบ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'ลงทะเบียน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          authService.signInWithGoogle(context);
                        },
                        icon: SvgPicture.asset(
                          'assets/svg/google.svg',
                          width: 24,
                          height: 24,
                        ),
                        label: const Text('Google'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =======================
// === Google Sign-In ===
// =======================


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// =======================
// === Google Sign-In ===
// =======================

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId:
        '104415405774-1855b9o21c9d22nks394o9oegdpm7kud.apps.googleusercontent.com',
  );

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      
      if (googleUser != null && context.mounted) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final String? idToken = googleAuth.idToken;

        if (idToken != null) {
          final response = await http.post(
            Uri.parse('http://10.0.2.2:3000/api/auth/google/login'),
            headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'idToken': idToken}),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            final String? token = data['token'];
            if (token != null) {
              await _storage.write(key: 'authToken', value: token);
              Navigator.pushReplacementNamed(context, '/home', arguments: googleUser);
            } else {
              print('ไม่พบ token จาก backend');
            }
          } else {
            print('การตอบกลับจาก backend ไม่ถูกต้อง: ${response.body}');
          }
        }
      }
    } catch (error) {
      print('เกิดข้อผิดพลาดขณะ sign-in: $error');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'authToken');
  }

  Future<GoogleSignInAccount?> signInSilently() async {
    return await _googleSignIn.signInSilently();
  }
}
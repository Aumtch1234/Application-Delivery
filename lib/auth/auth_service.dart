import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: '104415405774-1855b9o21c9d22nks394o9oegdpm7kud.apps.googleusercontent.com',
  );

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken != null) {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:3000/api/auth/google/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idToken': idToken}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['token'];

          if (token != null) {
            await _storage.write(key: 'authToken', value: token);
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: googleUser,
            );
          }
        }
      }
    } catch (e) {
      print('Google Sign-in Error: $e');
    }
  }
}

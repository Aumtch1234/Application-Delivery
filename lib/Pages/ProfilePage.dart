// lib/screens/profile_page.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery/Login-register/WellcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  final GoogleSignInAccount user;
  ProfilePage({super.key, required this.user});

  final FlutterSecureStorage storage = FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => showLogoutDialog(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user.photoUrl != null
                ? CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.photoUrl!),
                )
                : CircleAvatar(
                  radius: 50,
                  child: Text(
                    user.displayName?[0].toUpperCase() ?? 'U',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
            const SizedBox(height: 20),
            Text(
              user.displayName ?? 'Guest',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(user.email, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void handleLogout(BuildContext context) async {
    await _googleSignIn.signOut();
    await storage.delete(key: 'authToken');

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => WellcomeScreen()),
        (route) => false,
      );
    }
  }

  void showLogoutDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'ยืนยันการออกจากระบบ',
      desc: 'คุณแน่ใจหรือไม่ที่จะออกจากระบบ?',
      btnOkText: "ไม่",
      btnCancelText: "ออกจากระบบ",
      btnOkOnPress: () {},
      btnCancelOnPress: () {
        handleLogout(context);
      },
    ).show();
  }
}

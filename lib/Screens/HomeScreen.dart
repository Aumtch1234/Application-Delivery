import 'package:delivery/Login-register/WellcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FlutterSecureStorage storage = FlutterSecureStorage();


class Homescreen extends StatelessWidget {
  
  final GoogleSignInAccount user;
  const Homescreen({super.key, required this.user});

  // ไม่ต้องใช้ ModalRoute อีกต่อไป
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => handleLogout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              user.email ?? 'No Email',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void handleLogout(BuildContext context) async {
  await _googleSignIn.signOut(); // ออกจากระบบ Google
  await storage.delete(key: 'authToken'); // ลบ Token

  if (context.mounted) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => WellcomeScreen()),
      (route) => false, // ไม่ให้กดย้อนกลับได้
    );
  }
}

}

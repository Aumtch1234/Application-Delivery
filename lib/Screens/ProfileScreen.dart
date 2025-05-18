import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โปรไฟล์ของคุณ'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ชื่อ: ${user['name'] ?? '-'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text("อีเมล: ${user['email'] ?? '-'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text("บทบาท: ${user['role'] ?? '-'}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: user['image'] != null
                    ? NetworkImage(user['image'])
                    : const AssetImage("assets/png/default-avatar.png") as ImageProvider,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

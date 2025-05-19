// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class HomePage extends StatelessWidget {
  final GoogleSignInAccount user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CSC HD Food',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.tune),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Food That's\nGood For You",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'หมวดหมู่อาหาร',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: () {}, child: const Text('เพิ่มเติม')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildCategory('assets/menus/main.png', 'มื้อหลัก'),
                          _buildCategory('assets/menus/main.png', 'ก๋วยเตี๋ยว'),
                          _buildCategory('assets/menus/main.png', 'เครื่องดื่ม'),
                          _buildCategory('assets/menus/main.png', 'ของหวาน'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ร้านค้าที่เข้าร่วม',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: () {}, child: const Text('เพิ่มเติม')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStoreItem('ร้าน1'),
                        _buildStoreItem('ร้าน2'),
                        _buildStoreItem('ร้าน3'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'เมนูแนะนำ',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: () {}, child: const Text('เพิ่มเติม')),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildRecommendedMenu('ลาบทะเลรวม โลกผูพ (พิเศษ)', 'ร้านเส้นดก', '20 นาที', 45),
                        _buildRecommendedMenu('ยำทะเลรวม', 'ร้าน ผผู โว้', '20 นาที', 45),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28,
            child: Image.asset(icon, height: 30),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildStoreItem(String name) {
    return Column(
      children: [
        Image.asset('assets/menus/main.png', width: 60),
        const SizedBox(height: 4),
        Text(name),
      ],
    );
  }

  Widget _buildRecommendedMenu(String title, String shop, String time, double price) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/menus/main.png', height: 80, width: double.infinity, fit: BoxFit.cover),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.green, size: 16),
              const SizedBox(width: 2),
              const Text('5.0', style: TextStyle(fontSize: 12)),
            ],
          ),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(shop, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Row(
            children: [
              const Icon(Icons.timer, size: 14),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12)),
              const Spacer(),
              Text('\$ $price.-', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ],
      ),
    );
  }
}

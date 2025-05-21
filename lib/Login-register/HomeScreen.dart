import 'package:delivery/Pages/HomePage.dart';
import 'package:delivery/Pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class Homescreen extends StatefulWidget {
  final GoogleSignInAccount user;

  const Homescreen({super.key, required this.user});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _page = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(user: widget.user),
      Center(child: Text("ตะกร้าสินค้า", style: TextStyle(fontSize: 24))),
      Center(child: Text("คำสั่งซื้อ", style: TextStyle(fontSize: 24))),
      Center(child: Text("ประวัติคำสั่งซื้อ", style: TextStyle(fontSize: 24))),
      ProfilePage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Color(0xFF34C759),
        buttonBackgroundColor: Colors.white,
        height: 75,
        index: _page,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        items: <Widget>[
          Icon(Icons.home),
          _buildNavItem('assets/icons/home.png', 'ตะกร้า'),
          _buildNavItem('assets/icons/home.png', 'คำสั่งซื้อ',),
          _buildNavItem('assets/icons/home.png', 'ประวัติ'),
          _buildNavItem('assets/icons/home.png', 'โปรไฟล์'),
        ],
      ),
      body: _pages[_page],
    );
  }

  Widget _buildNavItem(String imagePath, String label, {bool isCenter = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: isCenter ? 50 : 35,
          width: isCenter ? 50 : 35,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isCenter ? Colors.blue : Colors.white,
            fontSize: isCenter ? 14 : 12,
            fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  
}

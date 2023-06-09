import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartStoveApp/pages/home_page.dart';
import 'package:smartStoveApp/pages/info_page.dart';
import 'package:smartStoveApp/pages/notifications_page.dart';
import 'package:smartStoveApp/pages/profile_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);

  final List<Widget> _pages = [
    const HomePage(),
    const InfoPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              firstColor,
              secondColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: GNav(
          backgroundColor: Colors.transparent,
          color: Colors.white38,
          activeColor: Colors.white,
          gap: 5,
          iconSize: 30,
          tabBackgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.info,
              text: 'Info',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Notifications',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

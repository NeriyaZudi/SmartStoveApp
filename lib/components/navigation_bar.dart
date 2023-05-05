import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartStoveApp/pages/home_page.dart';
import 'package:smartStoveApp/pages/info_page.dart';
import 'package:smartStoveApp/pages/notifications_page.dart';
import 'package:smartStoveApp/pages/profile_page.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const InfoPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  // handleNavigation(BuildContext context, int route) {
  //   switch (route) {
  //     case 0:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         homeRoute,
  //         (context) => false,
  //       );
  //       break;
  //     case 1:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         infoRoute,
  //         (context) => false,
  //       );
  //       break;
  //     case 2:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         notificationsRoute,
  //         (context) => false,
  //       );
  //       break;
  //     case 3:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         profileRoute,
  //         (context) => false,
  //       );
  //       break;
  //     default:
  //       Navigator.of(context).pushNamedAndRemoveUntil(
  //         homeRoute,
  //         (context) => false,
  //       );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: GNav(
        backgroundColor: (Colors.grey[300])!,
        color: Colors.black,
        activeColor: const Color.fromARGB(255, 136, 159, 231),
        gap: 5,
        iconSize: 30,
        tabBackgroundColor:
            Colors.blue.withOpacity(0.1), // selected tab background color
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 15), // navigation bar padding
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
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

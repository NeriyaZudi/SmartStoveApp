import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNavigationBar extends StatelessWidget {
  const MyNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GNav(
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
          text: 'Alerts',
        ),
        GButton(
          icon: Icons.person,
          text: 'Profile',
        ),
      ],
    );
  }
}

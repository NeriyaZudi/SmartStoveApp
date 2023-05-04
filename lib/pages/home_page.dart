import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.grey[300])!,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              scale: 12,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Home Page',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final shouldLogout = await showLogOutDialog(context);
              if (shouldLogout) {
                await AuthService.firebase().logOut();
                //ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (context) => false,
                );
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
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
            icon: Icons.favorite,
            text: 'Favorites',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.settings,
            text: 'Settings',
          ),
        ],
      ),
    );
  }
}

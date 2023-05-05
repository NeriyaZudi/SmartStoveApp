import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/components/navigation_bar.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

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
              'Information Page',
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
      //bottomNavigationBar: const MyNavigationBar(),
    );
  }
}

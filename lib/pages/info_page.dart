import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_logout_dialog.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.grey[300])!,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              scale: 12,
            ),
            const SizedBox(width: 10),
            const Text(
              'Information Page',
              style: TextStyle(color: Colors.black),
            ),
            const Icon(Icons.info),
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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
            buildSocialIcon(FontAwesomeIcons.github),
            const SizedBox(width: 12),
            buildSocialIcon(FontAwesomeIcons.linkedin),
            const SizedBox(width: 12)
          ],
        ),
      ),
    );
  }

  Widget buildSocialIcon(IconData icon) => CircleAvatar(
      radius: 25,
      child: Material(
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print(icon.toString());
          },
          child: Center(
            child: Icon(icon, size: 32),
          ),
        ),
      ));
}

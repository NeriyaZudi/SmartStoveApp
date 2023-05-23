import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/components/developer_card.dart';
import 'package:smartStoveApp/components/youtube_player.dart';
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
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🎞️ System operation and use Video 🎞️',
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            color: Colors.black87,
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const MyYoutubePlayer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const DeveloperCard(
              developerName: 'Neriya Zudi',
              developerEmail: 'neriyazudi@gmail.com',
              developerImg: 'lib/images/neriya.jpg',
            ),
            const SizedBox(height: 10),
            const DeveloperCard(
              developerName: 'Elon Yifrach',
              developerEmail: 'elonyifrah@gmail.com',
              developerImg: 'lib/images/eilon.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

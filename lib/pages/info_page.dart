import 'package:flutter/material.dart';
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
  final Color firstColor = const Color.fromARGB(255, 148, 179, 174);
  final Color secondColor = const Color.fromARGB(255, 8, 67, 143);
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, secondColor]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'About the System',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                          fontFamily: 'Kanit',
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            ),
                            children: [
                              TextSpan(
                                  text:
                                      'The "smart stove" system is an integrated system of artificial intelligence and IoT sensors.'),
                              TextSpan(
                                  text:
                                      'By using the system, you can cook different types of food and watch the stove data in real time.\n'),
                              TextSpan(
                                  text:
                                      'The system controls the stoves automatically and thus saves electricity consumption\n',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 16,
                                  )),
                              TextSpan(
                                  text: '⚡ \t\t ⚡ \t\t 🎛️ \t\t ⚡\t\t ⚡',
                                  style: TextStyle(
                                    color: Colors.greenAccent,
                                    fontSize: 16,
                                  )),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [firstColor, secondColor]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('🎞️ System operation and use Video 🎞️',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Kanit',
                          )),
                      MyYoutubePlayer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text('System Developers Info',
                  style: TextStyle(
                    color: secondColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Kanit',
                  )),
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
      ),
    );
  }
}

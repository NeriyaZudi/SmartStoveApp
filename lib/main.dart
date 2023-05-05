import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/detailsPages/egg_details.dart';
import 'package:smartStoveApp/detailsPages/pasta_details.dart';
import 'package:smartStoveApp/detailsPages/rice_details.dart';
import 'package:smartStoveApp/pages/auth_page.dart';
import 'package:smartStoveApp/pages/home_page.dart';
import 'package:smartStoveApp/pages/info_page.dart';
import 'package:smartStoveApp/pages/login_page.dart';
import 'package:smartStoveApp/pages/notifications_page.dart';
import 'package:smartStoveApp/pages/profile_page.dart';
import 'package:smartStoveApp/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.firebase().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        loginRoute: (context) => const LoginPage(),
        registerRoute: (context) => const RegisterPage(),
        homeRoute: (context) => const HomePage(),
        infoRoute: (context) => const InfoPage(),
        notificationsRoute: (context) => const NotificationsPage(),
        profileRoute: (context) => const ProfilePage(),
        riceRoute: (context) => const RiceDetails(),
        eggRoute: (context) => const EggDetails(),
        pastaRoute: (context) => const PastaDetails(),
      },
    );
  }
}

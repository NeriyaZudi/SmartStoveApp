import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/pages/auth_page.dart';
import 'package:smartStoveApp/pages/home_page.dart';
import 'package:smartStoveApp/pages/login_page.dart';
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
      home: AuthPage(),
      routes: {
        loginRoute: (context) => LoginPage(),
        registerRoute: (context) => const RegisterPage(),
        homeRoute: (context) => const HomePage(),
      },
    );
  }
}

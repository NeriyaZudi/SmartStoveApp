import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/pages/home_page.dart';
import 'package:smartStoveApp/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('user logged in');
            return const HomePage();
          } else {
            print('user no log');
            return LoginPage();
          }
        },
      ),
    );
  }
}

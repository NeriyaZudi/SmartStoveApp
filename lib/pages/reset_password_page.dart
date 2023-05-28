// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/components/my_textfield.dart';
import 'package:smartStoveApp/pages/login_page.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final userEmailController = TextEditingController();
  bool isResetSent = false;

  @override
  void dispose() {
    userEmailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future resetUserPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: userEmailController.text.trim());
      setState(() {
        isResetSent = true;
      });
      // showDialog(
      //   context: context,
      //   builder: (context) {
      //     return const AlertDialog(
      //       content:
      //           Text('Password Reset link sent, Please check your email inbox'),
      //     );
      //   },
      // );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: !isResetSent
            ? SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Image.asset(
                          'assets/images/app_logo.png',
                          height: 150,
                          width: 200,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Smart Stove App',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 136, 159, 231),
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'DancingScript',
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(5, 15),
                                    blurRadius: 15),
                              ]),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Enter your email address to reset your password',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                          ),
                        ),
                        const SizedBox(height: 10),
                        MyTextField(
                          controller: userEmailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            resetUserPassword();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "Reset Password",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              )
            : ResetSentView(context));
  }
}

Widget ResetSentView(context) {
  return (Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: Lottie.network(
          //'animations/cooking.json',
          'https://assets9.lottiefiles.com/private_files/lf30_eivlwmgd.json',
          height: 200,
          //width: 200,
          repeat: true,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Password Reset link sent\n Please check your email inbox',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontFamily: 'Ubuntu',
        ),
      ),
      const SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const LoginPage();
            },
          ));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              "Return To Login Page",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    ],
  )));
}

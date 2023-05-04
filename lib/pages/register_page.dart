// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:smartStoveApp/auth/auth_exceptions.dart';
import 'package:smartStoveApp/auth/auth_service.dart';
import 'package:smartStoveApp/components/my_textfield.dart';
import 'package:smartStoveApp/constants/routes.dart';
import 'package:smartStoveApp/utilities/show_error_dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  // sign user in method
  Future<void> registerUser(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      await AuthService.firebase().createUser(
        email: userEmailController.text,
        password: passwordController.text,
      );
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(
        context,
        'User email already exist, try to sign in',
      );
    } on WeakPasswordAuthException {
      await showErrorDialog(
        context,
        'Week Password, must be at least 6 characters',
      );
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Register Error',
      );
    }
    Navigator.pop(context);
    Navigator.of(context).pushNamedAndRemoveUntil(
      homeRoute,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
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

                const SizedBox(height: 10),

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
                const SizedBox(height: 10),
                const Text(
                  'Welcome To Smart Stove App',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'DancingScript',
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 15),

                // username textfield
                MyTextField(
                  controller: userEmailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Confirm Password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // Phone Number textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: IntlPhoneField(
                    controller: phoneController,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.grey[500])),
                    initialCountryCode: 'IL',
                  ),
                ),

                const SizedBox(height: 10),

                // sign in button
                GestureDetector(
                  onTap: () {
                    registerUser(context);
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
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute,
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Sign in here!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 136, 159, 231),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/components/navigation_bar.dart';

class WelcomeAnimation extends StatefulWidget {
  final String userName;
  const WelcomeAnimation({super.key, required this.userName});

  @override
  State<WelcomeAnimation> createState() => _WelcomeAnimation();
}

class _WelcomeAnimation extends State<WelcomeAnimation> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 15), () {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const MyNavigationBar();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Welcome ${widget.userName} !',
                    style: TextStyle(
                        color: Colors.blue.shade500,
                        fontFamily: 'Ubuntu',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(15, 15),
                              blurRadius: 15),
                        ]),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Lottie.network(
                  //'animations/cooking.json',
                  'https://assets10.lottiefiles.com/packages/lf20_h3b950fy.json',
                  height: 300,
                  repeat: true,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                textAlign: TextAlign.center,
                'You will immediately be taken to the home page',
                style: TextStyle(
                  color: Colors.blueGrey.shade500,
                  fontFamily: 'Ubuntu',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/pages/egg_cooking.dart';
import 'package:smartStoveApp/pages/pasta_cooking.dart';
import 'package:smartStoveApp/pages/rice_cooking.dart';

class CookingAnimation extends StatefulWidget {
  final int foodIndex;
  const CookingAnimation({super.key, required this.foodIndex});

  @override
  State<CookingAnimation> createState() => _CookingAnimationState();
}

class _CookingAnimationState extends State<CookingAnimation> {
  get foodIndex => null;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      switch (widget.foodIndex) {
        case 0:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const RiceCooking()));
          break;
        case 1:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const EggCooking()));
          break;
        case 2:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PastaCooking()));
          break;
        default:
      }
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
              const SizedBox(height: 70),
              Lottie.network(
                //'animations/cooking.json',
                'https://assets7.lottiefiles.com/packages/lf20_snmohqxj/lottie_step2/data.json',
                height: 350,
                repeat: true,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Just a moment \n\nand start cooking...',
                    style: TextStyle(
                        color: Colors.red.shade500,
                        fontSize: 30,
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
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smartStoveApp/components/cooking_page.dart';
import 'package:smartStoveApp/cookingPages/egg_cooking.dart';
import 'package:smartStoveApp/cookingPages/pasta_cooking.dart';
import 'package:smartStoveApp/cookingPages/rice_cooking.dart';

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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CookingPage(
                    title: 'Rice Cooking Page 🍚',
                    name: 'Rice 🍚',
                    img: 'lib/images/rice.jpg',
                    time: '20 minutes ⏲️',
                    temperature: '120° 🌡️',
                  )));
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
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
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
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Lottie.network(
                  //'animations/cooking.json',
                  'https://assets7.lottiefiles.com/packages/lf20_snmohqxj/lottie_step2/data.json',
                  height: 400,
                  width: 400,
                  repeat: true,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

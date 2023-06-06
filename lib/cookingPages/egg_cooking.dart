import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class EggCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const EggCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<EggCooking> createState() => _EggCookingState();
}

class _EggCookingState extends State<EggCooking> {
  @override
  Widget build(BuildContext context) {
    return CookingPage(
      title: 'Egg Cooking Page 🥚',
      name: 'Egg 🥚',
      img: 'lib/images/egg.jpg',
      time: '10 minutes ⏲️',
      temperature: '100° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class RiceCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const RiceCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<RiceCooking> createState() => _RiceCookingState();
}

class _RiceCookingState extends State<RiceCooking> {
  @override
  Widget build(BuildContext context) {
    return CookingPage(
      title: 'Rice Cooking Page 🍚',
      name: 'Rice 🍚',
      img: 'lib/images/rice.jpg',
      time: '20 minutes ⏲️',
      temperature: '120° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}

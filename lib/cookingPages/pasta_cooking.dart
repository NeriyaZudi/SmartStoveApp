import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class PastaCooking extends StatefulWidget {
  final int totalTime;
  final int turnOffTime;
  const PastaCooking(
      {super.key, required this.totalTime, required this.turnOffTime});

  @override
  State<PastaCooking> createState() => _PastaCookingState();
}

class _PastaCookingState extends State<PastaCooking> {
  @override
  Widget build(BuildContext context) {
    return CookingPage(
      title: 'Pasta Cooking Page 🍝',
      name: 'Pasta 🍝',
      img: 'lib/images/pasta.jpg',
      time: '8 minutes ⏲️',
      temperature: '140° 🌡️',
      totalTime: widget.totalTime,
      turnOffTime: widget.turnOffTime,
    );
  }
}

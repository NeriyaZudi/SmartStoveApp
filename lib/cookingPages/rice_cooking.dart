import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class RiceCooking extends StatefulWidget {
  const RiceCooking({super.key});

  @override
  State<RiceCooking> createState() => _RiceCookingState();
}

class _RiceCookingState extends State<RiceCooking> {
  @override
  Widget build(BuildContext context) {
    return const CookingPage(
      title: 'Rice Details Page 🍚',
      name: 'Rice 🍚',
      img: 'lib/images/rice.jpg',
      time: '20 minutes ⏲️',
      temperature: '120° 🌡️',
    );
  }
}

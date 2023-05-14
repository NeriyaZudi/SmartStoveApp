import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';

class PastaCooking extends StatelessWidget {
  const PastaCooking({super.key});

  @override
  Widget build(BuildContext context) {
    return const CookingPage(
      title: 'Pasta Details Page 🍝',
      name: 'Pasta 🍝',
      img: 'lib/images/pasta.jpg',
      time: '8 minutes ⏲️',
      temperature: '140° 🌡️',
    );
  }
}

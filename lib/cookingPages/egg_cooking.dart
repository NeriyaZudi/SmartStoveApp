import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/cooking_page.dart';
import 'package:smartStoveApp/pages/home_page.dart';

class EggCooking extends StatelessWidget {
  const EggCooking({super.key});

  @override
  Widget build(BuildContext context) {
    return const CookingPage(
      title: 'Egg Details Page 🥚',
      name: 'Egg 🥚',
      img: 'lib/images/egg.jpg',
      time: '10 minutes ⏲️',
      temperature: '100° 🌡️',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class EggDetails extends StatelessWidget {
  const EggDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailsCard(
      foodIndex: 1,
      title: 'Egg Details Page 🥚',
      name: 'Egg 🥚',
      img: 'lib/images/egg-pot.png',
      time: '10 minutes ⏲️',
      temperature: '100° 🌡️',
    );
  }
}

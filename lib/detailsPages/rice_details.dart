import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class RiceDetails extends StatelessWidget {
  const RiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailsCard(
      foodIndex: 0,
      title: 'Rice Details Page 🍚',
      name: 'Rice 🍚',
      img: 'lib/images/rice-pot.png',
      time: '20 minutes ⏲️',
      temperature: '120° 🌡️',
    );
  }
}

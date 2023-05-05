import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class RiceDetails extends StatelessWidget {
  const RiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailsCard(
      title: 'Rice Details Page 🍚',
      name: 'Rice 🍚',
      img: 'lib/images/rice-trans.png',
      time: '20 minutes ⏲️',
      temperature: '120° 🌡️',
    );
  }
}

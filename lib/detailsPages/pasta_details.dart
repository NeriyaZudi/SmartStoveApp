import 'package:flutter/material.dart';
import 'package:smartStoveApp/components/details_card.dart';

class PastaDetails extends StatelessWidget {
  const PastaDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailsCard(
      title: 'Pasta Details Page 🍝',
      name: 'Pasta 🍝',
      img: 'lib/images/pasta-pot.png',
      time: '8 minutes ⏲️',
      temperature: '140° 🌡️',
    );
  }
}

import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;
  final Function()? onPressed;

  const InfoCard({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.grey[200],
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: const TextStyle(
              color: Colors.teal,
              fontSize: 18,
              fontFamily: "WixMadeforDisplay",
            ),
          ),
        ),
      ),
    );
  }
}

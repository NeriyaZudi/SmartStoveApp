import 'package:flutter/material.dart';

class FoodInfo extends StatelessWidget {
  // the values we need
  final String text;
  final IconData icon;

  const FoodInfo({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 8, 67, 143),
                Color.fromARGB(255, 148, 179, 174),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: Colors.white,
            ),
            title: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: text.contains('🌡️') ? 17 : 18,
                fontFamily: "WixMadeforDisplay",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

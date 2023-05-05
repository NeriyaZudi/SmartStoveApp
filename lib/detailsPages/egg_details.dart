import 'package:flutter/material.dart';

class EggDetails extends StatelessWidget {
  const EggDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Colors.grey[300])!,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Egg Details Page 🥚',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

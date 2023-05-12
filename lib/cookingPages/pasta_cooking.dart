import 'package:flutter/material.dart';
import 'package:smartStoveApp/pages/home_page.dart';

class PastaCooking extends StatelessWidget {
  const PastaCooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Pasta Cooking',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text('PASTA!!!')),
      ),
    );
  }
}

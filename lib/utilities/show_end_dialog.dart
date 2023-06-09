import 'package:flutter/material.dart';

Future<void> showEndDialog(BuildContext context) {
  const Color firstColor = Color.fromARGB(255, 148, 179, 174);
  const Color secondColor = Color.fromARGB(255, 8, 67, 143);
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                firstColor,
                secondColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Center(
                  child: Text(
                    'End of stove operation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
              ),
              const ListTile(
                title: Text(
                  'The stove is turned off, but the cooking process is still in progress',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Ubuntu',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

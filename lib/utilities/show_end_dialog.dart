import 'package:flutter/material.dart';

Future<void> showEndDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('End of stove operation'),
        content: const Text(
            'The stove is turned off, but the cooking process is still in progress'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK')),
        ],
      );
    },
  );
}

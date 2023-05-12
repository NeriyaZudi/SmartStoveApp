import 'package:flutter/material.dart';

Future<bool> showCancelDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          textAlign: TextAlign.center,
          'Stop Cooking Process',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.red.shade500),
        ),
        content: Text(
          textAlign: TextAlign.center,
          'Are you sure you want to cancel the cooking process?\n\n The process will end and the stove will turn off',
          style: TextStyle(color: Colors.grey[800]),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Yes')),
            ],
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}

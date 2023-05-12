import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Icon icon;
  final Color bgcolor;
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClick,
    required this.icon,
    required this.bgcolor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: icon,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: onClick,
        label: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ));
  }
}

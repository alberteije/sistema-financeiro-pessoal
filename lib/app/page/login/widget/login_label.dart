import 'package:flutter/material.dart';

class LoginLabel extends StatelessWidget {
  final String label;
  const LoginLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return 
      Text(
        label,
        style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
    );
  }
}

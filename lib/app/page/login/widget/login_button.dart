import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Future Function() function;
  const LoginButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return 
      TextButton(
          onPressed: () {
            function();
          },
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF2697FF),
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 80),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 0.5,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}

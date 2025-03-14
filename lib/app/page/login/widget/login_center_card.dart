import 'package:flutter/material.dart';

class LoginCenterCard extends StatelessWidget {
  final List<Widget> centerCardChildren;
  const LoginCenterCard({super.key, required this.centerCardChildren});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: centerCardChildren,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';

class LoginOuterCard extends StatelessWidget {
  final String textLabel;
  final String textButton;
  final Future Function() function;
  LoginOuterCard(
      {super.key,
      required this.textLabel,
      required this.textButton,
      required this.function});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(textLabel,
              style: const TextStyle(
                color: Colors.grey,
                letterSpacing: 0.5,
              )),
          TextButton(
              onPressed: function,
              style: TextButton.styleFrom(
                  backgroundColor: controller.enabledColor,
                  padding: const EdgeInsets.symmetric(
                      vertical: 14.0, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0))),
              child: Text(
                textButton,
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.5,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
    );
  }
}

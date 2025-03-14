import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';
import 'package:financeiro_pessoal/app/page/login/forgot_password_page.dart';

class ForgotPasswordButton extends StatelessWidget {
  ForgotPasswordButton({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return 
      TextButton(
          onPressed: () {
            Get.to(() => ForgotPasswordPage());
          },
          style: TextButton.styleFrom(
              backgroundColor: controller.backgroundColor,
              padding:
                  const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0))),
          child: Text(
            'login_cant_login'.tr,
            style: const TextStyle(
              color: Colors.white,
              letterSpacing: 0.5,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}

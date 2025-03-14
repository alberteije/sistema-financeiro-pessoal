import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';

class LoginInputPassword extends StatelessWidget {
  LoginInputPassword({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return 
      Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: controller.backgroundColor,
        ),
        padding: const EdgeInsets.all(5.0),
        child: Obx(() => TextField(
              controller: controller.passwordController,
              onTap: () {},
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.lock_open_outlined,
                    color: controller.disabledTxt,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                      icon: controller.isPasswordShown
                          ? Icon(
                              Icons.visibility_off,
                              color: controller.disabledTxt,
                              size: 20,
                            )
                          : Icon(
                              Icons.visibility,
                              color: controller.disabledTxt,
                              size: 20,
                            ),
                      onPressed: () {
                        controller.isPasswordShown =
                            !controller.isPasswordShown;
                      }),
                  hintText: 'password'.tr,
                  hintStyle:
                      TextStyle(color: controller.enabledTxt, fontSize: 12)),
              obscureText: controller.isPasswordShown,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  color: controller.disabledTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            )
          ),
    );
  }
}

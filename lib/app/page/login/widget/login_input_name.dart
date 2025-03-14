import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';

class LoginInputName extends StatelessWidget {
  LoginInputName({super.key});

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
        child: TextField(
          controller: controller.nameController,
          onTap: () {},
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.title,
              color: controller.disabledTxt,
              size: 20,
            ),
            hintText: 'name'.tr,
            hintStyle: TextStyle(color: controller.enabledTxt, fontSize: 12),
          ),
          textAlignVertical: TextAlignVertical.top,
          style: TextStyle(
              color: controller.disabledTxt,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
    );
  }
}

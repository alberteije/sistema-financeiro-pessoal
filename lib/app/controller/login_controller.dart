import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();  
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final enabledColor = const Color.fromARGB(255, 63, 56, 89);
  final enabledTxt = Colors.white;
  final disabledTxt = Colors.grey;
  final backgroundColor = const Color(0xFF1F1A30);
  
  final _isPasswordShown = true.obs;
  get isPasswordShown => _isPasswordShown.value;
  set isPasswordShown(value) => _isPasswordShown.value = value;  
	
	Future<void> doLogin() async {
  }	
}
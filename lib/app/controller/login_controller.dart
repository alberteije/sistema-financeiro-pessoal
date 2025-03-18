import 'package:financeiro_pessoal/app/controller/usuario_controller.dart';
import 'package:financeiro_pessoal/app/infra/session.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/routes/app_routes.dart';
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
    final usuarioController = Get.find<UsuarioController>();

    // Se não há usuários no banco, permite acesso direto à Home
    if (!await usuarioController.hasUsersInDatabase()) {
			Session.loggedInUser.login = 'Usuário não Cadastrado';
      Get.offAndToNamed(Routes.homePage);
      return;
    }

    // Caso existam usuários, verifica as credenciais informadas
    final isAuthenticated = await usuarioController.doLogin(user: emailController.text, password: passwordController.text);

    if (isAuthenticated) {
			Session.loggedInUser.login = emailController.text;
      Get.offAndToNamed(Routes.homePage);
    } else {
      showErrorSnackBar(message: "Usuário ou senha inválidos");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';
import 'package:financeiro_pessoal/app/page/login/widget/login_widget_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/routes/app_routes.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return LoginScaffold(scaffoldChildren: _scaffoldChildren());
  }

  List<Widget> _scaffoldChildren() {
    return [
      LoginCenterCard(centerCardChildren: _centerCardChildren()),
      const SizedBox(height: 20),
      LoginOuterCard(
        textLabel: 'login_if_you_have_account'.tr,
        textButton: 'login_sign_in'.tr,
        function: () async {
          Get.offNamed(Routes.loginPage);
        },
      ),
      const SizedBox(
        height: 20,
      ),      
    ];
  }

  List<Widget> _centerCardChildren() {
    return [
      const LoginImage(),
      const SizedBox(
        height: 10,
      ),
      LoginLabel(label: 'login_create_account_label'.tr),
      const SizedBox(
        height: 20,
      ),
      LoginInputName(),
      const SizedBox(
        height: 20,
      ),    
      LoginInputPhone(),
      const SizedBox(
        height: 20,
      ),         
      LoginInputEmail(),
      const SizedBox(
        height: 20,
      ),
      LoginInputPassword(),
      const SizedBox(
        height: 20,
      ),      
      LoginInputPassword(),
      const SizedBox(
        height: 20,
      ),  
      LoginButton(
          text: 'login_sign_up'.tr,
          function: () async {
            showInfoSnackBar(message: 'login_sign_up_simulate_message'.tr);
          }),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/login_controller.dart';
import 'package:financeiro_pessoal/app/controller/theme_controller.dart';
import 'package:financeiro_pessoal/app/infra/constants.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/main_side_drawer.dart';

class HomePage extends GetView<LoginController> {
  HomePage({Key? key}) : super(key: key);
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.appName),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                themeController.isDarkMode
                    ? themeController.changeThemeMode(ThemeMode.light)
                    : themeController.changeThemeMode(ThemeMode.dark);
              },
              icon: themeController.isDarkMode
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.light_mode_outlined),
            ),
          ),
        ],
      ),
      drawer: MainSideDrawer(),
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.1, 0.4, 0.7, 0.9],
                colors: themeController.isDarkMode
                    ? [
                        Colors.blueGrey.shade900,
                        Colors.green.shade900,
                        Colors.grey.shade900,
                        Colors.blue.shade900,
                      ]
                    : [
                        Colors.blueGrey.shade100,
                        Colors.green,
                        Colors.grey,
                        Colors.blue.shade100,
                      ]),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.red.withOpacity(0.2), BlendMode.dstATop),
              image: Image.asset(
                Constants.backgroundImage,
              ).image,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    color: themeController.isDarkMode
                          ? const Color.fromARGB(255, 171, 211, 250).withOpacity(0.2)
                          : Colors.blue.shade100.withOpacity(0.1),
                    child: Container(
                      width: 400,
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 300,
                            width: 300,
                            child: Image.asset(
                              Constants.logotipo,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

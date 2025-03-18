// ignore_for_file: unnecessary_const

import 'package:financeiro_pessoal/app/infra/backup_restore_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:financeiro_pessoal/app/controller/theme_controller.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/routes/app_routes.dart';

class MainSideDrawer extends StatelessWidget {
  MainSideDrawer({Key? key}) : super(key: key);

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade800, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              Session.loggedInUser.login,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text("Seja bem-vindo!", style: TextStyle(fontSize: 14, color: Colors.white70)),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blueGrey),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "Cadastros",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
            ),
          ),
          const Divider(),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'usuario')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'usuario')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.usuarioListPage);
            },
            title: const Text(
              'Usuário',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'conta_receita')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'conta_receita')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.contaReceitaListPage);
            },
            title: const Text(
              'Contas de Receita',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'conta_despesa')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'conta_despesa')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.contaDespesaListPage);
            },
            title: const Text(
              'Contas de Despesa',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'metodo_pagamento')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'metodo_pagamento')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.metodoPagamentoListPage);
            },
            title: const Text(
              'Método de Pagamento',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              "Lançamentos",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
            ),
          ),
          const Divider(),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'lancamento_receita')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'lancamento_receita')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.lancamentoReceitaListPage);
            },
            title: const Text(
              'Lançamento de Receita',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'lancamento_despesa')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'lancamento_despesa')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.lancamentoDespesaListPage);
            },
            title: const Text(
              'Lançamento de Despesa',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'resumo')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'resumo')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.resumoListPage);
            },
            title: const Text(
              'Resumo Mensal',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Outras Opções',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.0),
            ),
          ),
          const Divider(),
          ListTile(
            enabled: Session.loggedInUser.administrador == 'S'
                ? true
                : Session.accessControlList.where(((t) => t.funcaoNome == 'extrato_bancario')).toList().isNotEmpty
                    ? Session.accessControlList.where(((t) => t.funcaoNome == 'extrato_bancario')).toList()[0].habilitado == 'S'
                    : false,
            onTap: () {
              Get.toNamed(Routes.extratoBancarioListPage);
            },
            title: const Text(
              'Extrato Bancário',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          ListTile(
            onTap: () {
              Get.defaultDialog(
                title: "Cópia de Segurança",
                titleStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blueAccent, // Cor do título
                ),
                content: const Column(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(Icons.backup, size: 50, color: Colors.blueAccent), // Ícone para indicar backup
                    const SizedBox(height: 10),
                    const Text(
                      "Escolha uma opção para backup ou restauração.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      await BackupRestoreHelper.createBackup();
                      Get.back(); // Fecha o diálogo após a ação
                    },
                    child: const Text("Fazer Backup"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await BackupRestoreHelper.restoreBackup();
                      Get.back(); // Fecha o diálogo após a ação
                    },
                    child: const Text("Restaurar Backup"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(Get.context!).pop(), // Fecha o diálogo sem ação
                    child: const Text("Cancelar"),
                  ),
                ],
                barrierDismissible: true, // Permite fechar o diálogo clicando fora dele
              );
            },
            title: const Text(
              'Cópia de Segurança',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: Icon(
              iconDataList[Random().nextInt(10)],
              color: iconColorList[Random().nextInt(10)],
            ),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Get.offAllNamed('/loginPage');
            },
            title: Text(
              "button_exit".tr,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

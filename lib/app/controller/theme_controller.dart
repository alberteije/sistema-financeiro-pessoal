import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';

class ThemeController extends GetxController {
	final _isDarkMode = true.obs;
	get isDarkMode => _isDarkMode.value;
	set isDarkMode(value) => _isDarkMode.value = value;	

	Future<ThemeMode> getTheme () async {
		final settings = await Session.database.customSelect(Constants.sqlGetSettings).getSingleOrNull();
		if (settings!.data["APP_THEME"] == 'ThemeMode.dark') {
			isDarkMode = true;
			return ThemeMode.dark;
		} else {
			isDarkMode = false;
			return ThemeMode.light;
		}
	} 

	void changeThemeMode(ThemeMode themeMode) {
		isDarkMode = !isDarkMode;
		Get.changeThemeMode(themeMode);
		Session.database.customUpdate("update HIDDEN_SETTINGS set APP_THEME = '$themeMode'");
	} 
}

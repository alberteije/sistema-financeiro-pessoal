import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US.dart';
import 'pt_BR.dart';
import 'es_ES.dart';


class AppTranslation extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocale = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'pt_BR': pt_BR,
        'es_ES': es_ES,
      };
}

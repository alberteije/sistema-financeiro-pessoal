import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';

deleteButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_delete'.tr,                
    icon: iconButtonDelete(),
    onPressed: onPressed,
  );
}

cancelAndExitButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_cancel_exit'.tr,                
    icon: iconButtonCancel(),
    onPressed: onPressed,
  );
}

exitButton() {
  return IconButton(
    tooltip: 'button_exit'.tr,                
    icon: iconButtonCancel(),
    onPressed: () { Navigator.of(Get.context!).pop(); },
  );
}

saveButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_save_changes'.tr,                
    icon: iconButtonSave(),
    onPressed: onPressed,
  );
}

printButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_print'.tr,                
    icon: iconButtonPrint(),
    onPressed: onPressed,
  );
} 

filterButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_filter'.tr,                
    icon: iconButtonFilter(),
    onPressed: onPressed,
  );  
}

lookupButton({Function()? onPressed}) {
  return IconButton(
    tooltip: 'button_lookup'.tr,                
    icon: iconButtonLookup(),
    onPressed: onPressed,
  );  
}
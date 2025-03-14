import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/infra/constants.dart';
import 'package:financeiro_pessoal/app/infra/session.dart';

showInfoSnackBar({required String message}) {
  Get.snackbar(
    'dialog_info_title'.tr, 
    message, 
    backgroundColor: Colors.green.shade900,
    snackPosition: SnackPosition.bottom,
    colorText: Colors.white,
    icon: const Icon(Icons.info, color: Colors.white,),
  );
}

showErrorSnackBar({required String message}) {
  Get.snackbar(
    'dialog_error_title'.tr, 
    message, 
    backgroundColor: Colors.red.shade900,
    snackPosition: SnackPosition.bottom,
    colorText: Colors.white,
    icon: const Icon(Icons.cancel, color: Colors.white,),
  );
}

showNoPrivilegeSnackBar() {
  Get.snackbar(
    'dialog_error_title'.tr, 
    'message_user_doesnt_have_privilege'.tr, 
    backgroundColor: Colors.red.shade900,
    snackPosition: SnackPosition.bottom,
    colorText: Colors.white,
    icon: const Icon(Icons.cancel, color: Colors.white,),
  );
}

/// Info dialog
showInfoDialog(String message, {dynamic Function()? onOkPressed}) {
  showDesktopDialog(
    title: 'dialog_info_title'.tr, 
    message: message, 
    dialogType: DialogType.info, 
    onOkPressed: onOkPressed
  ); 
}

/// Question Dialog
showQuestionDialog(String message, dynamic Function()? onOkPressed, {dynamic Function()? onCancelPressed}) {  
  showDesktopDialog(
    title: 'dialog_question_title'.tr, 
    message: message, 
    dialogType: DialogType.question, 
    onOkPressed: onOkPressed,
  ); 
}

/// Delete dialog
showDeleteDialog(dynamic Function()? onOkPressed, {String? message}) {
  showDesktopDialog(
    title: 'dialog_delete_title'.tr, 
    message: message ?? 'dialog_delete_standard_message'.tr, 
    dialogType: DialogType.question, 
    onOkPressed: onOkPressed
  );  
} 

/// Error dialog
showErrorDialog(String message, {dynamic Function()? onOkPressed}) {
  showDesktopDialog(
    title: 'dialog_error_title'.tr, 
    message: message, 
    dialogType: DialogType.error, 
    onOkPressed: onOkPressed
  );  
}

/// show a dialog box with focus on buttons
showDesktopDialog({required String title, required String message, required DialogType dialogType, Function? onOkPressed}) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _desktopDialogBody(title: title, message: message, dialogType: dialogType, onOkPressed: onOkPressed),
    ),
  );  
}

/// body of dialog box
_desktopDialogBody({required String title, required String message, required DialogType dialogType, Function? onOkPressed}){
  return Stack(
    children: <Widget>[
      Container(
        width: 400,
        padding: const EdgeInsets.only(left: 20, top: 40, right: 20, bottom: 20),
        margin: const EdgeInsets.only(top: 45),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Get.isDarkMode ? Colors.black87 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Get.isDarkMode ? Colors.white : Colors.black, offset: const Offset(0,10),
            blurRadius: 10
            ),
          ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(title, style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
            const Divider(thickness: 1,),
            const SizedBox(height: 15,),
            dialogType == DialogType.error            
            ? 
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                    child: Text(message, style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                ),
              )
            :            
              Text(message, style: const TextStyle(fontSize: 14),textAlign: TextAlign.center,),
            const SizedBox(height: 22,),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _getDesktopDialogButtons(dialogType: dialogType, onOkPressed: onOkPressed),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(45)),
                child: _setDialogImage(dialogType),
            ),
          ),
      ),
    ],
  );
}

/// set dialogbox image
Widget _setDialogImage(DialogType? dialogType) {
  switch (dialogType) {
    case DialogType.question :
      return Image.asset(Constants.dialogQuestionIcon);
    case DialogType.info :
      return Image.asset(Constants.dialogInfoIcon);
    case DialogType.error :
      return Image.asset(Constants.dialogErrorIcon);
    default:
      return Image.asset(Constants.dialogInfoIcon);
  }
}

List<Widget> _getDesktopDialogButtons({required DialogType dialogType, Function? onOkPressed}) {
  List<Widget> buttonList = [];

  if (dialogType == DialogType.info || dialogType == DialogType.error) {
    buttonList.add(
      SizedBox(
        width: GetPlatform.isMobile ? 80 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          onPressed: onOkPressed as void Function()? ?? () { Navigator.of(Get.context!).pop(); },
          child: const Text('OK'),
        ),              
      ),
    );
  } else {
    buttonList.add(
      SizedBox(
        width: GetPlatform.isMobile ? 80 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          onPressed: onOkPressed == null ? () { Navigator.of(Get.context!).pop(); } : () { Navigator.of(Get.context!).pop(); onOkPressed.call(); },
          child: Text('button_yes'.tr),
        ),             
      ),
    );
    buttonList.add(
      const SizedBox(width: 10.0),
    );
    buttonList.add(
      SizedBox(
        width: GetPlatform.isMobile ? 80 : 150,
        child: TextButton(
          autofocus: true,
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
            overlayColor: WidgetStateProperty.all<Color>(Colors.transparent.withOpacity(0.3)),
          ),
          child: Text('button_no'.tr),
          onPressed: () {
              Navigator.of(Get.context!).pop();
            },
        ),             
      ),
    );
  }
  return buttonList;
}

openWaitDialogBox() {
  Session.waitDialogIsOpen = true;  
  Get.defaultDialog(
    barrierDismissible: true,
    radius: 10.0,
    contentPadding: const EdgeInsets.all(20.0),
    title: '',
    content: const Center(
      child: CircularProgressIndicator(),
    ),
  );  
}

closeWaitDialogBox() {
  Session.waitDialogIsOpen = false;
  Navigator.of(Get.context!).pop();
}
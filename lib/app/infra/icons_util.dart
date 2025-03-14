import 'package:flutter/material.dart';

Icon iconButtonSave() {
  return const Icon(Icons.save, color: Colors.white);
}

Icon iconButtonInsert() {
  return const Icon(Icons.add, color: Colors.white);
}

Icon iconButtonDelete() {
  return const Icon(Icons.delete, color: Colors.white);
}

Icon iconButtonCancel() {
  return const Icon(Icons.cancel, color: Colors.limeAccent);
}

Icon iconButtonEdit() {
  return const Icon(Icons.edit, color: Colors.white);
}

Icon iconButtonPreview() {
  return const Icon(Icons.preview, color: Colors.white);
}

Icon iconButtonBack() {
  return const Icon(Icons.close, color: Colors.white);
}

Icon iconButtonLookup() {
  return const Icon(Icons.search);
}

Icon iconButtonCopy() {
  return const Icon(Icons.copy);
}

Icon iconButtonPaste() {
  return const Icon(Icons.paste);
}

Icon iconButtonPrint() {
  return const Icon(Icons.print);
}

Icon iconButtonFilter() {
  return const Icon(Icons.filter_alt_outlined);
}

// to be used at master/detail pages do create fake icons to tabs
final List<IconData> iconDataList = <IconData>[Icons.call, Icons.school, Icons.money, Icons.balance, Icons.people, Icons.edit_document, Icons.collections_bookmark, Icons.build, Icons.settings, Icons.safety_check, Icons.folder_zip_outlined];
final List<Color> iconColorList = <Color>[Colors.blue, Colors.cyan, Colors.red, Colors.green, Colors.amber, Colors.blueGrey, Colors.deepOrange, Colors.indigo, Colors.lightBlue, Colors.lightGreen, Colors.redAccent];
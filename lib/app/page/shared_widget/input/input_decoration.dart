import 'package:flutter/material.dart';
import 'package:get/get.dart';


/// InputDecoration for all system, normally TextField or TextFormField
InputDecoration inputDecoration(
    {required String hintText, required String labelText, required bool usePadding, 
    double? paddingVertical, double? paddingHorizontal, Color? color, bool? errorIfEmpty}
    ) {
  return InputDecoration(
    errorText: errorIfEmpty ?? false ? ('validator_input_decoration_empty'.tr) : null,
    fillColor: color,
    border: const UnderlineInputBorder(),
    hintText: hintText,
    labelText: labelText,
    filled: true,
    contentPadding: usePadding
        ? EdgeInsets.symmetric(
          vertical: paddingVertical ?? 5, 
          horizontal: paddingHorizontal ?? 10, 
        )
        : null,
  );
}
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  final String value;
  final String labelText;
  final String hintText;
  final List<String> items;
  final Function(dynamic) onChanged;
  final Function(dynamic)? validator;
  final Color? fontColor;

  const CustomDropdownButtonFormField({
    Key? key,
    required this.value,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.validator,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.only(right: 10),
          label: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10),
                child: Text(labelText,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16.0,
                        color: fontColor ?? Colors.black,
                        fontStyle: FontStyle.normal)),
              )
            ],
          )),
      isExpanded: true,
      hint: Text(
        hintText,
        style: const TextStyle(fontSize: 14),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        iconSize: 26,
      ),      
      buttonStyleData: ButtonStyleData(
        padding: EdgeInsets.only(top: labelText.isEmpty ? 0 : 5),
        height: 40,
      ),      
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
      ),      
      value: value,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style:
                      TextStyle(fontSize: 14, color: fontColor ?? Colors.black),
                ),
              ))
          .toList(),
      validator: validator as String? Function(dynamic)?,
      onChanged: onChanged,
      onSaved: (value) {},
    );
  }
}
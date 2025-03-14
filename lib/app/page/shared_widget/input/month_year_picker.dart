import 'package:flutter/material.dart';

class MonthYearPicker extends StatefulWidget {
  final Function(int month, int year) onChanged;

  const MonthYearPicker({Key? key, required this.onChanged}) : super(key: key);

  @override
  MonthYearPickerState createState() => MonthYearPickerState();
}

class MonthYearPickerState extends State<MonthYearPicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectMonthYear(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onChanged(picked.month, picked.year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _selectMonthYear(context),
      child: Text(
        "${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}",
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
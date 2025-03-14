import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: must_be_immutable
class DatePickerItem extends StatefulWidget {
  DatePickerItem({Key? key, DateTime? dateTime, required this.onChanged, this.firstDate, this.lastDate, this.mask, this.readOnly})
      : date = dateTime == null
            ? null
            : DateTime(dateTime.year, dateTime.month, dateTime.day),
        super(key: key);

  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? mask;
  DateTime? date;
  final ValueChanged<DateTime?> onChanged;
  final bool? readOnly;

  @override
  DatePickerItemState createState() => DatePickerItemState();
}

class DatePickerItemState extends State<DatePickerItem> {

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var today = DateTime.now();
    return DefaultTextStyle(      
      style: theme.textTheme.titleMedium!,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.dividerColor))),
              child: InkWell(
                onDoubleTap: () {
                  widget.onChanged(null);
                },
                onTap: () {
                  if (widget.readOnly == null || widget.readOnly == false) {
                    showDatePicker(
                      context: context,
                      initialDate: widget.date ?? today,
                      firstDate: widget.firstDate!,
                      lastDate: widget.lastDate!,
                    ).then<void>((DateTime? value) {
                      if (value != null) {
                        widget.onChanged(DateTime(value.year, value.month, value.day));
                        setState(() {
                          widget.date = value;
                        });            
                      }
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(widget.date != null
                        ? DateFormat(widget.mask ?? 'dd/MM/yyyy').format(widget.date!)
                        : ''),
                    ),
                    const Expanded(
                      flex: 0,
                      child: Icon(Icons.arrow_drop_down, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
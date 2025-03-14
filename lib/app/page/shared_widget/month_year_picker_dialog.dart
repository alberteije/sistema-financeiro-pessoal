import 'package:flutter/material.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

class MonthYearPickerDialog extends StatefulWidget {
  final Function(String) onConfirm;

  const MonthYearPickerDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  MonthYearPickerDialogState createState() => MonthYearPickerDialogState();
}

class MonthYearPickerDialogState extends State<MonthYearPickerDialog> {
  final TextEditingController _controller = MaskedTextController(mask: '00/0000',);
  String? _errorText;

  bool _isValidDate(String input) {
    final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$');
    if (!regex.hasMatch(input)) return false;
    return true;
  }

  void _onConfirm() {
    final input = _controller.text;
    if (_isValidDate(input)) {
      widget.onConfirm(input);
      Navigator.pop(context);
    } else {
      setState(() {
        _errorText = 'Data inválida! Use MM/AAAA.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Importar Dados de:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Mês/Ano',
              hintText: 'Mês/Ano de origem',
              suffixIcon: const Icon(Icons.calendar_today),
              errorText: _errorText,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _onConfirm,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

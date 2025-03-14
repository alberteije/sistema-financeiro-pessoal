import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:universal_html/html.dart' as html;

class Util {
  Util._();

  /// remove mask from a string
  static String? removeMask(dynamic value) {
    if (value != null) {
      return value.replaceAll(RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// sets the distance between columns in case there is a line break
  static EdgeInsets? distanceBetweenColumnsLineBreak(BuildContext context) {
    return bootStrapValueBasedOnSize(
      sizes: {
        "xl": EdgeInsets.zero,
        "lg": EdgeInsets.zero,
        "md": EdgeInsets.zero,
        "sm": EdgeInsets.zero,
        "": const EdgeInsets.only(top: 5.0, bottom: 10.0),
      },
      context: context,
    );
  }

  static String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      String dataFormatada = formatter.format(date);
      return dataFormatada;
    }
  }

  static DateTime? stringToDate(String? date) {
    if (date == null || date == '') {
      return null;
    } else {
      var formatter = DateFormat('dd/MM/yyyy');
      return formatter.parseStrict(date);
    }
  }

  static String moneyFormat(dynamic value) {
    final formatter = NumberFormat.simpleCurrency(locale: Get.locale.toString());
    final result = formatter.format(value);
    return result;
  }

  static String decimalFormat(dynamic value) {
    final formatter = NumberFormat.decimalPattern(Get.locale.toString());
    final result = formatter.format(value);
    return result;
  }

  static String stringFormat(dynamic value) {
    return value ?? "";
  }

  static num stringToNumberWithLocale(String value) {
    final formatter = NumberFormat.simpleCurrency(locale: Get.locale.toString());
    value = value.isEmpty ? '0' : value;
    final result = formatter.parse(value);
    return result;
  }

  static String crypt(String value) {
    return value;
  }

  static String decrypt(String value) {
    return value;
  }

  static String toJsonString(List<dynamic> driftList) {
    String jsonString = "[";
    for (var i = 0; i < driftList.length; i++) {
      jsonString += "{";
      for (var j = 0; j < driftList[i].data.length; j++) {
        String fieldName = driftList[i].data.keys.toList()[j];
        final value = driftList[i].data.values.toList()[j];
        jsonString += '"${fieldName.camelCase}": "$value",';
      }
      jsonString = jsonString.substring(0, jsonString.length - 1);
      jsonString += "},";
    }
    if (driftList.isNotEmpty) {
      jsonString = jsonString.substring(0, jsonString.length - 1);
    }
    jsonString += "]";
    return jsonString;
  }

  static Future<void> exportToCSV(List<PlutoRow> rows, List<PlutoColumn> columns, String fileName) async {
    // Criar cabeçalho
    String csvData = '${columns.map((col) => col.title).join(',')}\n';

    // Criar linhas
    for (var row in rows) {
      String rowData = columns.map((col) => row.cells[col.field]!.value.toString()).join(',');
      csvData += '$rowData\n';
    }

    if (kIsWeb) {
      // **🖥️ SOLUÇÃO PARA WEB: Download automático**
      final bytes = Uint8List.fromList(csvData.codeUnits);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.csv")
        ..click();
      html.Url.revokeObjectUrl(url);
      showInfoSnackBar(message: "Arquivo salvo na pasta Downloads");
    } else {
      // **📱🖥️ SOLUÇÃO PARA MOBILE/DESKTOP**

      // Pedir permissão no Android
      if (io.Platform.isAndroid) {
        if (await Permission.storage.request().isDenied) {
          showErrorSnackBar(message: "Permissão negada.");
          return;
        }
      }

      // Permitir que o usuário escolha o local
      String? directoryPath = await FilePicker.platform.getDirectoryPath();
      if (directoryPath == null) {
        showErrorSnackBar(message: "Nenhuma pasta selecionada. Arquivo não exportado.");
        return;
      }

      // Criar e salvar o arquivo
      final file = io.File('$directoryPath/$fileName.csv');
      await file.writeAsString(csvData);
      showInfoSnackBar(message: "Arquivo salvo em: $directoryPath\\$fileName.csv");
    }
  }

  static Filter applyMonthYearToFilter(String monthYear, Filter filter) {
    final parts = monthYear.split('/');
    if (parts.length != 2) {
      throw ArgumentError('Formato inválido. Use mm/aaaa.');
    }

    final int month = int.parse(parts[0]); // Mês
    final int year = int.parse(parts[1]);  // Ano

    final DateTime startDate = DateTime(year, month, 1);
    final DateTime endDate = DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    filter.initialDate = formatter.format(startDate);
    filter.finalDate = formatter.format(endDate);

    return filter;
  }
}

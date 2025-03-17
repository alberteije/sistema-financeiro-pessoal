import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:financeiro_pessoal/app/infra/util.dart';
import 'package:get/get.dart';

List<PlutoColumn> resumoGridColumns({bool isForLookup = false}) {
  return <PlutoColumn>[
    PlutoColumn(
      title: "Id",
      field: "id",
      type: PlutoColumnType.number(
        format: '##########',
      ),
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      width: 100,
      readOnly: true,
    ),
    PlutoColumn(
      title: "R | D",
      field: "receitaDespesa",
      type: PlutoColumnType.text(),
      formatter: Util.stringFormat,
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      width: 100,
      readOnly: true,
      renderer: (rendererContext) {
        final String valor = rendererContext.cell.value.toString();
        return Container(
          alignment: Alignment.center, // Garante que o conteúdo fique centralizado
          child: Text(
            valor,
            textAlign: TextAlign.center, // Centraliza o texto dentro do widget
            style: TextStyle(
              fontWeight: valor == "+" || valor == "-" ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        );
      },
    ),
    PlutoColumn(
      title: "Código",
      field: "codigo",
      type: PlutoColumnType.text(),
      formatter: Util.stringFormat,
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
      width: 100,
      readOnly: true,
    ),
    PlutoColumn(
      title: "Descrição",
      field: "descricao",
      type: PlutoColumnType.text(),
      formatter: Util.stringFormat,
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.left,
      width: 300,
      readOnly: true,
      renderer: (rendererContext) {
        final String valor = rendererContext.cell.value.toString();
        return Text(
          valor,
          style: TextStyle(
            fontWeight: valor == "TOTAL RECEITAS" || valor == "TOTAL DESPESAS" ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        );
      },
    ),
    PlutoColumn(
      title: "Valor Orçado",
      field: "valorOrcado",
      type: PlutoColumnType.currency(
        format: '###,###.##',
        decimalDigits: 2,
        locale: Get.locale.toString(),
      ),
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.right,
      width: 200,
      readOnly: false,
    ),
    PlutoColumn(
      title: "Valor Realizado",
      field: "valorRealizado",
      type: PlutoColumnType.currency(
        format: '###,###.##',
        decimalDigits: 2,
        locale: Get.locale.toString(),
      ),
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.right,
      width: 200,
      readOnly: true,
    ),
    PlutoColumn(
      title: "Diferença",
      field: "diferenca",
      type: PlutoColumnType.currency(
        format: '###,###.##',
        decimalDigits: 2,
        locale: Get.locale.toString(),
      ),
      enableFilterMenuItem: true,
      enableSetColumnsMenuItem: false,
      enableHideColumnMenuItem: false,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.right,
      width: 200,
      readOnly: true,
    ),
  ];
}

import 'package:financeiro_pessoal/app/data/model/resumo_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryChartDialog extends StatefulWidget {
  final List<ResumoModel> resumoList;

  const SummaryChartDialog({Key? key, required this.resumoList}) : super(key: key);

  @override
  SummaryChartDialogState createState() => SummaryChartDialogState();
}

class SummaryChartDialogState extends State<SummaryChartDialog> {
  String _selectedType = 'Receita'; // Começa mostrando receitas

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Resumo Financeiro"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dropdown para selecionar Receitas ou Despesas
          DropdownButton<String>(
            value: _selectedType,
            items: const [
              DropdownMenuItem(value: 'Receita', child: Text("Receitas")),
              DropdownMenuItem(value: 'Despesa', child: Text("Despesas")),
            ],
            onChanged: (value) {
              setState(() {
                _selectedType = value!;
              });
            },
          ),
          const SizedBox(height: 20),

          // Exibe o gráfico correspondente
          SizedBox(
            height: 300,
            child: PieChart(
              PieChartData(
                sections: _buildChartSections(),
                sectionsSpace: 2,
                centerSpaceRadius: 50,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(Get.context!).pop(),
          child: const Text("Fechar"),
        ),
      ],
    );
  }

  // Função para construir os dados do gráfico de pizza
  List<PieChartSectionData> _buildChartSections() {
    List<ResumoModel> filteredList = widget.resumoList.where((item) => item.receitaDespesa == _selectedType).toList();

    if (filteredList.isEmpty) {
      return [
        PieChartSectionData(
          value: 1,
          title: "Sem dados",
          color: Colors.grey,
          radius: 50,
        ),
      ];
    }

    // Lista de cores diferentes para as fatias
    List<Color> colors = [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.pinkAccent,
      Colors.cyanAccent,
      Colors.amberAccent,
    ];

    return filteredList.asMap().entries.map((entry) {
      int index = entry.key;
      ResumoModel resumo = entry.value;

      return PieChartSectionData(
        value: resumo.valorRealizado ?? 0,
        title: resumo.descricao ?? '',
        color: colors[index % colors.length], // Escolhe uma cor da lista
        radius: 80,
      );
    }).toList();
  }
}

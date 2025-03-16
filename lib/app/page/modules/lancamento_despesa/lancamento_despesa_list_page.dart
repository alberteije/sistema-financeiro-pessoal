import 'package:financeiro_pessoal/app/page/shared_widget/input/month_year_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/controller/lancamento_despesa_controller.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';

class LancamentoDespesaListPage extends GetView<LancamentoDespesaController> {
	const LancamentoDespesaListPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				automaticallyImplyLeading: false,
				title: const Text('Lançamento de Despesa'),
				actions: [
          IconButton(
            tooltip: 'Importar Lançamentos',
            icon: const Icon(Icons.sim_card_download_outlined),
            color: Colors.lime,
            onPressed: controller.showImportDataDialog,
          ),
          IconButton(
            tooltip: 'Exportar para Excel',
            icon: const Icon(Icons.dataset_outlined),
            color: Colors.amber,
            onPressed: controller.exportToCSV,
          ),
					deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
					exitButton(),
					const SizedBox(
						height: 10,
						width: 5,
					)
				],
			),
			floatingActionButton: FloatingActionButton(
					onPressed: 
          controller.canInsert 
          ? controller.callEditPageToInsert
          : controller.noPrivilegeMessage,
					child: iconButtonInsert(),
        ),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
			bottomNavigationBar: BottomAppBar(
				color: Colors.black26,
				shape: const CircularNotchedRectangle(),
				child: Row(children: [
					printButton(onPressed: controller.printReport),
					filterButton(onPressed: controller.callFilter),
          MonthYearPicker(
            onChanged: (month, year) async {
              controller.mesAno = "$month/$year";
              await controller.loadData();
            },
          ),
				]),
			),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              // Permite que a PlutoGrid ocupe o espaço disponível
              child: PlutoGrid(
                configuration: gridConfiguration(),
                noRowsWidget: Text('grid_no_rows'.tr),
                createFooter: (stateManager) {
                  stateManager.setPageSize(Constants.gridRowsPerPage, notify: false);
                  return PlutoPagination(stateManager);
                },
                columns: controller.gridColumns,
                rows: controller.plutoRows(),
                onLoaded: (event) {
                  controller.plutoGridStateManager = event.stateManager;
                  controller.plutoGridStateManager.setSelectingMode(PlutoGridSelectingMode.row);
                  controller.keyboardListener = controller.plutoGridStateManager.keyManager!.subject.stream.listen(controller.handleKeyboard);
                  controller.loadData();
                },
                onRowDoubleTap: (event) {
                  controller.canUpdate ? controller.callEditPage() : controller.noPrivilegeMessage();
                },
                mode: PlutoGridMode.selectWithOneTap,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              color: Colors.black, // Define um fundo para destacar os valores
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown, // Ajusta o tamanho automaticamente
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(
                      "A Pagar: ${Util.moneyFormat(controller.aPagar)}",
                      style: const TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 16),
                    Obx(() => Text(
                      "Pago: ${Util.moneyFormat(controller.pago)}",
                      style: const TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 16),
                    Obx(() => Text(
                      "Total: ${Util.moneyFormat(controller.total)}",
                      style: const TextStyle(color: Colors.white),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
	}

}

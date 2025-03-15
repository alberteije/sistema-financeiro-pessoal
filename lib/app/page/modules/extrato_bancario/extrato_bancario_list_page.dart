import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/controller/extrato_bancario_controller.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';

class ExtratoBancarioListPage extends GetView<ExtratoBancarioController> {
	const ExtratoBancarioListPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				automaticallyImplyLeading: false,
				title: const Text('Extrato Bancário'),
				actions: [
					// deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
          IconButton(
            tooltip: 'Importar Extrato',
            icon: const Icon(Icons.attach_money_outlined),
            color: Colors.lime,
            onPressed: controller.importOfx,
          ),
          IconButton(
            tooltip: 'Conciliar Dados',
            icon: const Icon(Icons.check_box_outlined),
            color: Colors.amber,
            onPressed: controller.reconciliateData,
          ),
          IconButton(
            tooltip: 'Exportar como Lançamento',
            icon: const Icon(Icons.upload),
            color: Colors.lightGreen,
            onPressed: controller.exportAsTransaction,
          ),

					exitButton(),
					const SizedBox(
						height: 10,
						width: 5,
					)
				],
			),
			// floatingActionButton: FloatingActionButton(
			// 		onPressed: 
      //     controller.canInsert 
      //     ? controller.callEditPageToInsert
      //     : controller.noPrivilegeMessage,
			// 		child: iconButtonInsert(),
      //   ),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
			bottomNavigationBar: BottomAppBar(
				color: Colors.black26,
				shape: const CircularNotchedRectangle(),
				child: Row(children: [
					printButton(onPressed: controller.printReport),
					filterButton(onPressed: controller.callFilter)
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
                  // controller.canUpdate ? controller.callEditPage() : controller.noPrivilegeMessage();
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
                      "Créditos: R\$ ${controller.creditos.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 16),
                    Obx(() => Text(
                      "Débitos: R\$ ${controller.debitos.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    )),
                    const SizedBox(width: 16),
                    Obx(() => Text(
                      "Saldo: R\$ ${controller.saldo.toStringAsFixed(2)}",
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

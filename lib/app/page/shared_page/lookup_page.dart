import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/lookup_controller.dart';
import 'package:financeiro_pessoal/app/infra/constants.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:pluto_grid/pluto_grid.dart';

class LookupPage extends GetView<LookupController> {
  const LookupPage({super.key});

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          Get.back();
        }
      },
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(controller.title!),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: controller.loadData,
            ),
            exitButton(),
            const SizedBox(
              height: 10,
              width: 5,
            )
          ],
        ),
        body: Form(
          key: controller.formKey,
          child: SafeArea(
            child: LayoutBuilder(
              builder: (ctx, size) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    width: size.maxWidth,
                    height: size.maxHeight,
                    constraints: BoxConstraints(
                      minHeight: Get.height - 100,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CustomDropdownButtonFormField(
                          value: 'Id',
                          labelText: 'filter_column_label'.tr,
                          hintText: 'filter_column_hint'.tr,
                          items: controller.aliasColumns!,
                          onChanged: (dynamic newValue) {
                            controller.filter.field = newValue;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          focusNode: controller.focusNode,
                          autofocus: true,
                          controller: controller.filterValueController,
                          onFieldSubmitted: (value) async {
                            await controller.loadData();
                          },
                          decoration: InputDecoration(
                            labelText: 'filter_edit_label'.tr,
                            hintText: 'filter_edit_hint'.tr,
                            filled: true,
                          ),
                          onSaved: (String? value) {
                            controller.filterValueController.text = value ?? '';
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: PlutoGrid(
                            configuration: gridConfiguration(),
                            noRowsWidget: Text('grid_no_rows'.tr),
                            createFooter: (stateManager) {
                              stateManager.setPageSize(Constants.gridRowsPerPage,
                                  notify: false);
                              return PlutoPagination(stateManager);
                            },
                            columns: controller.gridColumns,
                            rows: controller.plutoRows(),
                            onLoaded: (event) {                           
                              controller.plutoGridStateManager = event.stateManager;
                              controller.plutoGridStateManager.setKeepFocus(false);
                              controller.focusNode.requestFocus();
                              controller.plutoGridStateManager
                                  .setSelectingMode(PlutoGridSelectingMode.row);
                              controller.keyboardListener = controller
                                  .plutoGridStateManager.keyManager!.subject.stream
                                  .listen(controller.handleKeyboard);
                            },
                            onRowDoubleTap: (event) {
                              controller.resultPlutoRow();
                            },
                            mode: PlutoGridMode.selectWithOneTap,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

}
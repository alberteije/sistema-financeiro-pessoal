import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/filter_controller.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/buttons.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';

class FilterPage extends GetView<FilterController> {
  const FilterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.standardFilter) {
      controller.filter.condition = 'cont';
    } else {
      controller.filter.condition = 'between';
    }

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
          backgroundColor: Colors.blueGrey,
          title: Text(controller.title!),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: controller.saveAndReturnValue,
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
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                CustomDropdownButtonFormField(
                  value: controller.filter.field,
                  labelText: 'filter_column_label'.tr,
                  hintText: 'filter_column_hint'.tr,
                  items: controller.aliasColumns!,
                  onChanged: (dynamic newValue) {
                    controller.filter.field = newValue;
                  },
                ),
                const SizedBox(height: 1.0),
                Visibility(
                  visible: controller.standardFilter,
                  child: Container(
                    height: 90.0,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    alignment: Alignment.bottomLeft,
                    child: TextFormField(
                      autofocus: true,
                      onFieldSubmitted: (value) {
                        controller.saveAndReturnValue();
                      },
                      decoration: InputDecoration(
                        labelText: 'filter_edit_label'.tr,
                        hintText: 'filter_edit_hint'.tr,
                        filled: true,
                      ),
                      onSaved: (String? value) {
                        controller.filter.value = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: !controller.standardFilter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('filter_initial_date'.tr),
                      DatePickerItem(
                        dateTime: controller.filter.initialDate,
                        onChanged: (DateTime? value) {
                          controller.filter.initialDate = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Visibility(
                  visible: !controller.standardFilter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('filter_final_date'.tr),
                      DatePickerItem(
                        dateTime: controller.filter.finalDate,
                        onChanged: (DateTime? value) {
                          controller.filter.finalDate = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

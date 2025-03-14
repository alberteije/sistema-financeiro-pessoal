import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/repository/lookup_repository.dart';

class LookupController extends GetxController {
  final LookupRepository lookupRepository;
  LookupController({required this.lookupRepository});

  final _title = ''.obs;
  get title => _title.value;
  set title(value) => _title.value = value;

  final _route = ''.obs;
  get route => _route.value;
  set route(value) => _route.value = value;

  final _aliasColumns = [].obs ;
  get aliasColumns => _aliasColumns.value;
  set aliasColumns(value) => _aliasColumns.value = value;

  final _dbColumns = [].obs ;
  get dbColumns => _dbColumns.value;
  set dbColumns(value) => _dbColumns.value = value;

  final _gridColumns = [].obs;
  get gridColumns => _gridColumns.value;
  set gridColumns(value) => _gridColumns.value = value;

  var _resultList = [];

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter();

  late StreamSubscription _keyboardListener;
  get keyboardListener => _keyboardListener;
  set keyboardListener(value) => _keyboardListener = value;

  late PlutoGridStateManager _plutoGridStateManager;
  get plutoGridStateManager => _plutoGridStateManager;
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final scrollController = ScrollController();
  final filterValueController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  Future loadData() async {
    if (filterValueController.text.isEmpty) {
      showInfoSnackBar(message: 'filter_edit_hint'.tr);
      focusNode.requestFocus();
    } else {
      _plutoGridStateManager.setShowLoading(true);
      _plutoGridStateManager.removeAllRows();
      filter.condition = 'cont';
      filter.value = filterValueController.text;
      if (filter.field != null) {
        // Lets use SQL field rather camelCase Column to proceed with filter
        final indexOfColumn = aliasColumns.indexOf(filter.field);
        filter.field = indexOfColumn > 0 ? dbColumns[indexOfColumn] : filter.field;      
      } else {
        filter.field = 'ID';
      }   
      
      await Get.find<LookupController>().getList(filter: filter);
      _plutoGridStateManager.appendRows(plutoRows());
      _plutoGridStateManager.setShowLoading(false);
      focusNode.requestFocus();
    }    
  }

  Future getList({Filter? filter}) async {
    await lookupRepository.getList(route: route, filter: filter).then((data) {
      _resultList = data;
    });
  }

  List<PlutoRow> plutoRows() {
    List<PlutoRow> plutoRowList = <PlutoRow>[];
    for (var item in _resultList) {
      plutoRowList.add(_getPlutoRow(item));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(Map item) {
    return PlutoRow(
      cells: _getPlutoCells(item),
    );
  }

  Map<String, PlutoCell> _getPlutoCells(Map item) {
    final result = <String, PlutoCell>{};
    final keys = item.keys.toList();
    final values = item.values.toList();

    for (var i = 0; i < keys.length; i++) {
      result[keys[i]] = PlutoCell(value: values[i]?.toString() ?? ''); 
    }
    return result;
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      resultPlutoRow();
    }
  }

  void resultPlutoRow() {
    if (_plutoGridStateManager.currentRow != null) {
      Get.back(result: _plutoGridStateManager.currentRow!);
    }
  }

  void refreshItems({String standardValue = ''}) {
    _resultList.clear();
    filter = Filter();
    filterValueController.text = standardValue;  
    Timer.periodic(const Duration(seconds: 1), (timer) { 
      focusNode.requestFocus();
      if (focusNode.hasFocus) {
        timer.cancel();
      }
    });       
  }

  @override
  void onClose() {
    keyboardListener.cancel();
    filterValueController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

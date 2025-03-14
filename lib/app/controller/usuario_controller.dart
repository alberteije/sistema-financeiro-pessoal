import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/controller/controller_imports.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro_pessoal/app/routes/app_routes.dart';
import 'package:financeiro_pessoal/app/data/repository/usuario_repository.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/mixin/controller_base_mixin.dart';

class UsuarioController extends GetxController with ControllerBaseMixin {
  final UsuarioRepository usuarioRepository;
  UsuarioController({required this.usuarioRepository});

  // general
  final _dbColumns = UsuarioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = UsuarioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = usuarioGridColumns();
  
  var _usuarioModelList = <UsuarioModel>[];

  final _usuarioModel = UsuarioModel().obs;
  UsuarioModel get usuarioModel => _usuarioModel.value;
  set usuarioModel(value) => _usuarioModel.value = value ?? UsuarioModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  var _isInserting = false;

  // list page
  late StreamSubscription _keyboardListener;
  get keyboardListener => _keyboardListener;
  set keyboardListener(value) => _keyboardListener = value;

  late PlutoGridStateManager _plutoGridStateManager;
  get plutoGridStateManager => _plutoGridStateManager;
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final _plutoRow = PlutoRow(cells: {}).obs;
  get plutoRow => _plutoRow.value;
  set plutoRow(value) => _plutoRow.value = value;

  List<PlutoRow> plutoRows() {
    List<PlutoRow> plutoRowList = <PlutoRow>[];
    for (var usuarioModel in _usuarioModelList) {
      plutoRowList.add(_getPlutoRow(usuarioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(UsuarioModel usuarioModel) {
    return PlutoRow(
      cells: _getPlutoCells(usuarioModel: usuarioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ UsuarioModel? usuarioModel}) {
    return {
			"id": PlutoCell(value: usuarioModel?.id ?? 0),
			"login": PlutoCell(value: usuarioModel?.login ?? ''),
			"senha": PlutoCell(value: usuarioModel?.senha ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _usuarioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      usuarioModel.plutoRowToObject(plutoRow);
    } else {
      usuarioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Usuário]';
    filterController.standardFilter = true;
    filterController.aliasColumns = aliasColumns;
    filterController.dbColumns = dbColumns;
    filterController.filter.field = 'Id';

    filter = await Get.toNamed(Routes.filterPage);
    await loadData();
  }

  Future loadData() async {
    _plutoGridStateManager.setShowLoading(true);
    _plutoGridStateManager.removeAllRows();
    await Get.find<UsuarioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await usuarioRepository.getList(filter: filter).then( (data){ _usuarioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Usuário',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			loginController.text = currentRow.cells['login']?.value ?? '';
			senhaController.text = currentRow.cells['senha']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.usuarioEditPage)!.then((value) {
        if (usuarioModel.id == 0) {
          _plutoGridStateManager.removeCurrentRow();
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
    }
  }

  void callEditPageToInsert() {
    _plutoGridStateManager.prependNewRows(); 
    final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
    _plutoGridStateManager.setCurrentCell(cell, 0); 
    _isInserting = true;
    usuarioModel = UsuarioModel();
    callEditPage();   
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      if (canUpdate) {
        callEditPage();
      } else {
        noPrivilegeMessage();
      }
    }
  } 

  Future delete() async {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      showDeleteDialog(() async {
        if (await usuarioRepository.delete(id: currentRow.cells['id']!.value)) {
          _usuarioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }


  // edit page
  final scrollController = ScrollController();
	final loginController = TextEditingController();
	final senhaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = usuarioModel.id;
		plutoRow.cells['login']?.value = usuarioModel.login;
		plutoRow.cells['senha']?.value = usuarioModel.senha;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await usuarioRepository.save(usuarioModel: usuarioModel); 
        if (result != null) {
          usuarioModel = result;
          if (_isInserting) {
            _usuarioModelList.add(result);
            _isInserting = false;
          }
          objectToPlutoRow();
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "usuario";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		loginController.dispose();
		senhaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}
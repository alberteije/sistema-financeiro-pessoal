import 'dart:async';

import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/controller/controller_imports.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro_pessoal/app/routes/app_routes.dart';
import 'package:financeiro_pessoal/app/data/repository/lancamento_receita_repository.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/mixin/controller_base_mixin.dart';

class LancamentoReceitaController extends GetxController with ControllerBaseMixin {
  final LancamentoReceitaRepository lancamentoReceitaRepository;
  LancamentoReceitaController({required this.lancamentoReceitaRepository});

  // general
  final _dbColumns = LancamentoReceitaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = LancamentoReceitaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = lancamentoReceitaGridColumns();

  var _lancamentoReceitaModelList = <LancamentoReceitaModel>[];

  final _lancamentoReceitaModel = LancamentoReceitaModel().obs;
  LancamentoReceitaModel get lancamentoReceitaModel => _lancamentoReceitaModel.value;
  set lancamentoReceitaModel(value) => _lancamentoReceitaModel.value = value ?? LancamentoReceitaModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter();

  var _isInserting = false;

  String mesAno = "";

  double aReceber = 100;
  double recebido = 200;
  double total = 300;

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
    for (var lancamentoReceitaModel in _lancamentoReceitaModelList) {
      plutoRowList.add(_getPlutoRow(lancamentoReceitaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(LancamentoReceitaModel lancamentoReceitaModel) {
    return PlutoRow(
      cells: _getPlutoCells(lancamentoReceitaModel: lancamentoReceitaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({LancamentoReceitaModel? lancamentoReceitaModel}) {
    return {
      "id": PlutoCell(value: lancamentoReceitaModel?.id ?? 0),
      "contaReceita": PlutoCell(value: lancamentoReceitaModel?.contaReceitaModel?.descricao ?? ''),
      "metodoPagamento": PlutoCell(value: lancamentoReceitaModel?.metodoPagamentoModel?.descricao ?? ''),
      "dataReceita": PlutoCell(value: lancamentoReceitaModel?.dataReceita ?? ''),
      "valor": PlutoCell(value: lancamentoReceitaModel?.valor ?? 0),
      "statusReceita": PlutoCell(value: lancamentoReceitaModel?.statusReceita ?? ''),
      "historico": PlutoCell(value: lancamentoReceitaModel?.historico ?? ''),
      "idContaReceita": PlutoCell(value: lancamentoReceitaModel?.idContaReceita ?? 0),
      "idMetodoPagamento": PlutoCell(value: lancamentoReceitaModel?.idMetodoPagamento ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _lancamentoReceitaModelList.where(((t) => t.id == plutoRow.cells['id']!.value)).toList();
    if (modelFromRow.isEmpty) {
      lancamentoReceitaModel.plutoRowToObject(plutoRow);
    } else {
      lancamentoReceitaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lançamento de Receita]';
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
    await Get.find<LancamentoReceitaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    filter = Util.applyMonthYearToFilter(mesAno, filter ?? Filter());
    await lancamentoReceitaRepository.getList(filter: filter).then((data) {
      _lancamentoReceitaModelList = data;
    });
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lançamento de Receita',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      contaReceitaModelController.text = currentRow.cells['contaReceita']?.value ?? '';
      metodoPagamentoModelController.text = currentRow.cells['metodoPagamento']?.value ?? '';
      valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
      historicoController.text = currentRow.cells['historico']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.lancamentoReceitaEditPage)!.then((value) {
        if (lancamentoReceitaModel.id == 0) {
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
    lancamentoReceitaModel = LancamentoReceitaModel();
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
        if (await lancamentoReceitaRepository.delete(id: currentRow.cells['id']!.value)) {
          _lancamentoReceitaModelList.removeWhere(((t) => t.id == currentRow.cells['id']!.value));
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }

  Future exportToCSV() async {
    await Util.exportToCSV(plutoGridStateManager.rows, plutoGridStateManager.columns, 'lancamentos_de_receita');
  }

  void showImportDataDialog() {
    Get.dialog(
      MonthYearPickerDialog(
        onConfirm: (selectedDate) async {
          await lancamentoReceitaRepository.transferDataFromOtherMonth(selectedDate, mesAno).then((data) async {
            await loadData();
          });
        },
      ),
    );
  }

  // edit page
  final scrollController = ScrollController();
  final contaReceitaModelController = TextEditingController();
  final metodoPagamentoModelController = TextEditingController();
  final valorController = MoneyMaskedTextController();
  final historicoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value;

  void objectToPlutoRow() {
    plutoRow.cells['id']?.value = lancamentoReceitaModel.id;
    plutoRow.cells['idContaReceita']?.value = lancamentoReceitaModel.idContaReceita;
    plutoRow.cells['contaReceita']?.value = lancamentoReceitaModel.contaReceitaModel?.descricao;
    plutoRow.cells['idMetodoPagamento']?.value = lancamentoReceitaModel.idMetodoPagamento;
    plutoRow.cells['metodoPagamento']?.value = lancamentoReceitaModel.metodoPagamentoModel?.descricao;
    plutoRow.cells['dataReceita']?.value = Util.formatDate(lancamentoReceitaModel.dataReceita);
    plutoRow.cells['valor']?.value = lancamentoReceitaModel.valor;
    plutoRow.cells['statusReceita']?.value = lancamentoReceitaModel.statusReceita;
    plutoRow.cells['historico']?.value = lancamentoReceitaModel.historico;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await lancamentoReceitaRepository.save(lancamentoReceitaModel: lancamentoReceitaModel);
        if (result != null) {
          lancamentoReceitaModel = result;
          if (_isInserting) {
            _lancamentoReceitaModelList.add(result);
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

  Future callContaReceitaLookup() async {
    final lookupController = Get.find<LookupController>();
    lookupController.refreshItems(standardValue: '%');
    lookupController.title = '${'lookup_page_title'.tr} [Conta]';
    lookupController.route = '/conta-receita/';
    lookupController.gridColumns = contaReceitaGridColumns(isForLookup: true);
    lookupController.aliasColumns = ContaReceitaModel.aliasColumns;
    lookupController.dbColumns = ContaReceitaModel.dbColumns;

    final plutoRowResult = await Get.toNamed(Routes.lookupPage);
    if (plutoRowResult != null) {
      lancamentoReceitaModel.idContaReceita = plutoRowResult.cells['id']!.value;
      lancamentoReceitaModel.contaReceitaModel!.plutoRowToObject(plutoRowResult);
      contaReceitaModelController.text = lancamentoReceitaModel.contaReceitaModel?.descricao ?? '';
      formWasChanged = true;
    }
  }

  Future callMetodoPagamentoLookup() async {
    final lookupController = Get.find<LookupController>();
    lookupController.refreshItems(standardValue: '%');
    lookupController.title = '${'lookup_page_title'.tr} [Método Pagamento]';
    lookupController.route = '/metodo-pagamento/';
    lookupController.gridColumns = metodoPagamentoGridColumns(isForLookup: true);
    lookupController.aliasColumns = MetodoPagamentoModel.aliasColumns;
    lookupController.dbColumns = MetodoPagamentoModel.dbColumns;

    final plutoRowResult = await Get.toNamed(Routes.lookupPage);
    if (plutoRowResult != null) {
      lancamentoReceitaModel.idMetodoPagamento = plutoRowResult.cells['id']!.value;
      lancamentoReceitaModel.metodoPagamentoModel!.plutoRowToObject(plutoRowResult);
      metodoPagamentoModelController.text = lancamentoReceitaModel.metodoPagamentoModel?.descricao ?? '';
      formWasChanged = true;
    }
  }

  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
    functionName = "lancamento_receita";
    setPrivilege();
    mesAno = mesAno.isEmpty ? "${DateTime.now().month}/${DateTime.now().year}" : mesAno;
    super.onInit();
  }

  @override
  void onClose() {
    contaReceitaModelController.dispose();
    metodoPagamentoModelController.dispose();
    valorController.dispose();
    historicoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose();
    super.onClose();
  }
}

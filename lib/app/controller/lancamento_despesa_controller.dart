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
import 'package:financeiro_pessoal/app/data/repository/lancamento_despesa_repository.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/mixin/controller_base_mixin.dart';

class LancamentoDespesaController extends GetxController with ControllerBaseMixin {
  final LancamentoDespesaRepository lancamentoDespesaRepository;
  LancamentoDespesaController({required this.lancamentoDespesaRepository});

  // general
  final _dbColumns = LancamentoDespesaModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = LancamentoDespesaModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = lancamentoDespesaGridColumns();

  var _lancamentoDespesaModelList = <LancamentoDespesaModel>[];

  final _lancamentoDespesaModel = LancamentoDespesaModel().obs;
  LancamentoDespesaModel get lancamentoDespesaModel => _lancamentoDespesaModel.value;
  set lancamentoDespesaModel(value) => _lancamentoDespesaModel.value = value ?? LancamentoDespesaModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter();

  var _isInserting = false;

  String mesAno = "";

  final _aPagar = 0.0.obs;
  double get aPagar => _aPagar.value;
  set aPagar(double value) => _aPagar.value = value;

  final _pago = 0.0.obs;
  double get pago => _pago.value;
  set pago(double value) => _pago.value = value;

  final _total = 0.0.obs;
  double get total => _total.value;
  set total(double value) => _total.value = value;

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
    for (var lancamentoDespesaModel in _lancamentoDespesaModelList) {
      plutoRowList.add(_getPlutoRow(lancamentoDespesaModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(LancamentoDespesaModel lancamentoDespesaModel) {
    return PlutoRow(
      cells: _getPlutoCells(lancamentoDespesaModel: lancamentoDespesaModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({LancamentoDespesaModel? lancamentoDespesaModel}) {
    return {
      "id": PlutoCell(value: lancamentoDespesaModel?.id ?? 0),
      "contaDespesa": PlutoCell(value: lancamentoDespesaModel?.contaDespesaModel?.descricao ?? ''),
      "metodoPagamento": PlutoCell(value: lancamentoDespesaModel?.metodoPagamentoModel?.descricao ?? ''),
      "dataDespesa": PlutoCell(value: lancamentoDespesaModel?.dataDespesa ?? ''),
      "valor": PlutoCell(value: lancamentoDespesaModel?.valor ?? 0),
      "statusDespesa": PlutoCell(value: lancamentoDespesaModel?.statusDespesa ?? ''),
      "historico": PlutoCell(value: lancamentoDespesaModel?.historico ?? ''),
      "idContaDespesa": PlutoCell(value: lancamentoDespesaModel?.idContaDespesa ?? 0),
      "idMetodoPagamento": PlutoCell(value: lancamentoDespesaModel?.idMetodoPagamento ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _lancamentoDespesaModelList.where(((t) => t.id == plutoRow.cells['id']!.value)).toList();
    if (modelFromRow.isEmpty) {
      lancamentoDespesaModel.plutoRowToObject(plutoRow);
    } else {
      lancamentoDespesaModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Lançamento de Despesa]';
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
    await Get.find<LancamentoDespesaController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
    calculateSummaryValues();
  }

  Future getList({Filter? filter}) async {
    filter = Util.applyMonthYearToFilter(mesAno, filter ?? Filter());
    await lancamentoDespesaRepository.getList(filter: filter).then((data) {
      _lancamentoDespesaModelList = data;
    });
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Lançamento de Despesa',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      contaDespesaModelController.text = currentRow.cells['contaDespesa']?.value ?? '';
      metodoPagamentoModelController.text = currentRow.cells['metodoPagamento']?.value ?? '';
      valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
      historicoController.text = currentRow.cells['historico']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.lancamentoDespesaEditPage)!.then((value) {
        if (lancamentoDespesaModel.id == 0) {
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
    lancamentoDespesaModel = LancamentoDespesaModel();
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
        if (await lancamentoDespesaRepository.delete(id: currentRow.cells['id']!.value)) {
          _lancamentoDespesaModelList.removeWhere(((t) => t.id == currentRow.cells['id']!.value));
          _plutoGridStateManager.removeCurrentRow();
          calculateSummaryValues();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }

  Future exportToCSV() async {
    await Util.exportToCSV(plutoGridStateManager.rows, plutoGridStateManager.columns, 'lancamentos_de_despesa');
  }

  void showImportDataDialog() {
    Get.dialog(
      MonthYearPickerDialog(
        onConfirm: (selectedDate) async {
          await lancamentoDespesaRepository.transferDataFromOtherMonth(selectedDate, mesAno).then((data) async {
            await loadData();
          });
        },
      ),
    );
  }

  // edit page
  final scrollController = ScrollController();
  final contaDespesaModelController = TextEditingController();
  final metodoPagamentoModelController = TextEditingController();
  final valorController = MoneyMaskedTextController();
  final historicoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value;

  void objectToPlutoRow() {
    plutoRow.cells['id']?.value = lancamentoDespesaModel.id;
    plutoRow.cells['idContaDespesa']?.value = lancamentoDespesaModel.idContaDespesa;
    plutoRow.cells['contaDespesa']?.value = lancamentoDespesaModel.contaDespesaModel?.descricao;
    plutoRow.cells['idMetodoPagamento']?.value = lancamentoDespesaModel.idMetodoPagamento;
    plutoRow.cells['metodoPagamento']?.value = lancamentoDespesaModel.metodoPagamentoModel?.descricao;
    plutoRow.cells['dataDespesa']?.value = Util.formatDate(lancamentoDespesaModel.dataDespesa);
    plutoRow.cells['valor']?.value = lancamentoDespesaModel.valor;
    plutoRow.cells['statusDespesa']?.value = lancamentoDespesaModel.statusDespesa;
    plutoRow.cells['historico']?.value = lancamentoDespesaModel.historico;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await lancamentoDespesaRepository.save(lancamentoDespesaModel: lancamentoDespesaModel);
        if (result != null) {
          lancamentoDespesaModel = result;
          if (_isInserting) {
            _lancamentoDespesaModelList.add(result);
            _isInserting = false;
          }
          objectToPlutoRow();
          calculateSummaryValues();
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  void calculateSummaryValues() {
    double tempAPagar = 0.0;
    double tempPago = 0.0;
    double tempTotal = 0.0;

    for (var lancamento in _lancamentoDespesaModelList) {
      if (lancamento.statusDespesa == "A Pagar") {
        tempAPagar += lancamento.valor ?? 0;
      } else if (lancamento.statusDespesa == "Pago") {
        tempPago += lancamento.valor ?? 0;
      }
      tempTotal += lancamento.valor ?? 0;
    }

    // Atualiza os valores observáveis
    aPagar = tempAPagar;
    pago = tempPago;
    total = tempTotal;
  }

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }

  Future callContaDespesaLookup() async {
    final lookupController = Get.find<LookupController>();
    lookupController.refreshItems(standardValue: '%');
    lookupController.title = '${'lookup_page_title'.tr} [Conta]';
    lookupController.route = '/conta-despesa/';
    lookupController.gridColumns = contaDespesaGridColumns(isForLookup: true);
    lookupController.aliasColumns = ContaDespesaModel.aliasColumns;
    lookupController.dbColumns = ContaDespesaModel.dbColumns;

    final plutoRowResult = await Get.toNamed(Routes.lookupPage);
    if (plutoRowResult != null) {
      lancamentoDespesaModel.idContaDespesa = plutoRowResult.cells['id']!.value;
      lancamentoDespesaModel.contaDespesaModel!.plutoRowToObject(plutoRowResult);
      contaDespesaModelController.text = lancamentoDespesaModel.contaDespesaModel?.descricao ?? '';
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
      lancamentoDespesaModel.idMetodoPagamento = plutoRowResult.cells['id']!.value;
      lancamentoDespesaModel.metodoPagamentoModel!.plutoRowToObject(plutoRowResult);
      metodoPagamentoModelController.text = lancamentoDespesaModel.metodoPagamentoModel?.descricao ?? '';
      formWasChanged = true;
    }
  }

  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
    functionName = "lancamento_despesa";
    setPrivilege();
    mesAno = mesAno.isEmpty ? "${DateTime.now().month}/${DateTime.now().year}" : mesAno;
    super.onInit();
  }

  @override
  void onClose() {
    contaDespesaModelController.dispose();
    metodoPagamentoModelController.dispose();
    valorController.dispose();
    historicoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose();
    super.onClose();
  }
}

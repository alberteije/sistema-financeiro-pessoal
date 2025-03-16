// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:xml/xml.dart' as xml;

import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/controller/controller_imports.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:financeiro_pessoal/app/routes/app_routes.dart';
import 'package:financeiro_pessoal/app/data/repository/extrato_bancario_repository.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/mixin/controller_base_mixin.dart';

class ExtratoBancarioController extends GetxController with ControllerBaseMixin {
  final ExtratoBancarioRepository extratoBancarioRepository;
  ExtratoBancarioController({required this.extratoBancarioRepository});

  // general
  final _dbColumns = ExtratoBancarioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ExtratoBancarioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = extratoBancarioGridColumns();

  var _extratoBancarioModelList = <ExtratoBancarioModel>[];

  final _extratoBancarioModel = ExtratoBancarioModel().obs;
  ExtratoBancarioModel get extratoBancarioModel => _extratoBancarioModel.value;
  set extratoBancarioModel(value) => _extratoBancarioModel.value = value ?? ExtratoBancarioModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter();

  var _isInserting = false;

  String mesAno = "";

  final _creditos = 0.0.obs;
  double get creditos => _creditos.value;
  set creditos(double value) => _creditos.value = value;

  final _debitos = 0.0.obs;
  double get debitos => _debitos.value;
  set debitos(double value) => _debitos.value = value;

  final _saldo = 0.0.obs;
  double get saldo => _saldo.value;
  set saldo(double value) => _saldo.value = value;

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
    for (var extratoBancarioModel in _extratoBancarioModelList) {
      plutoRowList.add(_getPlutoRow(extratoBancarioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ExtratoBancarioModel extratoBancarioModel) {
    return PlutoRow(
      cells: _getPlutoCells(extratoBancarioModel: extratoBancarioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ExtratoBancarioModel? extratoBancarioModel}) {
    return {
      "id": PlutoCell(value: extratoBancarioModel?.id ?? 0),
      "dataTransacao": PlutoCell(value: extratoBancarioModel?.dataTransacao ?? ''),
      "idTransacao": PlutoCell(value: extratoBancarioModel?.idTransacao ?? ''),
      "checknum": PlutoCell(value: extratoBancarioModel?.checknum ?? ''),
      "numeroReferencia": PlutoCell(value: extratoBancarioModel?.numeroReferencia ?? ''),
      "valor": PlutoCell(value: extratoBancarioModel?.valor ?? 0),
      "historico": PlutoCell(value: extratoBancarioModel?.historico ?? ''),
      "conciliado": PlutoCell(value: extratoBancarioModel?.conciliado ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _extratoBancarioModelList.where(((t) => t.id == plutoRow.cells['id']!.value)).toList();
    if (modelFromRow.isEmpty) {
      extratoBancarioModel.plutoRowToObject(plutoRow);
    } else {
      extratoBancarioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Extrato Bancário]';
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
    await Get.find<ExtratoBancarioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
    calculateSumaryValues();
  }

  Future getList({Filter? filter}) async {
    filter = Util.applyMonthYearToFilter(mesAno, filter ?? Filter());
    await extratoBancarioRepository.getList(filter: filter).then((data) {
      _extratoBancarioModelList = data;
    });
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Extrato Bancário',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      idTransacaoController.text = currentRow.cells['idTransacao']?.value ?? '';
      checknumController.text = currentRow.cells['checknum']?.value ?? '';
      numeroReferenciaController.text = currentRow.cells['numeroReferencia']?.value ?? '';
      valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
      historicoController.text = currentRow.cells['historico']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.extratoBancarioEditPage)!.then((value) {
        if (extratoBancarioModel.id == 0) {
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
    extratoBancarioModel = ExtratoBancarioModel();
    callEditPage();
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      // if (canUpdate) {
      //   callEditPage();
      // } else {
      //   noPrivilegeMessage();
      // }
    }
  }

  Future delete() async {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      showDeleteDialog(() async {
        if (await extratoBancarioRepository.delete(id: currentRow.cells['id']!.value)) {
          _extratoBancarioModelList.removeWhere(((t) => t.id == currentRow.cells['id']!.value));
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }

  Future<void> importOfx() async {
    showQuestionDialog('Deseja importar o arquivo do extrato bancário?', () async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          File file = File(result.files.single.path!);
          String arquivoOFX = await file.readAsString();
          final arquivoXML = xml.XmlDocument.parse(arquivoOFX);

          // limpa a lista
          _extratoBancarioModelList.clear();

          // Exclui os registros atuais do banco
          await extratoBancarioRepository.deleteByDateRange(filter);

          // Captura os lançamentos no arquivo
          final lancamentos = arquivoXML.findAllElements('STMTTRN');
          for (var lancamento in lancamentos) {
            var extrato = ExtratoBancarioModel();
            extrato.id = 0;
            final ano = int.parse(lancamento.getElement('DTPOSTED')?.text.substring(0, 4) ?? '');
            final mes = int.parse(lancamento.getElement('DTPOSTED')?.text.substring(4, 6) ?? '');
            final dia = int.parse(lancamento.getElement('DTPOSTED')?.text.substring(6, 8) ?? '');

            String mesAnoExtrato = "$mes/$ano";
            if (mesAno != mesAnoExtrato) {
              showErrorSnackBar(message: "Existem lançamentos no extrato que estão fora do mês selacionado.");
              return;
            }

            extrato.dataTransacao = DateTime.utc(ano, mes, dia);
            extrato.idTransacao = lancamento.getElement('FITID')?.text;
            extrato.checknum = lancamento.getElement('CHECKNUM')?.text;
            extrato.numeroReferencia = lancamento.getElement('REFNUM')?.text;
            extrato.valor = double.tryParse(lancamento.getElement('TRNAMT')?.text ?? "0");
            extrato.historico = lancamento.getElement('MEMO')?.text;

            // Persiste no banco de dados
            final savedExtrato = await extratoBancarioRepository.save(extratoBancarioModel: extrato);
            if (savedExtrato != null) {
              _extratoBancarioModelList.add(savedExtrato);
            }
          }
          await loadData();
        } else {
          showInfoSnackBar(message: "Nenhum arquivo selecionado.");
        }
      } catch (e) {
        showErrorSnackBar(message: "Erro ao importar extrato: ${e.toString()}");
      }
    });
  }

  Future<void> reconcileTransactions() async {
    showQuestionDialog('Deseja conciliar os lançamentos?', () async {
      await extratoBancarioRepository.reconcileTransactions(filter).then((value) async {
        await loadData();
      });
    });
  }

  Future<void> exportDataToIncomesAndExpenses() async {
    showQuestionDialog('Deseja exportar os dados para Lançamentos de Receita e Despesa?', () async {
      await extratoBancarioRepository.exportDataToIncomesAndExpenses(filter);
    });
  }

  // edit page
  final scrollController = ScrollController();
  final idTransacaoController = TextEditingController();
  final checknumController = TextEditingController();
  final numeroReferenciaController = TextEditingController();
  final valorController = MoneyMaskedTextController();
  final historicoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value;

  void objectToPlutoRow() {
    plutoRow.cells['id']?.value = extratoBancarioModel.id;
    plutoRow.cells['dataTransacao']?.value = Util.formatDate(extratoBancarioModel.dataTransacao);
    plutoRow.cells['idTransacao']?.value = extratoBancarioModel.idTransacao;
    plutoRow.cells['checknum']?.value = extratoBancarioModel.checknum;
    plutoRow.cells['numeroReferencia']?.value = extratoBancarioModel.numeroReferencia;
    plutoRow.cells['valor']?.value = extratoBancarioModel.valor;
    plutoRow.cells['historico']?.value = extratoBancarioModel.historico;
    plutoRow.cells['conciliado']?.value = extratoBancarioModel.conciliado;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await extratoBancarioRepository.save(extratoBancarioModel: extratoBancarioModel);
        if (result != null) {
          extratoBancarioModel = result;
          if (_isInserting) {
            _extratoBancarioModelList.add(result);
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

  void calculateSumaryValues() {
    double tempCreditos = 0.0;
    double tempDebitos = 0.0;
    double tempSaldo = 0.0;

    for (var lancamento in _extratoBancarioModelList) {
      lancamento.valor = lancamento.valor ?? 0;
      if (lancamento.valor! >= 0) {
        tempCreditos += lancamento.valor ?? 0;
      } else {
        tempDebitos += lancamento.valor ?? 0;
      }
      tempSaldo += lancamento.valor ?? 0;
    }

    // Atualiza os valores observáveis
    creditos = tempCreditos;
    debitos = tempDebitos;
    saldo = tempSaldo;
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
    functionName = "extrato_bancario";
    setPrivilege();
    mesAno = mesAno.isEmpty ? "${DateTime.now().month}/${DateTime.now().year}" : mesAno;
    super.onInit();
  }

  @override
  void onClose() {
    idTransacaoController.dispose();
    checknumController.dispose();
    numeroReferenciaController.dispose();
    valorController.dispose();
    historicoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose();
    super.onClose();
  }
}

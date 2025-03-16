import 'dart:async';

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
import 'package:financeiro_pessoal/app/data/repository/resumo_repository.dart';
import 'package:financeiro_pessoal/app/page/shared_page/shared_page_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:financeiro_pessoal/app/mixin/controller_base_mixin.dart';

class ResumoController extends GetxController with ControllerBaseMixin {
  final ResumoRepository resumoRepository;
  ResumoController({required this.resumoRepository});

  // general
  final _dbColumns = ResumoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ResumoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = resumoGridColumns();

  var _resumoModelList = <ResumoModel>[];

  final _resumoModel = ResumoModel().obs;
  ResumoModel get resumoModel => _resumoModel.value;
  set resumoModel(value) => _resumoModel.value = value ?? ResumoModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter();

  var _isInserting = false;

	final RxBool hasChanges = false.obs;

  String mesAno = "";

  final _saldo = 0.0.obs;
  double get saldo => _saldo.value;
  set saldo(double value) => _saldo.value = value;

  // list page
	void markAsChanged() {
    hasChanges.value = true;
  }

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
    for (var resumoModel in _resumoModelList) {
      plutoRowList.add(_getPlutoRow(resumoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ResumoModel resumoModel) {
    return PlutoRow(
      cells: _getPlutoCells(resumoModel: resumoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ResumoModel? resumoModel}) {
    return {
      "id": PlutoCell(value: resumoModel?.id ?? 0),
      "receitaDespesa": PlutoCell(value: resumoModel?.receitaDespesa ?? ''),
      "codigo": PlutoCell(value: resumoModel?.codigo ?? ''),
      "descricao": PlutoCell(value: resumoModel?.descricao ?? ''),
      "valorOrcado": PlutoCell(value: resumoModel?.valorOrcado ?? 0),
      "valorRealizado": PlutoCell(value: resumoModel?.valorRealizado ?? 0),
      "diferenca": PlutoCell(value: resumoModel?.diferenca ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _resumoModelList.where(((t) => t.id == plutoRow.cells['id']!.value)).toList();
    if (modelFromRow.isEmpty) {
      resumoModel.plutoRowToObject(plutoRow);
    } else {
      resumoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Resumo]';
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
    await Get.find<ResumoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
    calculateSummaryValues();
  }

  Future getList({Filter? filter}) async {
    filter = Filter(field: 'mes_ano', value: mesAno.padLeft(7, '0'));
    await resumoRepository.getList(filter: filter).then((data) {
      _resumoModelList = data;
    });
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Resumo',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      codigoController.text = currentRow.cells['codigo']?.value ?? '';
      descricaoController.text = currentRow.cells['descricao']?.value ?? '';
      valorOrcadoController.text = currentRow.cells['valorOrcado']?.value?.toStringAsFixed(2) ?? '';
      valorRealizadoController.text = currentRow.cells['valorRealizado']?.value?.toStringAsFixed(2) ?? '';
      diferencaController.text = currentRow.cells['diferenca']?.value?.toStringAsFixed(2) ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.resumoEditPage)!.then((value) {
        if (resumoModel.id == 0) {
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
    resumoModel = ResumoModel();
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
        if (await resumoRepository.delete(id: currentRow.cells['id']!.value)) {
          _resumoModelList.removeWhere(((t) => t.id == currentRow.cells['id']!.value));
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }

  Future<void> doSummary() async {
    showQuestionDialog('Deseja processar o resumo? Os valores serão apagados!', () async {
      await resumoRepository.doSummary(mesAno.padLeft(7, '0')).then((data) async {
        await loadData();
      });
    });
  }

  Future<void> saveChanges() async {
		List<ResumoModel> resumoList = [];

		// Percorrer as linhas da PlutoGrid e converter para ResumoModel
		for (var row in plutoGridStateManager.rows) {
			final resumoModel = ResumoModel(
				id: row.cells['id']!.value,
				receitaDespesa: row.cells['receitaDespesa']!.value,
				codigo: row.cells['codigo']!.value,
				descricao: row.cells['descricao']!.value,
				valorOrcado: row.cells['valorOrcado']!.value,
				valorRealizado: row.cells['valorRealizado']!.value,
				mesAno: mesAno.padLeft(7, '0'),
			);

			// Adicionar na lista para salvar depois
			resumoList.add(resumoModel);
		}

		// Salvar todas as alterações no banco
		await resumoRepository.saveAll(resumoList);

    hasChanges.value = false;
  }

	Future<void> doCalculateValues() async {
    showQuestionDialog('Deseja processar e calcular os valores do resumo?', () async {
			await saveChanges();
			final filter = Util.applyMonthYearToFilter(mesAno, Filter());
      await resumoRepository.calculateSummarryForAMonth(mesAno.padLeft(7, '0'), filter).then((data) async {
        await loadData();
      });


      // Recarregar os dados
      // await loadData();

      // Atualizar o saldo na tela
      // saldo = (totalRealizadoReceitas - totalRealizadoDespesas);
    });
  }

  Future<void> calculateSummaryValues() async {
	}

  // edit page
  final scrollController = ScrollController();
  final codigoController = TextEditingController();
  final descricaoController = TextEditingController();
  final valorOrcadoController = MoneyMaskedTextController();
  final valorRealizadoController = MoneyMaskedTextController();
  final diferencaController = MoneyMaskedTextController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value;

  void objectToPlutoRow() {
    plutoRow.cells['id']?.value = resumoModel.id;
    plutoRow.cells['receitaDespesa']?.value = resumoModel.receitaDespesa;
    plutoRow.cells['codigo']?.value = resumoModel.codigo;
    plutoRow.cells['descricao']?.value = resumoModel.descricao;
    plutoRow.cells['valorOrcado']?.value = resumoModel.valorOrcado;
    plutoRow.cells['valorRealizado']?.value = resumoModel.valorRealizado;
    plutoRow.cells['diferenca']?.value = resumoModel.diferenca;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await resumoRepository.save(resumoModel: resumoModel);
        if (result != null) {
          resumoModel = result;
          if (_isInserting) {
            _resumoModelList.add(result);
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
    functionName = "resumo";
    setPrivilege();
    mesAno = mesAno.isEmpty ? "${DateTime.now().month}/${DateTime.now().year}" : mesAno;
    super.onInit();
  }

  @override
  void onClose() {
    codigoController.dispose();
    descricaoController.dispose();
    valorOrcadoController.dispose();
    valorRealizadoController.dispose();
    diferencaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose();
    super.onClose();
  }
}

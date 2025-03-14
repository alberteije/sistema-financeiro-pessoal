import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class LancamentoDespesaModel {
	int? id;
	int? idContaDespesa;
	int? idMetodoPagamento;
	DateTime? dataDespesa;
	double? valor;
	String? statusDespesa;
	String? historico;
	ContaDespesaModel? contaDespesaModel;
	MetodoPagamentoModel? metodoPagamentoModel;

	LancamentoDespesaModel({
		this.id,
		this.idContaDespesa,
		this.idMetodoPagamento,
		this.dataDespesa,
		this.valor,
		this.statusDespesa,
		this.historico,
		this.contaDespesaModel,
		this.metodoPagamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_despesa',
		'valor',
		'status_despesa',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Despesa',
		'Valor',
		'Status Despesa',
		'Historico',
	];

	LancamentoDespesaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContaDespesa = jsonData['idContaDespesa'];
		idMetodoPagamento = jsonData['idMetodoPagamento'];
		dataDespesa = jsonData['dataDespesa'] != null ? DateTime.tryParse(jsonData['dataDespesa']) : null;
		valor = jsonData['valor']?.toDouble();
		statusDespesa = LancamentoDespesaDomain.getStatusDespesa(jsonData['statusDespesa']);
		historico = jsonData['historico'];
		contaDespesaModel = jsonData['contaDespesaModel'] == null ? ContaDespesaModel() : ContaDespesaModel.fromJson(jsonData['contaDespesaModel']);
		metodoPagamentoModel = jsonData['metodoPagamentoModel'] == null ? MetodoPagamentoModel() : MetodoPagamentoModel.fromJson(jsonData['metodoPagamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContaDespesa'] = idContaDespesa != 0 ? idContaDespesa : null;
		jsonData['idMetodoPagamento'] = idMetodoPagamento != 0 ? idMetodoPagamento : null;
		jsonData['dataDespesa'] = dataDespesa != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDespesa!) : null;
		jsonData['valor'] = valor;
		jsonData['statusDespesa'] = LancamentoDespesaDomain.setStatusDespesa(statusDespesa);
		jsonData['historico'] = historico;
		jsonData['contaDespesaModel'] = contaDespesaModel?.toJson;
		jsonData['metodoPagamentoModel'] = metodoPagamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContaDespesa = plutoRow.cells['idContaDespesa']?.value;
		idMetodoPagamento = plutoRow.cells['idMetodoPagamento']?.value;
		dataDespesa = Util.stringToDate(plutoRow.cells['dataDespesa']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		statusDespesa = plutoRow.cells['statusDespesa']?.value != '' ? plutoRow.cells['statusDespesa']?.value : 'Pago';
		historico = plutoRow.cells['historico']?.value;
		contaDespesaModel = ContaDespesaModel();
		contaDespesaModel?.descricao = plutoRow.cells['contaDespesaModel']?.value;
		metodoPagamentoModel = MetodoPagamentoModel();
		metodoPagamentoModel?.descricao = plutoRow.cells['metodoPagamentoModel']?.value;
	}	

	LancamentoDespesaModel clone() {
		return LancamentoDespesaModel(
			id: id,
			idContaDespesa: idContaDespesa,
			idMetodoPagamento: idMetodoPagamento,
			dataDespesa: dataDespesa,
			valor: valor,
			statusDespesa: statusDespesa,
			historico: historico,
		);			
	}

	
}
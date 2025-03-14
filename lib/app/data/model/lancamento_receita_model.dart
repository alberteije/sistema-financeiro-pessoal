import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class LancamentoReceitaModel {
	int? id;
	int? idContaReceita;
	int? idMetodoPagamento;
	DateTime? dataReceita;
	double? valor;
	String? statusReceita;
	String? historico;
	ContaReceitaModel? contaReceitaModel;
	MetodoPagamentoModel? metodoPagamentoModel;

	LancamentoReceitaModel({
		this.id,
		this.idContaReceita,
		this.idMetodoPagamento,
		this.dataReceita,
		this.valor,
		this.statusReceita,
		this.historico,
		this.contaReceitaModel,
		this.metodoPagamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_receita',
		'valor',
		'status_receita',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Receita',
		'Valor',
		'Status Receita',
		'Historico',
	];

	LancamentoReceitaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContaReceita = jsonData['idContaReceita'];
		idMetodoPagamento = jsonData['idMetodoPagamento'];
		dataReceita = jsonData['dataReceita'] != null ? DateTime.tryParse(jsonData['dataReceita']) : null;
		valor = jsonData['valor']?.toDouble();
		statusReceita = LancamentoReceitaDomain.getStatusReceita(jsonData['statusReceita']);
		historico = jsonData['historico'];
		contaReceitaModel = jsonData['contaReceitaModel'] == null ? ContaReceitaModel() : ContaReceitaModel.fromJson(jsonData['contaReceitaModel']);
		metodoPagamentoModel = jsonData['metodoPagamentoModel'] == null ? MetodoPagamentoModel() : MetodoPagamentoModel.fromJson(jsonData['metodoPagamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContaReceita'] = idContaReceita != 0 ? idContaReceita : null;
		jsonData['idMetodoPagamento'] = idMetodoPagamento != 0 ? idMetodoPagamento : null;
		jsonData['dataReceita'] = dataReceita != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataReceita!) : null;
		jsonData['valor'] = valor;
		jsonData['statusReceita'] = LancamentoReceitaDomain.setStatusReceita(statusReceita);
		jsonData['historico'] = historico;
		jsonData['contaReceitaModel'] = contaReceitaModel?.toJson;
		jsonData['metodoPagamentoModel'] = metodoPagamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContaReceita = plutoRow.cells['idContaReceita']?.value;
		idMetodoPagamento = plutoRow.cells['idMetodoPagamento']?.value;
		dataReceita = Util.stringToDate(plutoRow.cells['dataReceita']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
		statusReceita = plutoRow.cells['statusReceita']?.value != '' ? plutoRow.cells['statusReceita']?.value : 'Recebido';
		historico = plutoRow.cells['historico']?.value;
		contaReceitaModel = ContaReceitaModel();
		contaReceitaModel?.descricao = plutoRow.cells['contaReceitaModel']?.value;
		metodoPagamentoModel = MetodoPagamentoModel();
		metodoPagamentoModel?.descricao = plutoRow.cells['metodoPagamentoModel']?.value;
	}	

	LancamentoReceitaModel clone() {
		return LancamentoReceitaModel(
			id: id,
			idContaReceita: idContaReceita,
			idMetodoPagamento: idMetodoPagamento,
			dataReceita: dataReceita,
			valor: valor,
			statusReceita: statusReceita,
			historico: historico,
		);			
	}

	
}
import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class ResumoModel {
	int? id;
  String? mesAno;
	String? receitaDespesa;
	String? codigo;
	String? descricao;
	double? valorOrcado;
	double? valorRealizado;
	double? diferenca;

	ResumoModel({
		this.id,
    this.mesAno,
		this.receitaDespesa,
		this.codigo,
		this.descricao,
		this.valorOrcado,
		this.valorRealizado,
		this.diferenca,
	});

	static List<String> dbColumns = <String>[
		'id',
    'mes_ano',
		'receita_despesa',
		'codigo',
		'descricao',
		'valor_orcado',
		'valor_realizado',
		'diferenca',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
    'Mês/Ano'
		'Receita Despesa',
		'Codigo',
		'Descricao',
		'Valor Orcado',
		'Valor Realizado',
		'Diferenca',
	];

	ResumoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
    mesAno = jsonData['mesAno'];
		receitaDespesa = ResumoDomain.getReceitaDespesa(jsonData['receitaDespesa']);
		codigo = jsonData['codigo'];
		descricao = jsonData['descricao'];
		valorOrcado = jsonData['valorOrcado']?.toDouble();
		valorRealizado = jsonData['valorRealizado']?.toDouble();
		diferenca = jsonData['diferenca']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['receitaDespesa'] = ResumoDomain.setReceitaDespesa(receitaDespesa);
    jsonData['mesAno'] = mesAno;
		jsonData['codigo'] = codigo;
		jsonData['descricao'] = descricao;
		jsonData['valorOrcado'] = valorOrcado;
		jsonData['valorRealizado'] = valorRealizado;
		jsonData['diferenca'] = diferenca;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		receitaDespesa = plutoRow.cells['receitaDespesa']?.value != '' ? plutoRow.cells['receitaDespesa']?.value : 'Receita';
    mesAno = plutoRow.cells['mesAno']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		valorOrcado = plutoRow.cells['valorOrcado']?.value?.toDouble();
		valorRealizado = plutoRow.cells['valorRealizado']?.value?.toDouble();
		diferenca = plutoRow.cells['diferenca']?.value?.toDouble();
	}	

	ResumoModel clone() {
		return ResumoModel(
			id: id,
      mesAno: mesAno,
			receitaDespesa: receitaDespesa,
			codigo: codigo,
			descricao: descricao,
			valorOrcado: valorOrcado,
			valorRealizado: valorRealizado,
			diferenca: diferenca,
		);			
	}

	
}
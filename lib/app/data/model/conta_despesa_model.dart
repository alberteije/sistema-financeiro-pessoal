import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class ContaDespesaModel {
	int? id;
	String? codigo;
	String? descricao;

	ContaDespesaModel({
		this.id,
		this.codigo,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Descricao',
	];

	ContaDespesaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	ContaDespesaModel clone() {
		return ContaDespesaModel(
			id: id,
			codigo: codigo,
			descricao: descricao,
		);			
	}

	
}
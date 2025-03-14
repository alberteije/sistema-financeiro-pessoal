import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class UsuarioModel {
	int? id;
	String? login;
	String? senha;

	UsuarioModel({
		this.id,
		this.login,
		this.senha,
	});

	static List<String> dbColumns = <String>[
		'id',
		'login',
		'senha',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Login',
		'Senha',
	];

	UsuarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		login = jsonData['login'];
		senha = jsonData['senha'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['login'] = login;
		jsonData['senha'] = senha;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		login = plutoRow.cells['login']?.value;
		senha = plutoRow.cells['senha']?.value;
	}	

	UsuarioModel clone() {
		return UsuarioModel(
			id: id,
			login: login,
			senha: senha,
		);			
	}

	
}
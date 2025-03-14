import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("Usuario")
class Usuarios extends Table {
	@override
	String get tableName => 'usuario';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get login => text().named('login').withLength(min: 0, max: 100).nullable()();
	TextColumn get senha => text().named('senha').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class UsuarioGrouped {
	Usuario? usuario; 

  UsuarioGrouped({
		this.usuario, 

  });
}

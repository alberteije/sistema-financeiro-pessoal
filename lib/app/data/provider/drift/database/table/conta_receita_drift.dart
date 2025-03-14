import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("ContaReceita")
class ContaReceitas extends Table {
	@override
	String get tableName => 'conta_receita';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContaReceitaGrouped {
	ContaReceita? contaReceita; 

  ContaReceitaGrouped({
		this.contaReceita, 

  });
}

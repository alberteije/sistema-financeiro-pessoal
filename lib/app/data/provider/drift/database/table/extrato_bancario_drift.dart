import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("ExtratoBancario")
class ExtratoBancarios extends Table {
	@override
	String get tableName => 'extrato_bancario';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataTransacao => dateTime().named('data_transacao').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get idTransacao => text().named('id_transacao').withLength(min: 0, max: 30).nullable()();
	TextColumn get checknum => text().named('checknum').withLength(min: 0, max: 20).nullable()();
	TextColumn get numeroReferencia => text().named('numero_referencia').withLength(min: 0, max: 32).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 100).nullable()();
	TextColumn get conciliado => text().named('conciliado').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ExtratoBancarioGrouped {
	ExtratoBancario? extratoBancario; 

  ExtratoBancarioGrouped({
		this.extratoBancario, 

  });
}

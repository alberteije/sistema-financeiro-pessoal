import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("MetodoPagamento")
class MetodoPagamentos extends Table {
	@override
	String get tableName => 'metodo_pagamento';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MetodoPagamentoGrouped {
	MetodoPagamento? metodoPagamento; 

  MetodoPagamentoGrouped({
		this.metodoPagamento, 

  });
}

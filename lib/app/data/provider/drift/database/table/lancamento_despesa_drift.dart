import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("LancamentoDespesa")
class LancamentoDespesas extends Table {
	@override
	String get tableName => 'lancamento_despesa';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContaDespesa => integer().named('id_conta_despesa').nullable()();
	IntColumn get idMetodoPagamento => integer().named('id_metodo_pagamento').nullable()();
	DateTimeColumn get dataDespesa => dateTime().named('data_despesa').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get statusDespesa => text().named('status_despesa').withLength(min: 0, max: 1).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 500).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class LancamentoDespesaGrouped {
	LancamentoDespesa? lancamentoDespesa; 
	ContaDespesa? contaDespesa; 
	MetodoPagamento? metodoPagamento; 

  LancamentoDespesaGrouped({
		this.lancamentoDespesa, 
		this.contaDespesa, 
		this.metodoPagamento, 

  });
}

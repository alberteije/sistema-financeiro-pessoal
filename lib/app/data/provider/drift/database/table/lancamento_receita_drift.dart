import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("LancamentoReceita")
class LancamentoReceitas extends Table {
	@override
	String get tableName => 'lancamento_receita';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContaReceita => integer().named('id_conta_receita').nullable()();
	IntColumn get idMetodoPagamento => integer().named('id_metodo_pagamento').nullable()();
	DateTimeColumn get dataReceita => dateTime().named('data_receita').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get statusReceita => text().named('status_receita').withLength(min: 0, max: 1).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 500).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class LancamentoReceitaGrouped {
	LancamentoReceita? lancamentoReceita; 
	ContaReceita? contaReceita; 
	MetodoPagamento? metodoPagamento; 

  LancamentoReceitaGrouped({
		this.lancamentoReceita, 
		this.contaReceita, 
		this.metodoPagamento, 

  });
}

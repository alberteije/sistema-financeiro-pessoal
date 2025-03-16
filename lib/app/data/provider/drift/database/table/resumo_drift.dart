import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

@DataClassName("Resumo")
class Resumos extends Table {
	@override
	String get tableName => 'resumo';

	IntColumn get id => integer().named('id').nullable()();
  TextColumn get mesAno => text().named('mes_ano').withLength(min: 0, max: 7).nullable()();
	TextColumn get receitaDespesa => text().named('receita_despesa').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 50).nullable()();
	RealColumn get valorOrcado => real().named('valor_orcado').nullable()();
	RealColumn get valorRealizado => real().named('valor_realizado').nullable()();
	RealColumn get diferenca => real().named('diferenca').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ResumoGrouped {
	Resumo? resumo; 

  ResumoGrouped({
		this.resumo, 

  });
}

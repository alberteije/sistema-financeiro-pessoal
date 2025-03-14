import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'lancamento_receita_dao.g.dart';

@DriftAccessor(tables: [
	LancamentoReceitas,
	ContaReceitas,
	MetodoPagamentos,
])
class LancamentoReceitaDao extends DatabaseAccessor<AppDatabase> with _$LancamentoReceitaDaoMixin {
	final AppDatabase db;

	List<LancamentoReceita> lancamentoReceitaList = []; 
	List<LancamentoReceitaGrouped> lancamentoReceitaGroupedList = []; 

	LancamentoReceitaDao(this.db) : super(db);

	Future<List<LancamentoReceita>> getList() async {
		lancamentoReceitaList = await select(lancamentoReceitas).get();
		return lancamentoReceitaList;
	}

	Future<List<LancamentoReceita>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		lancamentoReceitaList = await (select(lancamentoReceitas)..where((t) => expression)).get();
		return lancamentoReceitaList;	 
	}

	Future<List<LancamentoReceitaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(lancamentoReceitas)
			.join([ 
				leftOuterJoin(contaReceitas, contaReceitas.id.equalsExp(lancamentoReceitas.idContaReceita)), 
			]).join([ 
				leftOuterJoin(metodoPagamentos, metodoPagamentos.id.equalsExp(lancamentoReceitas.idMetodoPagamento)), 
			]);

		if (field != null && field != '') { 
			final column = lancamentoReceitas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		lancamentoReceitaGroupedList = await query.map((row) {
			final lancamentoReceita = row.readTableOrNull(lancamentoReceitas); 
			final contaReceita = row.readTableOrNull(contaReceitas); 
			final metodoPagamento = row.readTableOrNull(metodoPagamentos); 

			return LancamentoReceitaGrouped(
				lancamentoReceita: lancamentoReceita, 
				contaReceita: contaReceita, 
				metodoPagamento: metodoPagamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var lancamentoReceitaGrouped in lancamentoReceitaGroupedList) {
		//}		

		return lancamentoReceitaGroupedList;	
	}

	Future<LancamentoReceita?> getObject(dynamic pk) async {
		return await (select(lancamentoReceitas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<LancamentoReceita?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM lancamento_receita WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as LancamentoReceita;		 
	} 

	Future<LancamentoReceitaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(LancamentoReceitaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.lancamentoReceita = object.lancamentoReceita!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(lancamentoReceitas).insert(object.lancamentoReceita!);
			object.lancamentoReceita = object.lancamentoReceita!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(LancamentoReceitaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(lancamentoReceitas).replace(object.lancamentoReceita!);
		});	 
	} 

	Future<int> deleteObject(LancamentoReceitaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(lancamentoReceitas).delete(object.lancamentoReceita!);
		});		
	}

	Future<void> insertChildren(LancamentoReceitaGrouped object) async {
	}
	
	Future<void> deleteChildren(LancamentoReceitaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from lancamento_receita").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
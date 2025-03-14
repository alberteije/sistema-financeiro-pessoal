import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'lancamento_despesa_dao.g.dart';

@DriftAccessor(tables: [
	LancamentoDespesas,
	ContaDespesas,
	MetodoPagamentos,
])
class LancamentoDespesaDao extends DatabaseAccessor<AppDatabase> with _$LancamentoDespesaDaoMixin {
	final AppDatabase db;

	List<LancamentoDespesa> lancamentoDespesaList = []; 
	List<LancamentoDespesaGrouped> lancamentoDespesaGroupedList = []; 

	LancamentoDespesaDao(this.db) : super(db);

	Future<List<LancamentoDespesa>> getList() async {
		lancamentoDespesaList = await select(lancamentoDespesas).get();
		return lancamentoDespesaList;
	}

	Future<List<LancamentoDespesa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		lancamentoDespesaList = await (select(lancamentoDespesas)..where((t) => expression)).get();
		return lancamentoDespesaList;	 
	}

	Future<List<LancamentoDespesaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(lancamentoDespesas)
			.join([ 
				leftOuterJoin(contaDespesas, contaDespesas.id.equalsExp(lancamentoDespesas.idContaDespesa)), 
			]).join([ 
				leftOuterJoin(metodoPagamentos, metodoPagamentos.id.equalsExp(lancamentoDespesas.idMetodoPagamento)), 
			]);

		if (field != null && field != '') { 
			final column = lancamentoDespesas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		lancamentoDespesaGroupedList = await query.map((row) {
			final lancamentoDespesa = row.readTableOrNull(lancamentoDespesas); 
			final contaDespesa = row.readTableOrNull(contaDespesas); 
			final metodoPagamento = row.readTableOrNull(metodoPagamentos); 

			return LancamentoDespesaGrouped(
				lancamentoDespesa: lancamentoDespesa, 
				contaDespesa: contaDespesa, 
				metodoPagamento: metodoPagamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var lancamentoDespesaGrouped in lancamentoDespesaGroupedList) {
		//}		

		return lancamentoDespesaGroupedList;	
	}

	Future<LancamentoDespesa?> getObject(dynamic pk) async {
		return await (select(lancamentoDespesas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<LancamentoDespesa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM lancamento_despesa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as LancamentoDespesa;		 
	} 

	Future<LancamentoDespesaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(LancamentoDespesaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.lancamentoDespesa = object.lancamentoDespesa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(lancamentoDespesas).insert(object.lancamentoDespesa!);
			object.lancamentoDespesa = object.lancamentoDespesa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(LancamentoDespesaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(lancamentoDespesas).replace(object.lancamentoDespesa!);
		});	 
	} 

	Future<int> deleteObject(LancamentoDespesaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(lancamentoDespesas).delete(object.lancamentoDespesa!);
		});		
	}

	Future<void> insertChildren(LancamentoDespesaGrouped object) async {
	}
	
	Future<void> deleteChildren(LancamentoDespesaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from lancamento_despesa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
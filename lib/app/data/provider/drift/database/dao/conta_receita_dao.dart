import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'conta_receita_dao.g.dart';

@DriftAccessor(tables: [
	ContaReceitas,
])
class ContaReceitaDao extends DatabaseAccessor<AppDatabase> with _$ContaReceitaDaoMixin {
	final AppDatabase db;

	List<ContaReceita> contaReceitaList = []; 
	List<ContaReceitaGrouped> contaReceitaGroupedList = []; 

	ContaReceitaDao(this.db) : super(db);

	Future<List<ContaReceita>> getList() async {
		contaReceitaList = await select(contaReceitas).get();
		return contaReceitaList;
	}

	Future<List<ContaReceita>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contaReceitaList = await (select(contaReceitas)..where((t) => expression)).get();
		return contaReceitaList;	 
	}

	Future<List<ContaReceitaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contaReceitas)
			.join([]);

		if (field != null && field != '') { 
			final column = contaReceitas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contaReceitaGroupedList = await query.map((row) {
			final contaReceita = row.readTableOrNull(contaReceitas); 

			return ContaReceitaGrouped(
				contaReceita: contaReceita, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contaReceitaGrouped in contaReceitaGroupedList) {
		//}		

		return contaReceitaGroupedList;	
	}

	Future<ContaReceita?> getObject(dynamic pk) async {
		return await (select(contaReceitas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContaReceita?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM conta_receita WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContaReceita;		 
	} 

	Future<ContaReceitaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContaReceitaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contaReceita = object.contaReceita!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contaReceitas).insert(object.contaReceita!);
			object.contaReceita = object.contaReceita!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContaReceitaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contaReceitas).replace(object.contaReceita!);
		});	 
	} 

	Future<int> deleteObject(ContaReceitaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contaReceitas).delete(object.contaReceita!);
		});		
	}

	Future<void> insertChildren(ContaReceitaGrouped object) async {
	}
	
	Future<void> deleteChildren(ContaReceitaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from conta_receita").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
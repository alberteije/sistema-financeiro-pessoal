import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'conta_despesa_dao.g.dart';

@DriftAccessor(tables: [
	ContaDespesas,
])
class ContaDespesaDao extends DatabaseAccessor<AppDatabase> with _$ContaDespesaDaoMixin {
	final AppDatabase db;

	List<ContaDespesa> contaDespesaList = []; 
	List<ContaDespesaGrouped> contaDespesaGroupedList = []; 

	ContaDespesaDao(this.db) : super(db);

	Future<List<ContaDespesa>> getList() async {
		contaDespesaList = await select(contaDespesas).get();
		return contaDespesaList;
	}

	Future<List<ContaDespesa>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		contaDespesaList = await (select(contaDespesas)..where((t) => expression)).get();
		return contaDespesaList;	 
	}

	Future<List<ContaDespesaGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(contaDespesas)
			.join([]);

		if (field != null && field != '') { 
			final column = contaDespesas.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		contaDespesaGroupedList = await query.map((row) {
			final contaDespesa = row.readTableOrNull(contaDespesas); 

			return ContaDespesaGrouped(
				contaDespesa: contaDespesa, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var contaDespesaGrouped in contaDespesaGroupedList) {
		//}		

		return contaDespesaGroupedList;	
	}

	Future<ContaDespesa?> getObject(dynamic pk) async {
		return await (select(contaDespesas)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ContaDespesa?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM conta_despesa WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ContaDespesa;		 
	} 

	Future<ContaDespesaGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ContaDespesaGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.contaDespesa = object.contaDespesa!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(contaDespesas).insert(object.contaDespesa!);
			object.contaDespesa = object.contaDespesa!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ContaDespesaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(contaDespesas).replace(object.contaDespesa!);
		});	 
	} 

	Future<int> deleteObject(ContaDespesaGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(contaDespesas).delete(object.contaDespesa!);
		});		
	}

	Future<void> insertChildren(ContaDespesaGrouped object) async {
	}
	
	Future<void> deleteChildren(ContaDespesaGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from conta_despesa").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
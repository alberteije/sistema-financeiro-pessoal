import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'extrato_bancario_dao.g.dart';

@DriftAccessor(tables: [
	ExtratoBancarios,
])
class ExtratoBancarioDao extends DatabaseAccessor<AppDatabase> with _$ExtratoBancarioDaoMixin {
	final AppDatabase db;

	List<ExtratoBancario> extratoBancarioList = []; 
	List<ExtratoBancarioGrouped> extratoBancarioGroupedList = []; 

	ExtratoBancarioDao(this.db) : super(db);

	Future<List<ExtratoBancario>> getList() async {
		extratoBancarioList = await select(extratoBancarios).get();
		return extratoBancarioList;
	}

	Future<List<ExtratoBancario>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		extratoBancarioList = await (select(extratoBancarios)..where((t) => expression)).get();
		return extratoBancarioList;	 
	}

	Future<List<ExtratoBancarioGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(extratoBancarios)
			.join([]);

		if (field != null && field != '') { 
			final column = extratoBancarios.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		extratoBancarioGroupedList = await query.map((row) {
			final extratoBancario = row.readTableOrNull(extratoBancarios); 

			return ExtratoBancarioGrouped(
				extratoBancario: extratoBancario, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var extratoBancarioGrouped in extratoBancarioGroupedList) {
		//}		

		return extratoBancarioGroupedList;	
	}

	Future<ExtratoBancario?> getObject(dynamic pk) async {
		return await (select(extratoBancarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<ExtratoBancario?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM extrato_bancario WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as ExtratoBancario;		 
	} 

	Future<ExtratoBancarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ExtratoBancarioGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.extratoBancario = object.extratoBancario!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(extratoBancarios).insert(object.extratoBancario!);
			object.extratoBancario = object.extratoBancario!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ExtratoBancarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(extratoBancarios).replace(object.extratoBancario!);
		});	 
	} 

	Future<int> deleteObject(ExtratoBancarioGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(extratoBancarios).delete(object.extratoBancario!);
		});		
	}

	Future<void> insertChildren(ExtratoBancarioGrouped object) async {
	}
	
	Future<void> deleteChildren(ExtratoBancarioGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from extrato_bancario").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
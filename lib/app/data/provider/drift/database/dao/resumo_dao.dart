import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'resumo_dao.g.dart';

@DriftAccessor(tables: [
	Resumos,
])
class ResumoDao extends DatabaseAccessor<AppDatabase> with _$ResumoDaoMixin {
	final AppDatabase db;

	List<Resumo> resumoList = []; 
	List<ResumoGrouped> resumoGroupedList = []; 

	ResumoDao(this.db) : super(db);

	Future<List<Resumo>> getList() async {
		resumoList = await select(resumos).get();
		return resumoList;
	}

	Future<List<Resumo>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		resumoList = await (select(resumos)..where((t) => expression)).get();
		return resumoList;	 
	}

	Future<List<ResumoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(resumos)
			.join([]);

		if (field != null && field != '') { 
			final column = resumos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		resumoGroupedList = await query.map((row) {
			final resumo = row.readTableOrNull(resumos); 

			return ResumoGrouped(
				resumo: resumo, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var resumoGrouped in resumoGroupedList) {
		//}		

		return resumoGroupedList;	
	}

	Future<Resumo?> getObject(dynamic pk) async {
		return await (select(resumos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<Resumo?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM resumo WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as Resumo;		 
	} 

	Future<ResumoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(ResumoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.resumo = object.resumo!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(resumos).insert(object.resumo!);
			object.resumo = object.resumo!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(ResumoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(resumos).replace(object.resumo!);
		});	 
	} 

	Future<int> deleteObject(ResumoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(resumos).delete(object.resumo!);
		});		
	}

	Future<void> insertChildren(ResumoGrouped object) async {
	}
	
	Future<void> deleteChildren(ResumoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from resumo").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
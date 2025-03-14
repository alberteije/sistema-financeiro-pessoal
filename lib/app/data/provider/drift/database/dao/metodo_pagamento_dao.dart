import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'metodo_pagamento_dao.g.dart';

@DriftAccessor(tables: [
	MetodoPagamentos,
])
class MetodoPagamentoDao extends DatabaseAccessor<AppDatabase> with _$MetodoPagamentoDaoMixin {
	final AppDatabase db;

	List<MetodoPagamento> metodoPagamentoList = []; 
	List<MetodoPagamentoGrouped> metodoPagamentoGroupedList = []; 

	MetodoPagamentoDao(this.db) : super(db);

	Future<List<MetodoPagamento>> getList() async {
		metodoPagamentoList = await select(metodoPagamentos).get();
		return metodoPagamentoList;
	}

	Future<List<MetodoPagamento>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		metodoPagamentoList = await (select(metodoPagamentos)..where((t) => expression)).get();
		return metodoPagamentoList;	 
	}

	Future<List<MetodoPagamentoGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(metodoPagamentos)
			.join([]);

		if (field != null && field != '') { 
			final column = metodoPagamentos.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		metodoPagamentoGroupedList = await query.map((row) {
			final metodoPagamento = row.readTableOrNull(metodoPagamentos); 

			return MetodoPagamentoGrouped(
				metodoPagamento: metodoPagamento, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var metodoPagamentoGrouped in metodoPagamentoGroupedList) {
		//}		

		return metodoPagamentoGroupedList;	
	}

	Future<MetodoPagamento?> getObject(dynamic pk) async {
		return await (select(metodoPagamentos)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<MetodoPagamento?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM metodo_pagamento WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as MetodoPagamento;		 
	} 

	Future<MetodoPagamentoGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(MetodoPagamentoGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.metodoPagamento = object.metodoPagamento!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(metodoPagamentos).insert(object.metodoPagamento!);
			object.metodoPagamento = object.metodoPagamento!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(MetodoPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(metodoPagamentos).replace(object.metodoPagamento!);
		});	 
	} 

	Future<int> deleteObject(MetodoPagamentoGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(metodoPagamentos).delete(object.metodoPagamento!);
		});		
	}

	Future<void> insertChildren(MetodoPagamentoGrouped object) async {
	}
	
	Future<void> deleteChildren(MetodoPagamentoGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from metodo_pagamento").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}
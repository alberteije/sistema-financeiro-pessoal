import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';

part 'extrato_bancario_dao.g.dart';

@DriftAccessor(tables: [
	ExtratoBancarios,
  LancamentoReceitas,
  LancamentoDespesas,
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

	Future<List<ExtratoBancarioGrouped>> getGroupedList({required Filter filter}) async {
		final query = select(extratoBancarios)
			.join([]);

      query.where(extratoBancarios.dataTransacao.isBetweenValues(filter.dateIni!, filter.dateEnd!));

    if (filter.field != null && filter.field != '') {
      final column = extratoBancarios.$columns.where(((column) => column.$name == filter.field)).first;
      if (column is TextColumn) {
        query.where((column as TextColumn).like('%$filter.value%'));
      } else if (column is IntColumn) {
        query.where(column.equals(int.tryParse(filter.value!) as Object));
      } else if (column is RealColumn) {
        query.where(column.equals(double.tryParse(filter.value!) as Object));
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
		final result = await getGroupedList(filter: Filter(field: field, value: value));

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

  Future<int> deleteByDateRange(Filter filter) async {
    if (filter.dateIni == null || filter.dateEnd == null) return 0;

    return (delete(extratoBancarios)
          ..where((t) => 
              t.dataTransacao.isBiggerOrEqualValue(filter.dateIni!) & 
              t.dataTransacao.isSmallerOrEqualValue(filter.dateEnd!)))
        .go();
  }

  Future<void> exportDataToIncomesAndExpenses(Filter filter) async {
    if (filter.dateIni == null || filter.dateEnd == null) {
      showErrorSnackBar(message: "Período inválido! Defina uma data inicial e final.");
      return;
    }

    // Buscar os lançamentos do extrato bancário dentro do período informado
    final extratos = await (select(extratoBancarios)
          ..where((tbl) => tbl.dataTransacao.isBetweenValues(filter.dateIni!, filter.dateEnd!)))
        .get();

    if (extratos.isEmpty) {
      showErrorSnackBar(message: "Nenhum lançamento encontrado no período selecionado.");
      return;
    }

    // Criar listas para receitas e despesas
    final List<LancamentoReceitasCompanion> novasReceitas = [];
    final List<LancamentoDespesasCompanion> novasDespesas = [];

    for (final extrato in extratos) {
      final valor = extrato.valor;
      if (valor == 0) continue; // Ignorar valores zero

      if (valor! > 0) {
        // Criar um lançamento de receita
        novasReceitas.add(LancamentoReceitasCompanion.insert(
          dataReceita: Value(extrato.dataTransacao),
          valor: Value(valor),
          statusReceita: const Value("R"),
          historico: Value(extrato.historico),
        ));
      } else {
        // Criar um lançamento de despesa
        novasDespesas.add(LancamentoDespesasCompanion.insert(
          dataDespesa: Value(extrato.dataTransacao),
          valor: Value(valor.abs()), // Transforma em positivo
          statusDespesa: const Value("P"),
          historico: Value(extrato.historico),
        ));
      }
    }

    // Inserir os novos lançamentos no banco de dados
    await batch((batch) {
      if (novasReceitas.isNotEmpty) {
        batch.insertAll(lancamentoReceitas, novasReceitas);
      }
      if (novasDespesas.isNotEmpty) {
        batch.insertAll(lancamentoDespesas, novasDespesas);
      }
    });

    showInfoSnackBar(message: "Lançamentos exportados com sucesso para o período selecionado!");
  }

  Future<void> reconcileTransactions(Filter filter) async {
    if (filter.dateIni == null || filter.dateEnd == null) {
      showErrorSnackBar(message: "Período inválido! Defina uma data inicial e final.");
      return;
    }

    // Buscar os lançamentos do extrato bancário dentro do período informado
    final extratos = await (select(extratoBancarios)
          ..where((tbl) => tbl.dataTransacao.isBetweenValues(filter.dateIni!, filter.dateEnd!)))
        .get();

    if (extratos.isEmpty) {
      showErrorSnackBar(message: "Nenhum lançamento encontrado no período selecionado.");
      return;
    }

    for (final extrato in extratos) {
      final valor = extrato.valor;
      bool encontrado = false;

      if (valor! > 0) {
        // Procurar o valor nas receitas
        final receitas = await (select(lancamentoReceitas)
              ..where((tbl) =>
                  tbl.valor.equals(valor) &
                  tbl.dataReceita.isBetweenValues(filter.dateIni!, filter.dateEnd!)))
            .get(); // Obtenha todos os registros correspondentes
        encontrado = receitas.isNotEmpty; // Verifica se pelo menos um registro foi encontrado
      } else {
        // Procurar o valor (absoluto) nas despesas
        final despesas = await (select(lancamentoDespesas)
              ..where((tbl) =>
                  tbl.valor.equals(valor.abs()) &
                  tbl.dataDespesa.isBetweenValues(filter.dateIni!, filter.dateEnd!)))
            .get(); // Obtenha todos os registros correspondentes
        encontrado = despesas.isNotEmpty; // Verifica se pelo menos um registro foi encontrado
      }

      // Atualizar o status de conciliação no extrato
      await (update(extratoBancarios)
            ..where((tbl) => tbl.id.equals(extrato.id!)))
          .write(ExtratoBancariosCompanion(
            conciliado: Value(encontrado ? "S" : "N"),
          ));
    }

    showInfoSnackBar(message: "Conciliação concluída com sucesso!");
  }

}
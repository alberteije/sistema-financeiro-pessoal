import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';

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

  Future<List<LancamentoDespesaGrouped>> getGroupedList({required Filter filter}) async {
    final query = select(lancamentoDespesas).join([
      leftOuterJoin(contaDespesas, contaDespesas.id.equalsExp(lancamentoDespesas.idContaDespesa)),
    ]).join([
      leftOuterJoin(metodoPagamentos, metodoPagamentos.id.equalsExp(lancamentoDespesas.idMetodoPagamento)),
    ]);

    query.where(lancamentoDespesas.dataDespesa.isBetweenValues(filter.dateIni!, filter.dateEnd!));

    if (filter.field != null && filter.field != '') {
      final column = lancamentoDespesas.$columns.where(((column) => column.$name == filter.field)).first;
      if (column is TextColumn) {
        query.where((column as TextColumn).like('%$filter.value%'));
      } else if (column is IntColumn) {
        query.where(column.equals(int.tryParse(filter.value!) as Object));
      } else if (column is RealColumn) {
        query.where(column.equals(double.tryParse(filter.value!) as Object));
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
    final result = await getGroupedList(filter: Filter(field: field, value: value));

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

  Future<void> insertChildren(LancamentoDespesaGrouped object) async {}

  Future<void> deleteChildren(LancamentoDespesaGrouped object) async {}

  Future<int> lastPk() async {
    final result = await customSelect("select MAX(id) as LAST from lancamento_despesa").getSingleOrNull();
    return result?.data["LAST"] ?? 0;
  }

  Future<void> transferDataFromOtherMonth(String selectedDate, String targetDate) async {
    final oldParts = selectedDate.split('/');
    final newParts = targetDate.split('/');

    final oldMonth = int.tryParse(oldParts[0]);
    final oldYear = int.tryParse(oldParts[1]);
    final newMonth = int.tryParse(newParts[0]);
    final newYear = int.tryParse(newParts[1]);

    if (oldMonth == null || oldYear == null || newMonth == null || newYear == null) {
      showErrorSnackBar(message: "Formato inválido! Use MM/AAAA.");
      return;
    }

    // Buscar os lançamentos existentes para o mês/ano informado
    final lancamentos = await (select(lancamentoDespesas)
          ..where((tbl) =>
              tbl.dataDespesa.isNotNull() &
              tbl.dataDespesa.year.equals(oldYear) &
              tbl.dataDespesa.month.equals(oldMonth)))
        .get(); // Obtém os registros diretamente

    if (lancamentos.isEmpty) {
      showErrorSnackBar(message: "Nenhum lançamento encontrado para $selectedDate.");
      return;
    }

    // Criar novas entradas para o mês/ano escolhido pelo usuário
    final novosLancamentos = lancamentos.map((lancamento) {
      final oldDay = lancamento.dataDespesa!.day;

      // Encontrar o último dia válido do mês de destino
      final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;

      // Se o dia original for maior que o último dia do mês de destino, ajustamos
      final adjustedDay = oldDay > lastDayOfNewMonth ? lastDayOfNewMonth : oldDay;

      return LancamentoDespesasCompanion.insert(
        idContaDespesa: Value(lancamento.idContaDespesa),
        idMetodoPagamento: Value(lancamento.idMetodoPagamento),
        dataDespesa: Value(DateTime(newYear, newMonth, adjustedDay)), 
        valor: Value(lancamento.valor),
        statusDespesa: Value(lancamento.statusDespesa),
        historico: Value(lancamento.historico),
      );
    }).toList();

    // Inserir os novos lançamentos
    await batch((batch) {
      batch.insertAll(lancamentoDespesas, novosLancamentos);
    });
  }
}

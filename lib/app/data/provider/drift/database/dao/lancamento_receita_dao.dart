import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';

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

  Future<List<LancamentoReceitaGrouped>> getGroupedList({required Filter filter}) async {
    final query = select(lancamentoReceitas).join([
      leftOuterJoin(contaReceitas, contaReceitas.id.equalsExp(lancamentoReceitas.idContaReceita)),
    ]).join([
      leftOuterJoin(metodoPagamentos, metodoPagamentos.id.equalsExp(lancamentoReceitas.idMetodoPagamento)),
    ]);

    query.where(lancamentoReceitas.dataReceita.isBetweenValues(filter.dateIni!, filter.dateEnd!));

    if (filter.field != null && filter.field != '') {
      final column = lancamentoReceitas.$columns.where(((column) => column.$name == filter.field)).first;
      if (column is TextColumn) {
        query.where((column as TextColumn).like('%$filter.value%'));
      } else if (column is IntColumn) {
        query.where(column.equals(int.tryParse(filter.value!) as Object));
      } else if (column is RealColumn) {
        query.where(column.equals(double.tryParse(filter.value!) as Object));
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
    final result = await getGroupedList(filter: Filter(field: field, value: value));

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

  Future<void> insertChildren(LancamentoReceitaGrouped object) async {}

  Future<void> deleteChildren(LancamentoReceitaGrouped object) async {}

  Future<int> lastPk() async {
    final result = await customSelect("select MAX(id) as LAST from lancamento_receita").getSingleOrNull();
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
    final lancamentos = await (select(lancamentoReceitas)
          ..where((tbl) =>
              tbl.dataReceita.isNotNull() &
              tbl.dataReceita.year.equals(oldYear) &
              tbl.dataReceita.month.equals(oldMonth)))
        .get(); // Obtém os registros diretamente

    if (lancamentos.isEmpty) {
      showErrorSnackBar(message: "Nenhum lançamento encontrado para $selectedDate.");
      return;
    }

    // Criar novas entradas para o mês/ano escolhido pelo usuário
    final novosLancamentos = lancamentos.map((lancamento) {
      final oldDay = lancamento.dataReceita!.day;

      // Encontrar o último dia válido do mês de destino
      final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;

      // Se o dia original for maior que o último dia do mês de destino, ajustamos
      final adjustedDay = oldDay > lastDayOfNewMonth ? lastDayOfNewMonth : oldDay;

      return LancamentoReceitasCompanion.insert(
        idContaReceita: Value(lancamento.idContaReceita),
        idMetodoPagamento: Value(lancamento.idMetodoPagamento),
        dataReceita: Value(DateTime(newYear, newMonth, adjustedDay)),
        valor: Value(lancamento.valor),
        statusReceita: Value(lancamento.statusReceita),
        historico: Value(lancamento.historico),
      );
    }).toList();

    // Inserir os novos lançamentos
    await batch((batch) {
      batch.insertAll(lancamentoReceitas, novosLancamentos);
    });
  }
}

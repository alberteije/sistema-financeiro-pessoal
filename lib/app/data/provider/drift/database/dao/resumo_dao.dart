import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';

part 'resumo_dao.g.dart';

@DriftAccessor(tables: [
  Resumos,
  ContaReceitas,
  ContaDespesas,
  LancamentoReceitas,
  LancamentoDespesas,
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
    final query = select(resumos).join([]);

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

  Future<void> insertChildren(ResumoGrouped object) async {}

  Future<void> deleteChildren(ResumoGrouped object) async {}

  Future<int> lastPk() async {
    final result = await customSelect("select MAX(id) as LAST from resumo").getSingleOrNull();
    return result?.data["LAST"] ?? 0;
  }

  Future<void> doSummary(String selectedDate) async {
    // Deletar registros existentes para o mes_ano especificado
    await (delete(resumos)
          ..where((tbl) => tbl.mesAno.equals(selectedDate)))
        .go();

    // Navegar pelas contas de receita
    final contasReceitas = await select(contaReceitas).get();

    for (var conta in contasReceitas) {
      // Adiciona cada conta de receita ao resumo
      await into(resumos).insert(ResumosCompanion.insert(
        receitaDespesa: const Value('R'), // Indica que é receita
        codigo: Value(conta.codigo), // Código da conta de receita
        descricao: Value(conta.descricao), // Descrição da conta de receita
        mesAno: Value(selectedDate), // Adiciona o mes_ano
      ));
    }

    // Insere o total de receitas
    await into(resumos).insert(ResumosCompanion.insert(
      receitaDespesa: const Value('+'), // Sinal de total
      codigo: const Value(null), // Sem código
      descricao: const Value('TOTAL RECEITAS'), // Descrição do total
      mesAno: Value(selectedDate), // Adiciona o mes_ano
    ));

    // Navegar pelas contas de despesa
    final contasDespesas = await select(contaDespesas).get();

    for (var conta in contasDespesas) {
      // Adiciona cada conta de despesa ao resumo
      await into(resumos).insert(ResumosCompanion.insert(
        receitaDespesa: const Value('D'), // Indica que é despesa
        codigo: Value(conta.codigo), // Código da conta de despesa
        descricao: Value(conta.descricao), // Descrição da conta de despesa
        mesAno: Value(selectedDate), // Adiciona o mes_ano
      ));
    }

    // Insere o total de despesas
    await into(resumos).insert(ResumosCompanion.insert(
      receitaDespesa: const Value('-'), // Sinal de total
      codigo: const Value(null), // Sem código
      descricao: const Value('TOTAL DESPESAS'), // Descrição do total
      mesAno: Value(selectedDate), // Adiciona o mes_ano
    ));

    showInfoSnackBar(message: "Resumo atualizado com sucesso para o período $selectedDate!");
  }

  Future<void> calculateSummarryForAMonth(String selectedDate, Filter filter) async {
    // Buscar todos os registros do resumo para o mês informado
    final resumoList = await getListFilter('mes_ano', selectedDate);

    // Map para armazenar totais agrupados
    final Map<String, double> totais = {
      'orcadoReceitas': 0,
      'realizadoReceitas': 0,
      'diferencaReceitas': 0,
      'orcadoDespesas': 0,
      'realizadoDespesas': 0,
      'diferencaDespesas': 0,
    };

    for (final resumo in resumoList) {
      if (resumo.codigo == null) continue;

      double realizado = 0;
      double diferenca = 0;

      if (resumo.receitaDespesa == 'R') {
        // Receita
        realizado = await db.lancamentoReceitaDao.getTotalFromLancamentoReceita(resumo.codigo!, filter);
        diferenca = realizado - (resumo.valorOrcado ?? 0);

        totais['realizadoReceitas'] = (totais['realizadoReceitas'] ?? 0) + realizado;
        totais['orcadoReceitas'] = (totais['orcadoReceitas'] ?? 0) + (resumo.valorOrcado ?? 0);
        totais['diferencaReceitas'] = (totais['diferencaReceitas'] ?? 0) + diferenca;
      } else if (resumo.receitaDespesa == 'D') {
        // Despesa
        realizado = await db.lancamentoDespesaDao.getTotalFromLancamentoDespesa(resumo.codigo!, filter);
        diferenca = (resumo.valorOrcado ?? 0) - realizado;

        totais['realizadoDespesas'] = (totais['realizadoDespesas'] ?? 0) + realizado;
        totais['orcadoDespesas'] = (totais['orcadoDespesas'] ?? 0) + (resumo.valorOrcado ?? 0);
        totais['diferencaDespesas'] = (totais['diferencaDespesas'] ?? 0) + diferenca;
      }

      // Atualiza lançamentos e/ou totais
      if (resumo.receitaDespesa == 'R' || resumo.receitaDespesa == 'D') {
        await updateResumo(resumo.id!, realizado, diferenca);
      } else if (resumo.receitaDespesa == '+') {
        await updateResumoTotal(resumo.id!, totais['orcadoReceitas']!, totais['realizadoReceitas']!, totais['diferencaReceitas']!);
      } else if (resumo.receitaDespesa == '-') {
        await updateResumoTotal(resumo.id!, totais['orcadoDespesas']!, totais['realizadoDespesas']!, totais['diferencaDespesas']!);
      }
    }
  }

  Future<void> updateResumo(int id, double valorRealizado, double diferenca) async {
    await (update(resumos)..where((r) => r.id.equals(id))).write(
      ResumosCompanion(valorRealizado: Value(valorRealizado), diferenca: Value(diferenca)),
    );
  }

  Future<void> updateResumoTotal(int id, double valorOrcado, double valorRealizado, double diferenca) async {
    await (update(resumos)..where((r) => r.id.equals(id))).write(
      ResumosCompanion(valorOrcado: Value(valorOrcado), valorRealizado: Value(valorRealizado), diferenca: Value(diferenca)),
    );
  }
}

import 'package:financeiro_pessoal/app/data/provider/drift/lancamento_despesa_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class LancamentoDespesaRepository {
  final LancamentoDespesaDriftProvider lancamentoDespesaDriftProvider;

  LancamentoDespesaRepository({required this.lancamentoDespesaDriftProvider});

  Future getList({Filter? filter}) async {
    return await lancamentoDespesaDriftProvider.getList(filter: filter);
  }

  Future transferDataFromOtherMonth(String selectedDate, String targetDate) async {
    await lancamentoDespesaDriftProvider.transferDataFromOtherMonth(selectedDate, targetDate);
  }

  Future<LancamentoDespesaModel?>? save({required LancamentoDespesaModel lancamentoDespesaModel}) async {
    if (lancamentoDespesaModel.id! > 0) {
      return await lancamentoDespesaDriftProvider.update(lancamentoDespesaModel);
    } else {
      return await lancamentoDespesaDriftProvider.insert(lancamentoDespesaModel);
    }
  }

  Future<bool> delete({required int id}) async {
    return await lancamentoDespesaDriftProvider.delete(id) ?? false;
  }
}

import 'package:financeiro_pessoal/app/data/provider/drift/lancamento_receita_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class LancamentoReceitaRepository {
  final LancamentoReceitaDriftProvider lancamentoReceitaDriftProvider;

  LancamentoReceitaRepository({required this.lancamentoReceitaDriftProvider});

  Future getList({Filter? filter}) async {
		return await lancamentoReceitaDriftProvider.getList(filter: filter);
  }

  Future transferDataFromOtherMonth(String selectedDate, String targetDate) async {
    await lancamentoReceitaDriftProvider.transferDataFromOtherMonth(selectedDate, targetDate);
  }

  Future<LancamentoReceitaModel?>? save({required LancamentoReceitaModel lancamentoReceitaModel}) async {
    if (lancamentoReceitaModel.id! > 0) {
			return await lancamentoReceitaDriftProvider.update(lancamentoReceitaModel);
    } else {
			return await lancamentoReceitaDriftProvider.insert(lancamentoReceitaModel);
    }
  }

  Future<bool> delete({required int id}) async {
		return await lancamentoReceitaDriftProvider.delete(id) ?? false;
	}
}
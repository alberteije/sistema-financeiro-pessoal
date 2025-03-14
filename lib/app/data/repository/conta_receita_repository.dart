import 'package:financeiro_pessoal/app/data/provider/drift/conta_receita_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ContaReceitaRepository {
  final ContaReceitaDriftProvider contaReceitaDriftProvider;

  ContaReceitaRepository({required this.contaReceitaDriftProvider});

  Future getList({Filter? filter}) async {
		return await contaReceitaDriftProvider.getList(filter: filter);
  }

  Future<ContaReceitaModel?>? save({required ContaReceitaModel contaReceitaModel}) async {
    if (contaReceitaModel.id! > 0) {
			return await contaReceitaDriftProvider.update(contaReceitaModel);
    } else {
			return await contaReceitaDriftProvider.insert(contaReceitaModel);
    }   
  }

  Future<bool> delete({required int id}) async {
		return await contaReceitaDriftProvider.delete(id) ?? false;
	}
}
import 'package:financeiro_pessoal/app/data/provider/drift/conta_despesa_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ContaDespesaRepository {
  final ContaDespesaDriftProvider contaDespesaDriftProvider;

  ContaDespesaRepository({required this.contaDespesaDriftProvider});

  Future getList({Filter? filter}) async {
		return await contaDespesaDriftProvider.getList(filter: filter);
  }

  Future<ContaDespesaModel?>? save({required ContaDespesaModel contaDespesaModel}) async {
    if (contaDespesaModel.id! > 0) {
			return await contaDespesaDriftProvider.update(contaDespesaModel);
    } else {
			return await contaDespesaDriftProvider.insert(contaDespesaModel);
    }   
  }

  Future<bool> delete({required int id}) async {
		return await contaDespesaDriftProvider.delete(id) ?? false;
	}
}
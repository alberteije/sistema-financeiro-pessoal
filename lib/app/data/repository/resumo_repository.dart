import 'package:financeiro_pessoal/app/data/provider/drift/resumo_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ResumoRepository {
  final ResumoDriftProvider resumoDriftProvider;

  ResumoRepository({required this.resumoDriftProvider});

  Future getList({Filter? filter}) async {
		return await resumoDriftProvider.getList(filter: filter);
  }

  Future<ResumoModel?>? save({required ResumoModel resumoModel}) async {
    if (resumoModel.id! > 0) {
			return await resumoDriftProvider.update(resumoModel);
    } else {
			return await resumoDriftProvider.insert(resumoModel);
    }   
  }

  Future<bool> delete({required int id}) async {
		return await resumoDriftProvider.delete(id) ?? false;
	}

  Future doSummary(String selectedDate) async {
    await resumoDriftProvider.doSummary(selectedDate);
  }

  Future saveAll(List<ResumoModel> resumoList) async {
    await resumoDriftProvider.saveAll(resumoList);
  }

  Future calculateSummarryForAMonth(String selectedDate, Filter filter) async {
    await resumoDriftProvider.calculateSummarryForAMonth(selectedDate, filter);
  }

}
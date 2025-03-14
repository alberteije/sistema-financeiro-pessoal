import 'package:financeiro_pessoal/app/data/provider/drift/extrato_bancario_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ExtratoBancarioRepository {
  final ExtratoBancarioDriftProvider extratoBancarioDriftProvider;

  ExtratoBancarioRepository({required this.extratoBancarioDriftProvider});

  Future getList({Filter? filter}) async {
		return await extratoBancarioDriftProvider.getList(filter: filter);
  }

  Future<ExtratoBancarioModel?>? save({required ExtratoBancarioModel extratoBancarioModel}) async {
    if (extratoBancarioModel.id! > 0) {
			return await extratoBancarioDriftProvider.update(extratoBancarioModel);
    } else {
			return await extratoBancarioDriftProvider.insert(extratoBancarioModel);
    }   
  }

  Future<bool> delete({required int id}) async {
		return await extratoBancarioDriftProvider.delete(id) ?? false;
	}
}
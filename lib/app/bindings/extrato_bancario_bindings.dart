import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/extrato_bancario_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/extrato_bancario_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/extrato_bancario_repository.dart';

class ExtratoBancarioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ExtratoBancarioController>(() => ExtratoBancarioController(
					extratoBancarioRepository:
							ExtratoBancarioRepository(extratoBancarioDriftProvider: ExtratoBancarioDriftProvider()))),
		];
	}
}

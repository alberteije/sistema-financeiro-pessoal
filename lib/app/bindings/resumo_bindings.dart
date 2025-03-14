import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/resumo_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/resumo_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/resumo_repository.dart';

class ResumoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ResumoController>(() => ResumoController(
					resumoRepository:
							ResumoRepository(resumoDriftProvider: ResumoDriftProvider()))),
		];
	}
}

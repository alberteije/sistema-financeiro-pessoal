import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/conta_receita_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/conta_receita_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/conta_receita_repository.dart';

class ContaReceitaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<ContaReceitaController>(() => ContaReceitaController(
					contaReceitaRepository:
							ContaReceitaRepository(contaReceitaDriftProvider: ContaReceitaDriftProvider()))),
		];
	}
}

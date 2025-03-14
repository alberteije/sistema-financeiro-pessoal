import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/lancamento_despesa_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/lancamento_despesa_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/lancamento_despesa_repository.dart';

class LancamentoDespesaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<LancamentoDespesaController>(() => LancamentoDespesaController(
					lancamentoDespesaRepository:
							LancamentoDespesaRepository(lancamentoDespesaDriftProvider: LancamentoDespesaDriftProvider()))),
		];
	}
}

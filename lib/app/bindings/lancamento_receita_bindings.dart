import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/lancamento_receita_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/lancamento_receita_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/lancamento_receita_repository.dart';

class LancamentoReceitaBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<LancamentoReceitaController>(() => LancamentoReceitaController(
					lancamentoReceitaRepository:
							LancamentoReceitaRepository(lancamentoReceitaDriftProvider: LancamentoReceitaDriftProvider()))),
		];
	}
}

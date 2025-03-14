import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/metodo_pagamento_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/metodo_pagamento_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/metodo_pagamento_repository.dart';

class MetodoPagamentoBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<MetodoPagamentoController>(() => MetodoPagamentoController(
					metodoPagamentoRepository:
							MetodoPagamentoRepository(metodoPagamentoDriftProvider: MetodoPagamentoDriftProvider()))),
		];
	}
}

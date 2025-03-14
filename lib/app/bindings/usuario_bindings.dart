import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/controller/usuario_controller.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/usuario_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/usuario_repository.dart';

class UsuarioBindings implements Binding {
	@override
	List<Bind> dependencies() {
		return [
			Bind.lazyPut<UsuarioController>(() => UsuarioController(
					usuarioRepository:
							UsuarioRepository(usuarioDriftProvider: UsuarioDriftProvider()))),
		];
	}
}

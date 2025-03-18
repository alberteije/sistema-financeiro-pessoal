import 'package:financeiro_pessoal/app/data/provider/drift/usuario_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class UsuarioRepository {
  final UsuarioDriftProvider usuarioDriftProvider;

  UsuarioRepository({required this.usuarioDriftProvider});

  Future getList({Filter? filter}) async {
    return await usuarioDriftProvider.getList(filter: filter);
  }

  Future<UsuarioModel?>? save({required UsuarioModel usuarioModel}) async {
    if (usuarioModel.id! > 0) {
      return await usuarioDriftProvider.update(usuarioModel);
    } else {
      return await usuarioDriftProvider.insert(usuarioModel);
    }
  }

  Future<bool> delete({required int id}) async {
    return await usuarioDriftProvider.delete(id) ?? false;
  }

  Future<bool> doLogin(String user, String password) async {
    return await usuarioDriftProvider.doLogin(user, password);
  }
}

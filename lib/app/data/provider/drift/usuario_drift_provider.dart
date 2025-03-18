import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class UsuarioDriftProvider extends ProviderBase {
  Future<List<UsuarioModel>?> getList({Filter? filter}) async {
    List<UsuarioGrouped> usuarioDriftList = [];

    try {
      if (filter != null && filter.field != null) {
        usuarioDriftList = await Session.database.usuarioDao.getGroupedList(field: filter.field, value: filter.value!);
      } else {
        usuarioDriftList = await Session.database.usuarioDao.getGroupedList();
      }
      if (usuarioDriftList.isNotEmpty) {
        return toListModel(usuarioDriftList);
      } else {
        return [];
      }
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
      return null;
    }
  }

  Future<UsuarioModel?> getObject(dynamic pk) async {
    try {
      final result = await Session.database.usuarioDao.getObjectGrouped(field: 'id', value: pk);
      return toModel(result);
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
    return null;
  }

  Future<UsuarioModel?>? insert(UsuarioModel usuarioModel) async {
    try {
      final lastPk = await Session.database.usuarioDao.insertObject(toDrift(usuarioModel));
      usuarioModel.id = lastPk;
      return usuarioModel;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
    return null;
  }

  Future<UsuarioModel?>? update(UsuarioModel usuarioModel) async {
    try {
      await Session.database.usuarioDao.updateObject(toDrift(usuarioModel));
      return usuarioModel;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
    return null;
  }

  Future<bool?> delete(dynamic pk) async {
    try {
      await Session.database.usuarioDao.deleteObject(toDrift(UsuarioModel(id: pk)));
      return true;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
    return null;
  }

  Future<bool> doLogin(String user, String password) async {
    try {
      return await Session.database.usuarioDao.doLogin(user, password);
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
    return false;
  }

  List<UsuarioModel> toListModel(List<UsuarioGrouped> usuarioDriftList) {
    List<UsuarioModel> listModel = [];
    for (var usuarioDrift in usuarioDriftList) {
      listModel.add(toModel(usuarioDrift)!);
    }
    return listModel;
  }

  UsuarioModel? toModel(UsuarioGrouped? usuarioDrift) {
    if (usuarioDrift != null) {
      return UsuarioModel(
        id: usuarioDrift.usuario?.id,
        login: usuarioDrift.usuario?.login,
        senha: usuarioDrift.usuario?.senha,
      );
    } else {
      return null;
    }
  }

  UsuarioGrouped toDrift(UsuarioModel usuarioModel) {
    return UsuarioGrouped(
      usuario: Usuario(
        id: usuarioModel.id,
        login: usuarioModel.login,
        senha: usuarioModel.senha,
      ),
    );
  }
}

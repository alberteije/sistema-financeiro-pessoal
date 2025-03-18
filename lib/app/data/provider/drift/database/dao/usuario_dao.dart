import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [
  Usuarios,
])
class UsuarioDao extends DatabaseAccessor<AppDatabase> with _$UsuarioDaoMixin {
  final AppDatabase db;

  List<Usuario> usuarioList = [];
  List<UsuarioGrouped> usuarioGroupedList = [];

  UsuarioDao(this.db) : super(db);

  Future<List<Usuario>> getList() async {
    usuarioList = await select(usuarios).get();
    return usuarioList;
  }

  Future<List<Usuario>> getListFilter(String field, String value) async {
    final query = " $field like '%$value%'";
    final expression = CustomExpression<bool>(query);
    usuarioList = await (select(usuarios)..where((t) => expression)).get();
    return usuarioList;
  }

  Future<List<UsuarioGrouped>> getGroupedList({String? field, dynamic value}) async {
    final query = select(usuarios).join([]);

    if (field != null && field != '') {
      final column = usuarios.$columns.where(((column) => column.$name == field)).first;
      if (column is TextColumn) {
        query.where((column as TextColumn).like('%$value%'));
      } else if (column is IntColumn) {
        query.where(column.equals(int.tryParse(value) as Object));
      } else if (column is RealColumn) {
        query.where(column.equals(double.tryParse(value) as Object));
      }
    }

    usuarioGroupedList = await query.map((row) {
      final usuario = row.readTableOrNull(usuarios);

      return UsuarioGrouped(
        usuario: usuario,
      );
    }).get();

    // fill internal lists
    //dynamic expression;
    //for (var usuarioGrouped in usuarioGroupedList) {
    //}

    return usuarioGroupedList;
  }

  Future<Usuario?> getObject(dynamic pk) async {
    return await (select(usuarios)..where((t) => t.id.equals(pk))).getSingleOrNull();
  }

  Future<Usuario?> getObjectFilter(String field, String value) async {
    final query = "SELECT * FROM usuario WHERE $field like '%$value%'";
    return (await customSelect(query).getSingleOrNull()) as Usuario;
  }

  Future<UsuarioGrouped?> getObjectGrouped({String? field, dynamic value}) async {
    final result = await getGroupedList(field: field, value: value);

    if (result.length != 1) {
      return null;
    } else {
      return result[0];
    }
  }

  Future<int> insertObject(UsuarioGrouped object) {
    return transaction(() async {
      final maxPk = await lastPk();
      object.usuario = object.usuario!.copyWith(id: Value(maxPk + 1));
      final pkInserted = await into(usuarios).insert(object.usuario!);
      object.usuario = object.usuario!.copyWith(id: Value(pkInserted));
      await insertChildren(object);
      return pkInserted;
    });
  }

  Future<bool> updateObject(UsuarioGrouped object) {
    return transaction(() async {
      await deleteChildren(object);
      await insertChildren(object);
      return update(usuarios).replace(object.usuario!);
    });
  }

  Future<int> deleteObject(UsuarioGrouped object) {
    return transaction(() async {
      await deleteChildren(object);
      return delete(usuarios).delete(object.usuario!);
    });
  }

  Future<void> insertChildren(UsuarioGrouped object) async {}

  Future<void> deleteChildren(UsuarioGrouped object) async {}

  Future<int> lastPk() async {
    final result = await customSelect("select MAX(id) as LAST from usuario").getSingleOrNull();
    return result?.data["LAST"] ?? 0;
  }

  Future<bool> doLogin(String user, String password) async {
    final query = "SELECT * FROM usuario WHERE login = '$user' AND senha = '$password'";
    final result = (await customSelect(query).getSingleOrNull());
    return result != null;
  }
}

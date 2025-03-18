import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/platform/platform.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/infra/session.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/message_dialog.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

class BackupRestoreHelper {
  /// **Cria um backup do banco de dados**
  static Future<void> createBackup() async {
    if (kIsWeb) {
      await _backupWeb();
    } else {
      await _backupNative();
    }
  }

  /// **Restaura o banco a partir de um backup**
  static Future<void> restoreBackup() async {
    if (kIsWeb) {
      await _restoreWeb();
    } else {
      await _restoreNative();
    }
  }

  /// **Backup para Mobile/Desktop**
  static Future<void> _backupNative() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final dbPath = p.join(dir.path, 'financeiro_pessoal.sqlite');
      final backupPath = await FilePicker.platform.getDirectoryPath();

      if (backupPath != null) {
        final backupFile = File(p.join(backupPath, 'financeiro_backup.sqlite'));
        await File(dbPath).copy(backupFile.path);
        showInfoSnackBar(message: "Backup criado com sucesso!");
      }
    } catch (e) {
      showErrorSnackBar(message: "Erro ao criar backup: $e");
    }
  }

  /// **Backup para Web (Exportação em JSON)**
  static Future<void> _backupWeb() async {
    try {
      final allTables = await _exportAllTables();
      final jsonBackup = jsonEncode(allTables);
      final bytes = utf8.encode(jsonBackup);
      final blob = html.Blob([bytes]);

      // Criar link de download
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "financeiro_backup.json")
        ..click();

      html.Url.revokeObjectUrl(url);
      showInfoSnackBar(message: "Backup exportado com sucesso!");
    } catch (e) {
      showErrorSnackBar(message: "Erro ao criar backup: $e");
    }
  }

  /// **Exporta todas as tabelas do banco como JSON**
  static Future<Map<String, dynamic>> _exportAllTables() async {
    final database = Session.database;
    final tables = database.allTables;
    final Map<String, dynamic> data = {};

    // Mapa que relaciona os nomes das tabelas aos seus respectivos tipos
    final typeMap = {
      'lancamento_receita': (record) => record as LancamentoReceita,
      'lancamento_despesa': (record) => record as LancamentoDespesa,
      'conta_receita': (record) => record as ContaReceita,
      'conta_despesa': (record) => record as ContaDespesa,
      'resumo': (record) => record as Resumo,
      'extrato_bancario': (record) => record as ExtratoBancario,
      'metodo_pagamento': (record) => record as MetodoPagamento,
      'usuario': (record) => record as Usuario,
    };

    for (var table in tables) {
      final records = await database.select(table).get();

      if (typeMap.containsKey(table.actualTableName)) {
        data[table.actualTableName] = records
            .map((e) => typeMap[table.actualTableName]!(e).toJson())
            .toList();
      }
    }

    return data;
  }

  /// **Restauração para Mobile/Desktop**
  static Future<void> _restoreNative() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final file = File(result.files.single.path!);
        final dir = await getApplicationDocumentsDirectory();
        final dbPath = p.join(dir.path, 'financeiro_pessoal.sqlite');

        // Fecha a conexão com o banco antes de substituir o arquivo
        await Session.database.close();

        // Remove o banco existente antes de copiar o backup
        final dbFile = File(dbPath);
        if (await dbFile.exists()) {
          await dbFile.delete();
        }

        // Sobrescreve o banco de dados atual
        await file.copy(dbPath);

        // Cria uma nova instância do banco de dados
        final newDatabase = AppDatabase(Platform.createDatabaseConnection('financeiro_pessoal'));
        Get.put(newDatabase); // Registra a nova instância no GetX
        Session.database = newDatabase; // Atualiza a variável de sessão

        showInfoSnackBar(message: "Banco restaurado com sucesso!");
      }
    } catch (e) {
      showErrorSnackBar(message: "Erro ao restaurar backup: $e");
    }
  }

  /// **Restauração para Web (Importação do JSON)**
  static Future<void> _restoreWeb() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          final jsonStr = utf8.decode(fileBytes);
          final data = jsonDecode(jsonStr) as Map<String, dynamic>;

          await _importAllTables(data);
          showInfoSnackBar(message: "Banco de dados restaurado com sucesso!");
        }
      }
    } catch (e) {
      showErrorSnackBar(message: "Erro ao restaurar backup: $e");
    }
  }

  /// **Importa todas as tabelas do JSON para o banco**
  static Future<void> _importAllTables(Map<String, dynamic> data) async {
    final database = Session.database;

    for (var entry in data.entries) {
      final tableName = entry.key;
      final records = entry.value as List<dynamic>;

      // Pegamos a tabela correspondente
      final table = database.allTables.firstWhere((t) => t.actualTableName == tableName);

      // Deletamos os dados antigos antes de restaurar
      await database.delete(table).go();

      // Inserimos os novos dados
      for (var record in records) {
        switch (tableName) {
          case 'conta_receita':
            await database.into(database.contaReceitas).insert(ContaReceita.fromJson(record));
            break;
          case 'conta_despesa':
            await database.into(database.contaDespesas).insert(ContaDespesa.fromJson(record));
            break;
          case 'lancamento_receita':
            await database.into(database.lancamentoReceitas).insert(LancamentoReceita.fromJson(record));
            break;
          case 'lancamento_despesa':
            await database.into(database.lancamentoDespesas).insert(LancamentoDespesa.fromJson(record));
            break;
          case 'resumo':
            await database.into(database.resumos).insert(Resumo.fromJson(record));
            break;
          case 'extrato_bancario':
            await database.into(database.extratoBancarios).insert(ExtratoBancario.fromJson(record));
            break;
          case 'metodo_pagamento':
            await database.into(database.metodoPagamentos).insert(MetodoPagamento.fromJson(record));
            break;
          case 'usuario':
            await database.into(database.usuarios).insert(Usuario.fromJson(record));
            break;
          default:
            break;
        }
      }
    }
  }

}

import 'package:drift/drift.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';

part 'database.g.dart';

@DriftDatabase(
	tables: [
		ContaDespesas,
		LancamentoDespesas,
		Resumos,
		ExtratoBancarios,
		MetodoPagamentos,
		ContaReceitas,
		LancamentoReceitas,
		Usuarios,
 ], 
	daos: [
		ContaDespesaDao,
		LancamentoDespesaDao,
		ResumoDao,
		ExtratoBancarioDao,
		MetodoPagamentoDao,
		ContaReceitaDao,
		LancamentoReceitaDao,
		UsuarioDao,
	],
)

class AppDatabase extends _$AppDatabase {
	AppDatabase(QueryExecutor executor) : super(executor);

	@override
	int get schemaVersion => 1;

	@override
	MigrationStrategy get migration => MigrationStrategy(
		onCreate: (Migrator m) async {
			await m.createAll();
			await _populateDatabase(this);
		},		
	);	
}

Future<void> _populateDatabase(db) async {
	await db.customStatement("CREATE TABLE HIDDEN_SETTINGS("
				"ID INTEGER PRIMARY KEY,"
				"APP_THEME TEXT"
			")");
	await db.customStatement("INSERT INTO HIDDEN_SETTINGS (ID, APP_THEME) VALUES (1, 'ThemeMode.light')");
}

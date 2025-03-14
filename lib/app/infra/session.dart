import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/lookup_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/repository/lookup_repository.dart';
import 'package:financeiro_pessoal/app/controller/controller_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';

// TODO: get data from your own user
class LogedInUser {
  String administrador = 'S';
}

class Session {
	Session._();

	static String tokenJWT = '';
	static AppDatabase database = Get.find();

	static bool waitDialogIsOpen = false;
  static List accessControlList = []; 
  static LogedInUser loggedInUser = LogedInUser();
	
	/// populate main objects for the Session
	static Future populateMainObjects() async { 
		Get.lazyPut<LoginController>(() => LoginController());
		Get.lazyPut<FilterController>(() => FilterController(), permanent: true);
	  Get.lazyPut<LookupController>(() => LookupController(lookupRepository: LookupRepository(lookupDriftProvider: LookupDriftProvider())), permanent: true);
	}

	static setLookupController() {
		Get.lazyPut<LookupController>(() => LookupController(lookupRepository: LookupRepository(lookupDriftProvider: LookupDriftProvider())));
	}
	
	static PlutoGridLocaleText getLocaleForPlutoGrid() {
		switch (Get.locale.toString()) {
			case 'pt_BR':
				return const PlutoGridLocaleText.brazilianPortuguese();
			case 'es_ES':
				return const PlutoGridLocaleText.spanish();
			default:
				return const PlutoGridLocaleText();
		}
	}


}
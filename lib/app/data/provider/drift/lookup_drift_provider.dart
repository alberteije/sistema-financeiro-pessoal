import 'dart:convert';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';

class LookupDriftProvider extends ProviderBase {

	Future<List<dynamic>?> getList({required String route, required Filter filter}) async {
		List<dynamic> driftList = [];
		final table = route.replaceAll('/', '').replaceAll('-', '_');
		final query = "select * from $table where ${filter.field} like '%${filter.value}%'"; 
		try {
			driftList = await Session.database.customSelect(query).get();
			final jsonList = Util.toJsonString(driftList);
			return json.decode(jsonList) as List<dynamic>;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}
}

import 'package:financeiro_pessoal/app/data/provider/drift/lookup_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';

class LookupRepository {
	final LookupDriftProvider lookupDriftProvider;

	LookupRepository({required this.lookupDriftProvider});

	Future getList({required String route, Filter? filter}) async {
		return await lookupDriftProvider.getList(route: route, filter: filter!);
	}
}
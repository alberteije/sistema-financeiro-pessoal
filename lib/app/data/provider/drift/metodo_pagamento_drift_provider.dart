import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class MetodoPagamentoDriftProvider extends ProviderBase {

	Future<List<MetodoPagamentoModel>?> getList({Filter? filter}) async {
		List<MetodoPagamentoGrouped> metodoPagamentoDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				metodoPagamentoDriftList = await Session.database.metodoPagamentoDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				metodoPagamentoDriftList = await Session.database.metodoPagamentoDao.getGroupedList(); 
			}
			if (metodoPagamentoDriftList.isNotEmpty) {
				return toListModel(metodoPagamentoDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<MetodoPagamentoModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.metodoPagamentoDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MetodoPagamentoModel?>? insert(MetodoPagamentoModel metodoPagamentoModel) async {
		try {
			final lastPk = await Session.database.metodoPagamentoDao.insertObject(toDrift(metodoPagamentoModel));
			metodoPagamentoModel.id = lastPk;
			return metodoPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<MetodoPagamentoModel?>? update(MetodoPagamentoModel metodoPagamentoModel) async {
		try {
			await Session.database.metodoPagamentoDao.updateObject(toDrift(metodoPagamentoModel));
			return metodoPagamentoModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.metodoPagamentoDao.deleteObject(toDrift(MetodoPagamentoModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<MetodoPagamentoModel> toListModel(List<MetodoPagamentoGrouped> metodoPagamentoDriftList) {
		List<MetodoPagamentoModel> listModel = [];
		for (var metodoPagamentoDrift in metodoPagamentoDriftList) {
			listModel.add(toModel(metodoPagamentoDrift)!);
		}
		return listModel;
	}	

	MetodoPagamentoModel? toModel(MetodoPagamentoGrouped? metodoPagamentoDrift) {
		if (metodoPagamentoDrift != null) {
			return MetodoPagamentoModel(
				id: metodoPagamentoDrift.metodoPagamento?.id,
				codigo: metodoPagamentoDrift.metodoPagamento?.codigo,
				descricao: metodoPagamentoDrift.metodoPagamento?.descricao,
			);
		} else {
			return null;
		}
	}


	MetodoPagamentoGrouped toDrift(MetodoPagamentoModel metodoPagamentoModel) {
		return MetodoPagamentoGrouped(
			metodoPagamento: MetodoPagamento(
				id: metodoPagamentoModel.id,
				codigo: metodoPagamentoModel.codigo,
				descricao: metodoPagamentoModel.descricao,
			),
		);
	}

		
}

import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ContaDespesaDriftProvider extends ProviderBase {

	Future<List<ContaDespesaModel>?> getList({Filter? filter}) async {
		List<ContaDespesaGrouped> contaDespesaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contaDespesaDriftList = await Session.database.contaDespesaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contaDespesaDriftList = await Session.database.contaDespesaDao.getGroupedList(); 
			}
			if (contaDespesaDriftList.isNotEmpty) {
				return toListModel(contaDespesaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContaDespesaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contaDespesaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContaDespesaModel?>? insert(ContaDespesaModel contaDespesaModel) async {
		try {
			final lastPk = await Session.database.contaDespesaDao.insertObject(toDrift(contaDespesaModel));
			contaDespesaModel.id = lastPk;
			return contaDespesaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContaDespesaModel?>? update(ContaDespesaModel contaDespesaModel) async {
		try {
			await Session.database.contaDespesaDao.updateObject(toDrift(contaDespesaModel));
			return contaDespesaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contaDespesaDao.deleteObject(toDrift(ContaDespesaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContaDespesaModel> toListModel(List<ContaDespesaGrouped> contaDespesaDriftList) {
		List<ContaDespesaModel> listModel = [];
		for (var contaDespesaDrift in contaDespesaDriftList) {
			listModel.add(toModel(contaDespesaDrift)!);
		}
		return listModel;
	}	

	ContaDespesaModel? toModel(ContaDespesaGrouped? contaDespesaDrift) {
		if (contaDespesaDrift != null) {
			return ContaDespesaModel(
				id: contaDespesaDrift.contaDespesa?.id,
				codigo: contaDespesaDrift.contaDespesa?.codigo,
				descricao: contaDespesaDrift.contaDespesa?.descricao,
			);
		} else {
			return null;
		}
	}


	ContaDespesaGrouped toDrift(ContaDespesaModel contaDespesaModel) {
		return ContaDespesaGrouped(
			contaDespesa: ContaDespesa(
				id: contaDespesaModel.id,
				codigo: contaDespesaModel.codigo,
				descricao: contaDespesaModel.descricao,
			),
		);
	}

		
}

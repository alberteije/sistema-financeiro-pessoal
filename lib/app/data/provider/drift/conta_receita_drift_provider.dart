import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class ContaReceitaDriftProvider extends ProviderBase {

	Future<List<ContaReceitaModel>?> getList({Filter? filter}) async {
		List<ContaReceitaGrouped> contaReceitaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				contaReceitaDriftList = await Session.database.contaReceitaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				contaReceitaDriftList = await Session.database.contaReceitaDao.getGroupedList(); 
			}
			if (contaReceitaDriftList.isNotEmpty) {
				return toListModel(contaReceitaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ContaReceitaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.contaReceitaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContaReceitaModel?>? insert(ContaReceitaModel contaReceitaModel) async {
		try {
			final lastPk = await Session.database.contaReceitaDao.insertObject(toDrift(contaReceitaModel));
			contaReceitaModel.id = lastPk;
			return contaReceitaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ContaReceitaModel?>? update(ContaReceitaModel contaReceitaModel) async {
		try {
			await Session.database.contaReceitaDao.updateObject(toDrift(contaReceitaModel));
			return contaReceitaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.contaReceitaDao.deleteObject(toDrift(ContaReceitaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<ContaReceitaModel> toListModel(List<ContaReceitaGrouped> contaReceitaDriftList) {
		List<ContaReceitaModel> listModel = [];
		for (var contaReceitaDrift in contaReceitaDriftList) {
			listModel.add(toModel(contaReceitaDrift)!);
		}
		return listModel;
	}	

	ContaReceitaModel? toModel(ContaReceitaGrouped? contaReceitaDrift) {
		if (contaReceitaDrift != null) {
			return ContaReceitaModel(
				id: contaReceitaDrift.contaReceita?.id,
				codigo: contaReceitaDrift.contaReceita?.codigo,
				descricao: contaReceitaDrift.contaReceita?.descricao,
			);
		} else {
			return null;
		}
	}


	ContaReceitaGrouped toDrift(ContaReceitaModel contaReceitaModel) {
		return ContaReceitaGrouped(
			contaReceita: ContaReceita(
				id: contaReceitaModel.id,
				codigo: contaReceitaModel.codigo,
				descricao: contaReceitaModel.descricao,
			),
		);
	}

		
}

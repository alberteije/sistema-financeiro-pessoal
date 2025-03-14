import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class LancamentoDespesaDriftProvider extends ProviderBase {

	Future<List<LancamentoDespesaModel>?> getList({Filter? filter}) async {
		List<LancamentoDespesaGrouped> lancamentoDespesaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				lancamentoDespesaDriftList = await Session.database.lancamentoDespesaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				lancamentoDespesaDriftList = await Session.database.lancamentoDespesaDao.getGroupedList(); 
			}
			if (lancamentoDespesaDriftList.isNotEmpty) {
				return toListModel(lancamentoDespesaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<LancamentoDespesaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.lancamentoDespesaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancamentoDespesaModel?>? insert(LancamentoDespesaModel lancamentoDespesaModel) async {
		try {
			final lastPk = await Session.database.lancamentoDespesaDao.insertObject(toDrift(lancamentoDespesaModel));
			lancamentoDespesaModel.id = lastPk;
			return lancamentoDespesaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancamentoDespesaModel?>? update(LancamentoDespesaModel lancamentoDespesaModel) async {
		try {
			await Session.database.lancamentoDespesaDao.updateObject(toDrift(lancamentoDespesaModel));
			return lancamentoDespesaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.lancamentoDespesaDao.deleteObject(toDrift(LancamentoDespesaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<LancamentoDespesaModel> toListModel(List<LancamentoDespesaGrouped> lancamentoDespesaDriftList) {
		List<LancamentoDespesaModel> listModel = [];
		for (var lancamentoDespesaDrift in lancamentoDespesaDriftList) {
			listModel.add(toModel(lancamentoDespesaDrift)!);
		}
		return listModel;
	}	

	LancamentoDespesaModel? toModel(LancamentoDespesaGrouped? lancamentoDespesaDrift) {
		if (lancamentoDespesaDrift != null) {
			return LancamentoDespesaModel(
				id: lancamentoDespesaDrift.lancamentoDespesa?.id,
				idContaDespesa: lancamentoDespesaDrift.lancamentoDespesa?.idContaDespesa,
				idMetodoPagamento: lancamentoDespesaDrift.lancamentoDespesa?.idMetodoPagamento,
				dataDespesa: lancamentoDespesaDrift.lancamentoDespesa?.dataDespesa,
				valor: lancamentoDespesaDrift.lancamentoDespesa?.valor,
				statusDespesa: LancamentoDespesaDomain.getStatusDespesa(lancamentoDespesaDrift.lancamentoDespesa?.statusDespesa),
				historico: lancamentoDespesaDrift.lancamentoDespesa?.historico,
				contaDespesaModel: ContaDespesaModel(
					id: lancamentoDespesaDrift.contaDespesa?.id,
					codigo: lancamentoDespesaDrift.contaDespesa?.codigo,
					descricao: lancamentoDespesaDrift.contaDespesa?.descricao,
				),
				metodoPagamentoModel: MetodoPagamentoModel(
					id: lancamentoDespesaDrift.metodoPagamento?.id,
					codigo: lancamentoDespesaDrift.metodoPagamento?.codigo,
					descricao: lancamentoDespesaDrift.metodoPagamento?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	LancamentoDespesaGrouped toDrift(LancamentoDespesaModel lancamentoDespesaModel) {
		return LancamentoDespesaGrouped(
			lancamentoDespesa: LancamentoDespesa(
				id: lancamentoDespesaModel.id,
				idContaDespesa: lancamentoDespesaModel.idContaDespesa,
				idMetodoPagamento: lancamentoDespesaModel.idMetodoPagamento,
				dataDespesa: lancamentoDespesaModel.dataDespesa,
				valor: lancamentoDespesaModel.valor,
				statusDespesa: LancamentoDespesaDomain.setStatusDespesa(lancamentoDespesaModel.statusDespesa),
				historico: lancamentoDespesaModel.historico,
			),
		);
	}

		
}

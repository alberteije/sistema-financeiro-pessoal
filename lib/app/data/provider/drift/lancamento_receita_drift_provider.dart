import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class LancamentoReceitaDriftProvider extends ProviderBase {

	Future<List<LancamentoReceitaModel>?> getList({Filter? filter}) async {
		List<LancamentoReceitaGrouped> lancamentoReceitaDriftList = [];

		try {
			if (filter != null && filter.field != null) {
				lancamentoReceitaDriftList = await Session.database.lancamentoReceitaDao.getGroupedList(field: filter.field, value: filter.value!);
			} else {
				lancamentoReceitaDriftList = await Session.database.lancamentoReceitaDao.getGroupedList(); 
			}
			if (lancamentoReceitaDriftList.isNotEmpty) {
				return toListModel(lancamentoReceitaDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<LancamentoReceitaModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.lancamentoReceitaDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancamentoReceitaModel?>? insert(LancamentoReceitaModel lancamentoReceitaModel) async {
		try {
			final lastPk = await Session.database.lancamentoReceitaDao.insertObject(toDrift(lancamentoReceitaModel));
			lancamentoReceitaModel.id = lastPk;
			return lancamentoReceitaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<LancamentoReceitaModel?>? update(LancamentoReceitaModel lancamentoReceitaModel) async {
		try {
			await Session.database.lancamentoReceitaDao.updateObject(toDrift(lancamentoReceitaModel));
			return lancamentoReceitaModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.lancamentoReceitaDao.deleteObject(toDrift(LancamentoReceitaModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

	List<LancamentoReceitaModel> toListModel(List<LancamentoReceitaGrouped> lancamentoReceitaDriftList) {
		List<LancamentoReceitaModel> listModel = [];
		for (var lancamentoReceitaDrift in lancamentoReceitaDriftList) {
			listModel.add(toModel(lancamentoReceitaDrift)!);
		}
		return listModel;
	}	

	LancamentoReceitaModel? toModel(LancamentoReceitaGrouped? lancamentoReceitaDrift) {
		if (lancamentoReceitaDrift != null) {
			return LancamentoReceitaModel(
				id: lancamentoReceitaDrift.lancamentoReceita?.id,
				idContaReceita: lancamentoReceitaDrift.lancamentoReceita?.idContaReceita,
				idMetodoPagamento: lancamentoReceitaDrift.lancamentoReceita?.idMetodoPagamento,
				dataReceita: lancamentoReceitaDrift.lancamentoReceita?.dataReceita,
				valor: lancamentoReceitaDrift.lancamentoReceita?.valor,
				statusReceita: LancamentoReceitaDomain.getStatusReceita(lancamentoReceitaDrift.lancamentoReceita?.statusReceita),
				historico: lancamentoReceitaDrift.lancamentoReceita?.historico,
				contaReceitaModel: ContaReceitaModel(
					id: lancamentoReceitaDrift.contaReceita?.id,
					codigo: lancamentoReceitaDrift.contaReceita?.codigo,
					descricao: lancamentoReceitaDrift.contaReceita?.descricao,
				),
				metodoPagamentoModel: MetodoPagamentoModel(
					id: lancamentoReceitaDrift.metodoPagamento?.id,
					codigo: lancamentoReceitaDrift.metodoPagamento?.codigo,
					descricao: lancamentoReceitaDrift.metodoPagamento?.descricao,
				),
			);
		} else {
			return null;
		}
	}


	LancamentoReceitaGrouped toDrift(LancamentoReceitaModel lancamentoReceitaModel) {
		return LancamentoReceitaGrouped(
			lancamentoReceita: LancamentoReceita(
				id: lancamentoReceitaModel.id,
				idContaReceita: lancamentoReceitaModel.idContaReceita,
				idMetodoPagamento: lancamentoReceitaModel.idMetodoPagamento,
				dataReceita: lancamentoReceitaModel.dataReceita,
				valor: lancamentoReceitaModel.valor,
				statusReceita: LancamentoReceitaDomain.setStatusReceita(lancamentoReceitaModel.statusReceita),
				historico: lancamentoReceitaModel.historico,
			),
		);
	}

		
}

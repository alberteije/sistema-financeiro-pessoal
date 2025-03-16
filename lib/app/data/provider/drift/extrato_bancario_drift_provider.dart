import 'package:financeiro_pessoal/app/data/provider/drift/database/database_imports.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/data/provider/provider_base.dart';
import 'package:financeiro_pessoal/app/data/provider/drift/database/database.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';
import 'package:financeiro_pessoal/app/data/domain/domain_imports.dart';

class ExtratoBancarioDriftProvider extends ProviderBase {

	Future<List<ExtratoBancarioModel>?> getList({Filter? filter}) async {
		List<ExtratoBancarioGrouped> extratoBancarioDriftList = [];

		try {
      extratoBancarioDriftList = await Session.database.extratoBancarioDao.getGroupedList(filter: filter!);
			if (extratoBancarioDriftList.isNotEmpty) {
				return toListModel(extratoBancarioDriftList);
			} else {
				return [];
			}			 
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
			return null;
		}
	}

	Future<ExtratoBancarioModel?> getObject(dynamic pk) async {
		try {
			final result = await Session.database.extratoBancarioDao.getObjectGrouped(field: 'id', value: pk);
			return toModel(result);
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ExtratoBancarioModel?>? insert(ExtratoBancarioModel extratoBancarioModel) async {
		try {
			final lastPk = await Session.database.extratoBancarioDao.insertObject(toDrift(extratoBancarioModel));
			extratoBancarioModel.id = lastPk;
			return extratoBancarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<ExtratoBancarioModel?>? update(ExtratoBancarioModel extratoBancarioModel) async {
		try {
			await Session.database.extratoBancarioDao.updateObject(toDrift(extratoBancarioModel));
			return extratoBancarioModel;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}

	Future<bool?> delete(dynamic pk) async {
		try {
			await Session.database.extratoBancarioDao.deleteObject(toDrift(ExtratoBancarioModel(id: pk)));
			return true;
		} on Exception catch (e) {
			handleResultError(null, null, exception: e);
		}
		return null;
	}	

  Future deleteByDateRange(Filter filter) async {
    try {
      await Session.database.extratoBancarioDao.deleteByDateRange(filter);
      return true;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
  }

  Future exportDataToIncomesAndExpenses(Filter filter) async {
    try {
      await Session.database.extratoBancarioDao.exportDataToIncomesAndExpenses(filter);
      return true;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
  }

  Future reconcileTransactions(Filter filter) async {
    try {
      await Session.database.extratoBancarioDao.reconcileTransactions(filter);
      return true;
    } on Exception catch (e) {
      handleResultError(null, null, exception: e);
    }
  }

	List<ExtratoBancarioModel> toListModel(List<ExtratoBancarioGrouped> extratoBancarioDriftList) {
		List<ExtratoBancarioModel> listModel = [];
		for (var extratoBancarioDrift in extratoBancarioDriftList) {
			listModel.add(toModel(extratoBancarioDrift)!);
		}
		return listModel;
	}	

	ExtratoBancarioModel? toModel(ExtratoBancarioGrouped? extratoBancarioDrift) {
		if (extratoBancarioDrift != null) {
			return ExtratoBancarioModel(
				id: extratoBancarioDrift.extratoBancario?.id,
				dataTransacao: extratoBancarioDrift.extratoBancario?.dataTransacao,
				valor: extratoBancarioDrift.extratoBancario?.valor,
				idTransacao: extratoBancarioDrift.extratoBancario?.idTransacao,
				checknum: extratoBancarioDrift.extratoBancario?.checknum,
				numeroReferencia: extratoBancarioDrift.extratoBancario?.numeroReferencia,
				historico: extratoBancarioDrift.extratoBancario?.historico,
				conciliado: ExtratoBancarioDomain.getConciliado(extratoBancarioDrift.extratoBancario?.conciliado),
			);
		} else {
			return null;
		}
	}


	ExtratoBancarioGrouped toDrift(ExtratoBancarioModel extratoBancarioModel) {
		return ExtratoBancarioGrouped(
			extratoBancario: ExtratoBancario(
				id: extratoBancarioModel.id,
				dataTransacao: extratoBancarioModel.dataTransacao,
				valor: extratoBancarioModel.valor,
				idTransacao: extratoBancarioModel.idTransacao,
				checknum: extratoBancarioModel.checknum,
				numeroReferencia: extratoBancarioModel.numeroReferencia,
				historico: extratoBancarioModel.historico,
				conciliado: ExtratoBancarioDomain.setConciliado(extratoBancarioModel.conciliado),
			),
		);
	}

		
}

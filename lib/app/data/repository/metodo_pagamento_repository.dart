import 'package:financeiro_pessoal/app/data/provider/drift/metodo_pagamento_drift_provider.dart';
import 'package:financeiro_pessoal/app/data/model/model_imports.dart';

class MetodoPagamentoRepository {
  final MetodoPagamentoDriftProvider metodoPagamentoDriftProvider;

  MetodoPagamentoRepository({required this.metodoPagamentoDriftProvider});

  Future getList({Filter? filter}) async {
		return await metodoPagamentoDriftProvider.getList(filter: filter);
  }

  Future<MetodoPagamentoModel?>? save({required MetodoPagamentoModel metodoPagamentoModel}) async {
    if (metodoPagamentoModel.id! > 0) {
			return await metodoPagamentoDriftProvider.update(metodoPagamentoModel);
    } else {
			return await metodoPagamentoDriftProvider.insert(metodoPagamentoModel);
    }   
  }

  Future<bool> delete({required int id}) async {
		return await metodoPagamentoDriftProvider.delete(id) ?? false;
	}
}
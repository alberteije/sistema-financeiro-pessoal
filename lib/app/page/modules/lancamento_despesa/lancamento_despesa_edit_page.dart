import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro_pessoal/app/controller/lancamento_despesa_controller.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';

class LancamentoDespesaEditPage extends StatelessWidget {
	LancamentoDespesaEditPage({Key? key}) : super(key: key);
	final lancamentoDespesaController = Get.find<LancamentoDespesaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					lancamentoDespesaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: lancamentoDespesaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Lançamento de Despesa - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: lancamentoDespesaController.save),
						cancelAndExitButton(onPressed: lancamentoDespesaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: lancamentoDespesaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: lancamentoDespesaController.scrollController,
							child: SingleChildScrollView(
								controller: lancamentoDespesaController.scrollController,
								child: BootstrapContainer(
									fluid: true,
									padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
									children: <Widget>[
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: lancamentoDespesaController.contaDespesaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Conta de Despesa',
																			labelText: 'Conta *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: lancamentoDespesaController.callContaDespesaLookup),
															),
														],
													),
												),
											],
										),
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Row(
														children: <Widget>[
															Expanded(
																flex: 1,
																child: SizedBox(
																	child: TextFormField(
																		controller: lancamentoDespesaController.metodoPagamentoModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Método de Pagamento',
																			labelText: 'Método Pagamento *',
																			usePadding: true,
																		),
																		onSaved: (String? value) {},
																		onChanged: (text) {},
																	),
																),
															),
															Expanded(
																flex: 0,
																child: lookupButton(onPressed: lancamentoDespesaController.callMetodoPagamentoLookup),
															),
														],
													),
												),
											],
										),
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Despesa',
																labelText: 'Data',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: lancamentoDespesaController.lancamentoDespesaModel.dataDespesa,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	lancamentoDespesaController.lancamentoDespesaModel.dataDespesa = value;
																	lancamentoDespesaController.formWasChanged = true;
																},
															),
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															controller: lancamentoDespesaController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancamentoDespesaController.lancamentoDespesaModel.valor = lancamentoDespesaController.valorController.numberValue;
																lancamentoDespesaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: lancamentoDespesaController.lancamentoDespesaModel.statusDespesa ?? 'Pago',
															labelText: 'Status',
															hintText: 'Informe os dados para o campo Status Despesa',
															items: const ['Pago','A Pagar'],
															onChanged: (dynamic newValue) {
																lancamentoDespesaController.lancamentoDespesaModel.statusDespesa = newValue;
																lancamentoDespesaController.formWasChanged = true;
															},
														),
													),
												),
											],
										),
										const Divider(
											color: Colors.transparent,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: TextFormField(
															autofocus: true,
															maxLength: 500,
															maxLines: 3,
															controller: lancamentoDespesaController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Histórico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancamentoDespesaController.lancamentoDespesaModel.historico = text;
																lancamentoDespesaController.formWasChanged = true;
															},
														),
													),
												),
											],
										),
										const Divider(
											indent: 10,
											endIndent: 10,
											thickness: 2,
										),
										BootstrapRow(
											height: 60,
											children: <BootstrapCol>[
												BootstrapCol(
													sizes: 'col-12',
													child: Text(
														'field_is_mandatory'.tr,
														style: Theme.of(context).textTheme.bodySmall,
													),
												),
											],
										),
										const SizedBox(height: 10.0),
									],
								),
							),
						),
					),
				),
			),
		);
	}
}

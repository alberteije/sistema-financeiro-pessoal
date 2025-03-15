import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro_pessoal/app/controller/lancamento_receita_controller.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';

class LancamentoReceitaEditPage extends StatelessWidget {
	LancamentoReceitaEditPage({Key? key}) : super(key: key);
	final lancamentoReceitaController = Get.find<LancamentoReceitaController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					lancamentoReceitaController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: lancamentoReceitaController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Lançamento de Receita - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: lancamentoReceitaController.save),
						cancelAndExitButton(onPressed: lancamentoReceitaController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: lancamentoReceitaController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: lancamentoReceitaController.scrollController,
							child: SingleChildScrollView(
								controller: lancamentoReceitaController.scrollController,
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
																		controller: lancamentoReceitaController.contaReceitaModelController,
																		validator: ValidateFormField.validateMandatory,
																		readOnly: true,
																		decoration: inputDecoration(
																			hintText: 'Importar Conta de Receita',
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
																child: lookupButton(onPressed: lancamentoReceitaController.callContaReceitaLookup),
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
																		controller: lancamentoReceitaController.metodoPagamentoModelController,
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
																child: lookupButton(onPressed: lancamentoReceitaController.callMetodoPagamentoLookup),
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
																hintText: 'Informe os dados para o campo Data Receita',
																labelText: 'Data',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: lancamentoReceitaController.lancamentoReceitaModel.dataReceita,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	lancamentoReceitaController.lancamentoReceitaModel.dataReceita = value;
																	lancamentoReceitaController.formWasChanged = true;
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
															controller: lancamentoReceitaController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancamentoReceitaController.lancamentoReceitaModel.valor = lancamentoReceitaController.valorController.numberValue;
																lancamentoReceitaController.formWasChanged = true;
															},
														),
													),
												),
												BootstrapCol(
													sizes: 'col-12 col-md-4',
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: CustomDropdownButtonFormField(
															value: lancamentoReceitaController.lancamentoReceitaModel.statusReceita ?? 'Recebido',
															labelText: 'Status',
															hintText: 'Informe os dados para o campo Status Receita',
															items: const ['Recebido','A Receber'],
															onChanged: (dynamic newValue) {
																lancamentoReceitaController.lancamentoReceitaModel.statusReceita = newValue;
																lancamentoReceitaController.formWasChanged = true;
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
															controller: lancamentoReceitaController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Histórico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																lancamentoReceitaController.lancamentoReceitaModel.historico = text;
																lancamentoReceitaController.formWasChanged = true;
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

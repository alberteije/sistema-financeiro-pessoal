import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro_pessoal/app/controller/extrato_bancario_controller.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';

class ExtratoBancarioEditPage extends StatelessWidget {
	ExtratoBancarioEditPage({Key? key}) : super(key: key);
	final extratoBancarioController = Get.find<ExtratoBancarioController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					extratoBancarioController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: extratoBancarioController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Extrato Bancário - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: extratoBancarioController.save),
						cancelAndExitButton(onPressed: extratoBancarioController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: extratoBancarioController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: extratoBancarioController.scrollController,
							child: SingleChildScrollView(
								controller: extratoBancarioController.scrollController,
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
													child: Padding(
														padding: Util.distanceBetweenColumnsLineBreak(context)!,
														child: InputDecorator(
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Data Transacao',
																labelText: 'Data',
																usePadding: true,
															),
															isEmpty: false,
															child: DatePickerItem(
																dateTime: extratoBancarioController.extratoBancarioModel.dataTransacao,
																firstDate: DateTime.parse('1000-01-01'),
																lastDate: DateTime.parse('5000-01-01'),
																onChanged: (DateTime? value) {
																	extratoBancarioController.extratoBancarioModel.dataTransacao = value;
																	extratoBancarioController.formWasChanged = true;
																},
															),
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
															controller: extratoBancarioController.valorController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor',
																labelText: 'Valor',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																extratoBancarioController.extratoBancarioModel.valor = extratoBancarioController.valorController.numberValue;
																extratoBancarioController.formWasChanged = true;
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
															maxLength: 30,
															controller: extratoBancarioController.idTransacaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Id Transacao',
																labelText: 'Id Transacao',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																extratoBancarioController.extratoBancarioModel.idTransacao = text;
																extratoBancarioController.formWasChanged = true;
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
															maxLength: 20,
															controller: extratoBancarioController.checknumController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Checknum',
																labelText: 'Número Checagem',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																extratoBancarioController.extratoBancarioModel.checknum = text;
																extratoBancarioController.formWasChanged = true;
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
															maxLength: 32,
															controller: extratoBancarioController.numeroReferenciaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Numero Referencia',
																labelText: 'Número Documento',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																extratoBancarioController.extratoBancarioModel.numeroReferencia = text;
																extratoBancarioController.formWasChanged = true;
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
															maxLength: 100,
															controller: extratoBancarioController.historicoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Historico',
																labelText: 'Histórico',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																extratoBancarioController.extratoBancarioModel.historico = text;
																extratoBancarioController.formWasChanged = true;
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
														child: CustomDropdownButtonFormField(
															value: extratoBancarioController.extratoBancarioModel.conciliado ?? 'Sim',
															labelText: 'Conciliado',
															hintText: 'Informe os dados para o campo Conciliado',
															items: const ['Sim','Não'],
															onChanged: (dynamic newValue) {
																extratoBancarioController.extratoBancarioModel.conciliado = newValue;
																extratoBancarioController.formWasChanged = true;
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/shared_widget_imports.dart';
import 'package:financeiro_pessoal/app/controller/resumo_controller.dart';
import 'package:financeiro_pessoal/app/infra/infra_imports.dart';
import 'package:financeiro_pessoal/app/page/shared_widget/input/input_imports.dart';

class ResumoEditPage extends StatelessWidget {
	ResumoEditPage({Key? key}) : super(key: key);
	final resumoController = Get.find<ResumoController>();

	@override
	Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
					resumoController.preventDataLoss();
				}
			},
			child: Scaffold(
				key: resumoController.scaffoldKey,
				appBar: AppBar(
					automaticallyImplyLeading: false,
					title: Text('Resumo - ${'editing'.tr}'),
					actions: [
						saveButton(onPressed: resumoController.save),
						cancelAndExitButton(onPressed: resumoController.preventDataLoss),
					]
				),
				body: SafeArea(
					top: false,
					bottom: false,
					child: Form(
						key: resumoController.formKey,
						autovalidateMode: AutovalidateMode.always,
						child: Scrollbar(
							controller: resumoController.scrollController,
							child: SingleChildScrollView(
								controller: resumoController.scrollController,
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
														child: CustomDropdownButtonFormField(
															value: resumoController.resumoModel.receitaDespesa ?? 'Receita',
															labelText: 'R | D',
															hintText: 'Informe os dados para o campo Receita Despesa',
															items: const ['Receita','Despesa'],
															onChanged: (dynamic newValue) {
																resumoController.resumoModel.receitaDespesa = newValue;
																resumoController.formWasChanged = true;
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
															maxLength: 4,
															controller: resumoController.codigoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Codigo',
																labelText: 'Código',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																resumoController.resumoModel.codigo = text;
																resumoController.formWasChanged = true;
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
															maxLength: 50,
															controller: resumoController.descricaoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Descricao',
																labelText: 'Descrição',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																resumoController.resumoModel.descricao = text;
																resumoController.formWasChanged = true;
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
															controller: resumoController.valorOrcadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Orcado',
																labelText: 'Valor Orçado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																resumoController.resumoModel.valorOrcado = resumoController.valorOrcadoController.numberValue;
																resumoController.formWasChanged = true;
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
															controller: resumoController.valorRealizadoController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Valor Realizado',
																labelText: 'Valor Realizado',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																resumoController.resumoModel.valorRealizado = resumoController.valorRealizadoController.numberValue;
																resumoController.formWasChanged = true;
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
															controller: resumoController.diferencaController,
															decoration: inputDecoration(
																hintText: 'Informe os dados para o campo Diferenca',
																labelText: 'Diferença',
																usePadding: true,
															),
															onSaved: (String? value) {},
															onChanged: (text) {
																resumoController.resumoModel.diferenca = resumoController.diferencaController.numberValue;
																resumoController.formWasChanged = true;
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

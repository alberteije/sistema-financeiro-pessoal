import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financeiro_pessoal/app/data/model/transient/filter.dart';

class FilterController extends GetxController {
  final _title = ''.obs;
  get title => _title.value;
  set title(value) => _title.value = value;

  final _standardFieldToSearchFor = ''.obs;
  get standardFieldToSearchFor => _standardFieldToSearchFor.value;
  set standardFieldToSearchFor(value) => _standardFieldToSearchFor.value = value;

  final _aliasColumns = [].obs ;
  get aliasColumns => _aliasColumns.value;
  set aliasColumns(value) => _aliasColumns.value = value;

  final _dbColumns = [].obs ;
  get dbColumns => _dbColumns.value;
  set dbColumns(value) => _dbColumns.value = value;

  final _standardFilter = true.obs;
  get standardFilter => _standardFilter.value;
  set standardFilter(value) => _standardFilter.value = value;

  final _filter = Filter().obs;
  get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();


  saveAndReturnValue() {
    final FormState form = formKey.currentState!;
    form.save();
    // Lets use SQL field rather camelCase Column to proceed with filter
    final indexOfColumn = aliasColumns.indexOf(filter.field);
    filter.field = dbColumns[indexOfColumn];
    Get.back(result: filter);
  }  
}
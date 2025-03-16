// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ContaDespesasTable extends ContaDespesas
    with TableInfo<$ContaDespesasTable, ContaDespesa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContaDespesasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, codigo, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conta_despesa';
  @override
  VerificationContext validateIntegrity(Insertable<ContaDespesa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContaDespesa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContaDespesa(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
    );
  }

  @override
  $ContaDespesasTable createAlias(String alias) {
    return $ContaDespesasTable(attachedDatabase, alias);
  }
}

class ContaDespesa extends DataClass implements Insertable<ContaDespesa> {
  final int? id;
  final String? codigo;
  final String? descricao;
  const ContaDespesa({this.id, this.codigo, this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  factory ContaDespesa.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContaDespesa(
      id: serializer.fromJson<int?>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  ContaDespesa copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> descricao = const Value.absent()}) =>
      ContaDespesa(
        id: id.present ? id.value : this.id,
        codigo: codigo.present ? codigo.value : this.codigo,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  ContaDespesa copyWithCompanion(ContaDespesasCompanion data) {
    return ContaDespesa(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContaDespesa(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, codigo, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContaDespesa &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao);
}

class ContaDespesasCompanion extends UpdateCompanion<ContaDespesa> {
  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> descricao;
  const ContaDespesasCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  ContaDespesasCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  static Insertable<ContaDespesa> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (descricao != null) 'descricao': descricao,
    });
  }

  ContaDespesasCompanion copyWith(
      {Value<int?>? id, Value<String?>? codigo, Value<String?>? descricao}) {
    return ContaDespesasCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContaDespesasCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $LancamentoDespesasTable extends LancamentoDespesas
    with TableInfo<$LancamentoDespesasTable, LancamentoDespesa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LancamentoDespesasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idContaDespesaMeta =
      const VerificationMeta('idContaDespesa');
  @override
  late final GeneratedColumn<int> idContaDespesa = GeneratedColumn<int>(
      'id_conta_despesa', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idMetodoPagamentoMeta =
      const VerificationMeta('idMetodoPagamento');
  @override
  late final GeneratedColumn<int> idMetodoPagamento = GeneratedColumn<int>(
      'id_metodo_pagamento', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dataDespesaMeta =
      const VerificationMeta('dataDespesa');
  @override
  late final GeneratedColumn<DateTime> dataDespesa = GeneratedColumn<DateTime>(
      'data_despesa', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusDespesaMeta =
      const VerificationMeta('statusDespesa');
  @override
  late final GeneratedColumn<String> statusDespesa = GeneratedColumn<String>(
      'status_despesa', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _historicoMeta =
      const VerificationMeta('historico');
  @override
  late final GeneratedColumn<String> historico = GeneratedColumn<String>(
      'historico', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idContaDespesa,
        idMetodoPagamento,
        dataDespesa,
        valor,
        statusDespesa,
        historico
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lancamento_despesa';
  @override
  VerificationContext validateIntegrity(Insertable<LancamentoDespesa> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_conta_despesa')) {
      context.handle(
          _idContaDespesaMeta,
          idContaDespesa.isAcceptableOrUnknown(
              data['id_conta_despesa']!, _idContaDespesaMeta));
    }
    if (data.containsKey('id_metodo_pagamento')) {
      context.handle(
          _idMetodoPagamentoMeta,
          idMetodoPagamento.isAcceptableOrUnknown(
              data['id_metodo_pagamento']!, _idMetodoPagamentoMeta));
    }
    if (data.containsKey('data_despesa')) {
      context.handle(
          _dataDespesaMeta,
          dataDespesa.isAcceptableOrUnknown(
              data['data_despesa']!, _dataDespesaMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    }
    if (data.containsKey('status_despesa')) {
      context.handle(
          _statusDespesaMeta,
          statusDespesa.isAcceptableOrUnknown(
              data['status_despesa']!, _statusDespesaMeta));
    }
    if (data.containsKey('historico')) {
      context.handle(_historicoMeta,
          historico.isAcceptableOrUnknown(data['historico']!, _historicoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LancamentoDespesa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LancamentoDespesa(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      idContaDespesa: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_conta_despesa']),
      idMetodoPagamento: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}id_metodo_pagamento']),
      dataDespesa: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_despesa']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor']),
      statusDespesa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_despesa']),
      historico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}historico']),
    );
  }

  @override
  $LancamentoDespesasTable createAlias(String alias) {
    return $LancamentoDespesasTable(attachedDatabase, alias);
  }
}

class LancamentoDespesa extends DataClass
    implements Insertable<LancamentoDespesa> {
  final int? id;
  final int? idContaDespesa;
  final int? idMetodoPagamento;
  final DateTime? dataDespesa;
  final double? valor;
  final String? statusDespesa;
  final String? historico;
  const LancamentoDespesa(
      {this.id,
      this.idContaDespesa,
      this.idMetodoPagamento,
      this.dataDespesa,
      this.valor,
      this.statusDespesa,
      this.historico});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idContaDespesa != null) {
      map['id_conta_despesa'] = Variable<int>(idContaDespesa);
    }
    if (!nullToAbsent || idMetodoPagamento != null) {
      map['id_metodo_pagamento'] = Variable<int>(idMetodoPagamento);
    }
    if (!nullToAbsent || dataDespesa != null) {
      map['data_despesa'] = Variable<DateTime>(dataDespesa);
    }
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<double>(valor);
    }
    if (!nullToAbsent || statusDespesa != null) {
      map['status_despesa'] = Variable<String>(statusDespesa);
    }
    if (!nullToAbsent || historico != null) {
      map['historico'] = Variable<String>(historico);
    }
    return map;
  }

  factory LancamentoDespesa.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LancamentoDespesa(
      id: serializer.fromJson<int?>(json['id']),
      idContaDespesa: serializer.fromJson<int?>(json['idContaDespesa']),
      idMetodoPagamento: serializer.fromJson<int?>(json['idMetodoPagamento']),
      dataDespesa: serializer.fromJson<DateTime?>(json['dataDespesa']),
      valor: serializer.fromJson<double?>(json['valor']),
      statusDespesa: serializer.fromJson<String?>(json['statusDespesa']),
      historico: serializer.fromJson<String?>(json['historico']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idContaDespesa': serializer.toJson<int?>(idContaDespesa),
      'idMetodoPagamento': serializer.toJson<int?>(idMetodoPagamento),
      'dataDespesa': serializer.toJson<DateTime?>(dataDespesa),
      'valor': serializer.toJson<double?>(valor),
      'statusDespesa': serializer.toJson<String?>(statusDespesa),
      'historico': serializer.toJson<String?>(historico),
    };
  }

  LancamentoDespesa copyWith(
          {Value<int?> id = const Value.absent(),
          Value<int?> idContaDespesa = const Value.absent(),
          Value<int?> idMetodoPagamento = const Value.absent(),
          Value<DateTime?> dataDespesa = const Value.absent(),
          Value<double?> valor = const Value.absent(),
          Value<String?> statusDespesa = const Value.absent(),
          Value<String?> historico = const Value.absent()}) =>
      LancamentoDespesa(
        id: id.present ? id.value : this.id,
        idContaDespesa:
            idContaDespesa.present ? idContaDespesa.value : this.idContaDespesa,
        idMetodoPagamento: idMetodoPagamento.present
            ? idMetodoPagamento.value
            : this.idMetodoPagamento,
        dataDespesa: dataDespesa.present ? dataDespesa.value : this.dataDespesa,
        valor: valor.present ? valor.value : this.valor,
        statusDespesa:
            statusDespesa.present ? statusDespesa.value : this.statusDespesa,
        historico: historico.present ? historico.value : this.historico,
      );
  LancamentoDespesa copyWithCompanion(LancamentoDespesasCompanion data) {
    return LancamentoDespesa(
      id: data.id.present ? data.id.value : this.id,
      idContaDespesa: data.idContaDespesa.present
          ? data.idContaDespesa.value
          : this.idContaDespesa,
      idMetodoPagamento: data.idMetodoPagamento.present
          ? data.idMetodoPagamento.value
          : this.idMetodoPagamento,
      dataDespesa:
          data.dataDespesa.present ? data.dataDespesa.value : this.dataDespesa,
      valor: data.valor.present ? data.valor.value : this.valor,
      statusDespesa: data.statusDespesa.present
          ? data.statusDespesa.value
          : this.statusDespesa,
      historico: data.historico.present ? data.historico.value : this.historico,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LancamentoDespesa(')
          ..write('id: $id, ')
          ..write('idContaDespesa: $idContaDespesa, ')
          ..write('idMetodoPagamento: $idMetodoPagamento, ')
          ..write('dataDespesa: $dataDespesa, ')
          ..write('valor: $valor, ')
          ..write('statusDespesa: $statusDespesa, ')
          ..write('historico: $historico')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idContaDespesa, idMetodoPagamento,
      dataDespesa, valor, statusDespesa, historico);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LancamentoDespesa &&
          other.id == this.id &&
          other.idContaDespesa == this.idContaDespesa &&
          other.idMetodoPagamento == this.idMetodoPagamento &&
          other.dataDespesa == this.dataDespesa &&
          other.valor == this.valor &&
          other.statusDespesa == this.statusDespesa &&
          other.historico == this.historico);
}

class LancamentoDespesasCompanion extends UpdateCompanion<LancamentoDespesa> {
  final Value<int?> id;
  final Value<int?> idContaDespesa;
  final Value<int?> idMetodoPagamento;
  final Value<DateTime?> dataDespesa;
  final Value<double?> valor;
  final Value<String?> statusDespesa;
  final Value<String?> historico;
  const LancamentoDespesasCompanion({
    this.id = const Value.absent(),
    this.idContaDespesa = const Value.absent(),
    this.idMetodoPagamento = const Value.absent(),
    this.dataDespesa = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusDespesa = const Value.absent(),
    this.historico = const Value.absent(),
  });
  LancamentoDespesasCompanion.insert({
    this.id = const Value.absent(),
    this.idContaDespesa = const Value.absent(),
    this.idMetodoPagamento = const Value.absent(),
    this.dataDespesa = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusDespesa = const Value.absent(),
    this.historico = const Value.absent(),
  });
  static Insertable<LancamentoDespesa> custom({
    Expression<int>? id,
    Expression<int>? idContaDespesa,
    Expression<int>? idMetodoPagamento,
    Expression<DateTime>? dataDespesa,
    Expression<double>? valor,
    Expression<String>? statusDespesa,
    Expression<String>? historico,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idContaDespesa != null) 'id_conta_despesa': idContaDespesa,
      if (idMetodoPagamento != null) 'id_metodo_pagamento': idMetodoPagamento,
      if (dataDespesa != null) 'data_despesa': dataDespesa,
      if (valor != null) 'valor': valor,
      if (statusDespesa != null) 'status_despesa': statusDespesa,
      if (historico != null) 'historico': historico,
    });
  }

  LancamentoDespesasCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? idContaDespesa,
      Value<int?>? idMetodoPagamento,
      Value<DateTime?>? dataDespesa,
      Value<double?>? valor,
      Value<String?>? statusDespesa,
      Value<String?>? historico}) {
    return LancamentoDespesasCompanion(
      id: id ?? this.id,
      idContaDespesa: idContaDespesa ?? this.idContaDespesa,
      idMetodoPagamento: idMetodoPagamento ?? this.idMetodoPagamento,
      dataDespesa: dataDespesa ?? this.dataDespesa,
      valor: valor ?? this.valor,
      statusDespesa: statusDespesa ?? this.statusDespesa,
      historico: historico ?? this.historico,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idContaDespesa.present) {
      map['id_conta_despesa'] = Variable<int>(idContaDespesa.value);
    }
    if (idMetodoPagamento.present) {
      map['id_metodo_pagamento'] = Variable<int>(idMetodoPagamento.value);
    }
    if (dataDespesa.present) {
      map['data_despesa'] = Variable<DateTime>(dataDespesa.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (statusDespesa.present) {
      map['status_despesa'] = Variable<String>(statusDespesa.value);
    }
    if (historico.present) {
      map['historico'] = Variable<String>(historico.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LancamentoDespesasCompanion(')
          ..write('id: $id, ')
          ..write('idContaDespesa: $idContaDespesa, ')
          ..write('idMetodoPagamento: $idMetodoPagamento, ')
          ..write('dataDespesa: $dataDespesa, ')
          ..write('valor: $valor, ')
          ..write('statusDespesa: $statusDespesa, ')
          ..write('historico: $historico')
          ..write(')'))
        .toString();
  }
}

class $ResumosTable extends Resumos with TableInfo<$ResumosTable, Resumo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResumosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _mesAnoMeta = const VerificationMeta('mesAno');
  @override
  late final GeneratedColumn<String> mesAno = GeneratedColumn<String>(
      'mes_ano', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 7),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _receitaDespesaMeta =
      const VerificationMeta('receitaDespesa');
  @override
  late final GeneratedColumn<String> receitaDespesa = GeneratedColumn<String>(
      'receita_despesa', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _valorOrcadoMeta =
      const VerificationMeta('valorOrcado');
  @override
  late final GeneratedColumn<double> valorOrcado = GeneratedColumn<double>(
      'valor_orcado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _valorRealizadoMeta =
      const VerificationMeta('valorRealizado');
  @override
  late final GeneratedColumn<double> valorRealizado = GeneratedColumn<double>(
      'valor_realizado', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _diferencaMeta =
      const VerificationMeta('diferenca');
  @override
  late final GeneratedColumn<double> diferenca = GeneratedColumn<double>(
      'diferenca', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        mesAno,
        receitaDespesa,
        codigo,
        descricao,
        valorOrcado,
        valorRealizado,
        diferenca
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'resumo';
  @override
  VerificationContext validateIntegrity(Insertable<Resumo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mes_ano')) {
      context.handle(_mesAnoMeta,
          mesAno.isAcceptableOrUnknown(data['mes_ano']!, _mesAnoMeta));
    }
    if (data.containsKey('receita_despesa')) {
      context.handle(
          _receitaDespesaMeta,
          receitaDespesa.isAcceptableOrUnknown(
              data['receita_despesa']!, _receitaDespesaMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('valor_orcado')) {
      context.handle(
          _valorOrcadoMeta,
          valorOrcado.isAcceptableOrUnknown(
              data['valor_orcado']!, _valorOrcadoMeta));
    }
    if (data.containsKey('valor_realizado')) {
      context.handle(
          _valorRealizadoMeta,
          valorRealizado.isAcceptableOrUnknown(
              data['valor_realizado']!, _valorRealizadoMeta));
    }
    if (data.containsKey('diferenca')) {
      context.handle(_diferencaMeta,
          diferenca.isAcceptableOrUnknown(data['diferenca']!, _diferencaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Resumo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Resumo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      mesAno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mes_ano']),
      receitaDespesa: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receita_despesa']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
      valorOrcado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_orcado']),
      valorRealizado: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor_realizado']),
      diferenca: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}diferenca']),
    );
  }

  @override
  $ResumosTable createAlias(String alias) {
    return $ResumosTable(attachedDatabase, alias);
  }
}

class Resumo extends DataClass implements Insertable<Resumo> {
  final int? id;
  final String? mesAno;
  final String? receitaDespesa;
  final String? codigo;
  final String? descricao;
  final double? valorOrcado;
  final double? valorRealizado;
  final double? diferenca;
  const Resumo(
      {this.id,
      this.mesAno,
      this.receitaDespesa,
      this.codigo,
      this.descricao,
      this.valorOrcado,
      this.valorRealizado,
      this.diferenca});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || mesAno != null) {
      map['mes_ano'] = Variable<String>(mesAno);
    }
    if (!nullToAbsent || receitaDespesa != null) {
      map['receita_despesa'] = Variable<String>(receitaDespesa);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    if (!nullToAbsent || valorOrcado != null) {
      map['valor_orcado'] = Variable<double>(valorOrcado);
    }
    if (!nullToAbsent || valorRealizado != null) {
      map['valor_realizado'] = Variable<double>(valorRealizado);
    }
    if (!nullToAbsent || diferenca != null) {
      map['diferenca'] = Variable<double>(diferenca);
    }
    return map;
  }

  factory Resumo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Resumo(
      id: serializer.fromJson<int?>(json['id']),
      mesAno: serializer.fromJson<String?>(json['mesAno']),
      receitaDespesa: serializer.fromJson<String?>(json['receitaDespesa']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      valorOrcado: serializer.fromJson<double?>(json['valorOrcado']),
      valorRealizado: serializer.fromJson<double?>(json['valorRealizado']),
      diferenca: serializer.fromJson<double?>(json['diferenca']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'mesAno': serializer.toJson<String?>(mesAno),
      'receitaDespesa': serializer.toJson<String?>(receitaDespesa),
      'codigo': serializer.toJson<String?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
      'valorOrcado': serializer.toJson<double?>(valorOrcado),
      'valorRealizado': serializer.toJson<double?>(valorRealizado),
      'diferenca': serializer.toJson<double?>(diferenca),
    };
  }

  Resumo copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> mesAno = const Value.absent(),
          Value<String?> receitaDespesa = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> descricao = const Value.absent(),
          Value<double?> valorOrcado = const Value.absent(),
          Value<double?> valorRealizado = const Value.absent(),
          Value<double?> diferenca = const Value.absent()}) =>
      Resumo(
        id: id.present ? id.value : this.id,
        mesAno: mesAno.present ? mesAno.value : this.mesAno,
        receitaDespesa:
            receitaDespesa.present ? receitaDespesa.value : this.receitaDespesa,
        codigo: codigo.present ? codigo.value : this.codigo,
        descricao: descricao.present ? descricao.value : this.descricao,
        valorOrcado: valorOrcado.present ? valorOrcado.value : this.valorOrcado,
        valorRealizado:
            valorRealizado.present ? valorRealizado.value : this.valorRealizado,
        diferenca: diferenca.present ? diferenca.value : this.diferenca,
      );
  Resumo copyWithCompanion(ResumosCompanion data) {
    return Resumo(
      id: data.id.present ? data.id.value : this.id,
      mesAno: data.mesAno.present ? data.mesAno.value : this.mesAno,
      receitaDespesa: data.receitaDespesa.present
          ? data.receitaDespesa.value
          : this.receitaDespesa,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
      valorOrcado:
          data.valorOrcado.present ? data.valorOrcado.value : this.valorOrcado,
      valorRealizado: data.valorRealizado.present
          ? data.valorRealizado.value
          : this.valorRealizado,
      diferenca: data.diferenca.present ? data.diferenca.value : this.diferenca,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Resumo(')
          ..write('id: $id, ')
          ..write('mesAno: $mesAno, ')
          ..write('receitaDespesa: $receitaDespesa, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('valorOrcado: $valorOrcado, ')
          ..write('valorRealizado: $valorRealizado, ')
          ..write('diferenca: $diferenca')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mesAno, receitaDespesa, codigo, descricao,
      valorOrcado, valorRealizado, diferenca);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Resumo &&
          other.id == this.id &&
          other.mesAno == this.mesAno &&
          other.receitaDespesa == this.receitaDespesa &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao &&
          other.valorOrcado == this.valorOrcado &&
          other.valorRealizado == this.valorRealizado &&
          other.diferenca == this.diferenca);
}

class ResumosCompanion extends UpdateCompanion<Resumo> {
  final Value<int?> id;
  final Value<String?> mesAno;
  final Value<String?> receitaDespesa;
  final Value<String?> codigo;
  final Value<String?> descricao;
  final Value<double?> valorOrcado;
  final Value<double?> valorRealizado;
  final Value<double?> diferenca;
  const ResumosCompanion({
    this.id = const Value.absent(),
    this.mesAno = const Value.absent(),
    this.receitaDespesa = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valorOrcado = const Value.absent(),
    this.valorRealizado = const Value.absent(),
    this.diferenca = const Value.absent(),
  });
  ResumosCompanion.insert({
    this.id = const Value.absent(),
    this.mesAno = const Value.absent(),
    this.receitaDespesa = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.valorOrcado = const Value.absent(),
    this.valorRealizado = const Value.absent(),
    this.diferenca = const Value.absent(),
  });
  static Insertable<Resumo> custom({
    Expression<int>? id,
    Expression<String>? mesAno,
    Expression<String>? receitaDespesa,
    Expression<String>? codigo,
    Expression<String>? descricao,
    Expression<double>? valorOrcado,
    Expression<double>? valorRealizado,
    Expression<double>? diferenca,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mesAno != null) 'mes_ano': mesAno,
      if (receitaDespesa != null) 'receita_despesa': receitaDespesa,
      if (codigo != null) 'codigo': codigo,
      if (descricao != null) 'descricao': descricao,
      if (valorOrcado != null) 'valor_orcado': valorOrcado,
      if (valorRealizado != null) 'valor_realizado': valorRealizado,
      if (diferenca != null) 'diferenca': diferenca,
    });
  }

  ResumosCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? mesAno,
      Value<String?>? receitaDespesa,
      Value<String?>? codigo,
      Value<String?>? descricao,
      Value<double?>? valorOrcado,
      Value<double?>? valorRealizado,
      Value<double?>? diferenca}) {
    return ResumosCompanion(
      id: id ?? this.id,
      mesAno: mesAno ?? this.mesAno,
      receitaDespesa: receitaDespesa ?? this.receitaDespesa,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
      valorOrcado: valorOrcado ?? this.valorOrcado,
      valorRealizado: valorRealizado ?? this.valorRealizado,
      diferenca: diferenca ?? this.diferenca,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mesAno.present) {
      map['mes_ano'] = Variable<String>(mesAno.value);
    }
    if (receitaDespesa.present) {
      map['receita_despesa'] = Variable<String>(receitaDespesa.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    if (valorOrcado.present) {
      map['valor_orcado'] = Variable<double>(valorOrcado.value);
    }
    if (valorRealizado.present) {
      map['valor_realizado'] = Variable<double>(valorRealizado.value);
    }
    if (diferenca.present) {
      map['diferenca'] = Variable<double>(diferenca.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResumosCompanion(')
          ..write('id: $id, ')
          ..write('mesAno: $mesAno, ')
          ..write('receitaDespesa: $receitaDespesa, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao, ')
          ..write('valorOrcado: $valorOrcado, ')
          ..write('valorRealizado: $valorRealizado, ')
          ..write('diferenca: $diferenca')
          ..write(')'))
        .toString();
  }
}

class $ExtratoBancariosTable extends ExtratoBancarios
    with TableInfo<$ExtratoBancariosTable, ExtratoBancario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExtratoBancariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dataTransacaoMeta =
      const VerificationMeta('dataTransacao');
  @override
  late final GeneratedColumn<DateTime> dataTransacao =
      GeneratedColumn<DateTime>('data_transacao', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _idTransacaoMeta =
      const VerificationMeta('idTransacao');
  @override
  late final GeneratedColumn<String> idTransacao = GeneratedColumn<String>(
      'id_transacao', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _checknumMeta =
      const VerificationMeta('checknum');
  @override
  late final GeneratedColumn<String> checknum = GeneratedColumn<String>(
      'checknum', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _numeroReferenciaMeta =
      const VerificationMeta('numeroReferencia');
  @override
  late final GeneratedColumn<String> numeroReferencia = GeneratedColumn<String>(
      'numero_referencia', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _historicoMeta =
      const VerificationMeta('historico');
  @override
  late final GeneratedColumn<String> historico = GeneratedColumn<String>(
      'historico', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _conciliadoMeta =
      const VerificationMeta('conciliado');
  @override
  late final GeneratedColumn<String> conciliado = GeneratedColumn<String>(
      'conciliado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dataTransacao,
        valor,
        idTransacao,
        checknum,
        numeroReferencia,
        historico,
        conciliado
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'extrato_bancario';
  @override
  VerificationContext validateIntegrity(Insertable<ExtratoBancario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('data_transacao')) {
      context.handle(
          _dataTransacaoMeta,
          dataTransacao.isAcceptableOrUnknown(
              data['data_transacao']!, _dataTransacaoMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    }
    if (data.containsKey('id_transacao')) {
      context.handle(
          _idTransacaoMeta,
          idTransacao.isAcceptableOrUnknown(
              data['id_transacao']!, _idTransacaoMeta));
    }
    if (data.containsKey('checknum')) {
      context.handle(_checknumMeta,
          checknum.isAcceptableOrUnknown(data['checknum']!, _checknumMeta));
    }
    if (data.containsKey('numero_referencia')) {
      context.handle(
          _numeroReferenciaMeta,
          numeroReferencia.isAcceptableOrUnknown(
              data['numero_referencia']!, _numeroReferenciaMeta));
    }
    if (data.containsKey('historico')) {
      context.handle(_historicoMeta,
          historico.isAcceptableOrUnknown(data['historico']!, _historicoMeta));
    }
    if (data.containsKey('conciliado')) {
      context.handle(
          _conciliadoMeta,
          conciliado.isAcceptableOrUnknown(
              data['conciliado']!, _conciliadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExtratoBancario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExtratoBancario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      dataTransacao: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}data_transacao']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor']),
      idTransacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_transacao']),
      checknum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}checknum']),
      numeroReferencia: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}numero_referencia']),
      historico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}historico']),
      conciliado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conciliado']),
    );
  }

  @override
  $ExtratoBancariosTable createAlias(String alias) {
    return $ExtratoBancariosTable(attachedDatabase, alias);
  }
}

class ExtratoBancario extends DataClass implements Insertable<ExtratoBancario> {
  final int? id;
  final DateTime? dataTransacao;
  final double? valor;
  final String? idTransacao;
  final String? checknum;
  final String? numeroReferencia;
  final String? historico;
  final String? conciliado;
  const ExtratoBancario(
      {this.id,
      this.dataTransacao,
      this.valor,
      this.idTransacao,
      this.checknum,
      this.numeroReferencia,
      this.historico,
      this.conciliado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || dataTransacao != null) {
      map['data_transacao'] = Variable<DateTime>(dataTransacao);
    }
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<double>(valor);
    }
    if (!nullToAbsent || idTransacao != null) {
      map['id_transacao'] = Variable<String>(idTransacao);
    }
    if (!nullToAbsent || checknum != null) {
      map['checknum'] = Variable<String>(checknum);
    }
    if (!nullToAbsent || numeroReferencia != null) {
      map['numero_referencia'] = Variable<String>(numeroReferencia);
    }
    if (!nullToAbsent || historico != null) {
      map['historico'] = Variable<String>(historico);
    }
    if (!nullToAbsent || conciliado != null) {
      map['conciliado'] = Variable<String>(conciliado);
    }
    return map;
  }

  factory ExtratoBancario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExtratoBancario(
      id: serializer.fromJson<int?>(json['id']),
      dataTransacao: serializer.fromJson<DateTime?>(json['dataTransacao']),
      valor: serializer.fromJson<double?>(json['valor']),
      idTransacao: serializer.fromJson<String?>(json['idTransacao']),
      checknum: serializer.fromJson<String?>(json['checknum']),
      numeroReferencia: serializer.fromJson<String?>(json['numeroReferencia']),
      historico: serializer.fromJson<String?>(json['historico']),
      conciliado: serializer.fromJson<String?>(json['conciliado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'dataTransacao': serializer.toJson<DateTime?>(dataTransacao),
      'valor': serializer.toJson<double?>(valor),
      'idTransacao': serializer.toJson<String?>(idTransacao),
      'checknum': serializer.toJson<String?>(checknum),
      'numeroReferencia': serializer.toJson<String?>(numeroReferencia),
      'historico': serializer.toJson<String?>(historico),
      'conciliado': serializer.toJson<String?>(conciliado),
    };
  }

  ExtratoBancario copyWith(
          {Value<int?> id = const Value.absent(),
          Value<DateTime?> dataTransacao = const Value.absent(),
          Value<double?> valor = const Value.absent(),
          Value<String?> idTransacao = const Value.absent(),
          Value<String?> checknum = const Value.absent(),
          Value<String?> numeroReferencia = const Value.absent(),
          Value<String?> historico = const Value.absent(),
          Value<String?> conciliado = const Value.absent()}) =>
      ExtratoBancario(
        id: id.present ? id.value : this.id,
        dataTransacao:
            dataTransacao.present ? dataTransacao.value : this.dataTransacao,
        valor: valor.present ? valor.value : this.valor,
        idTransacao: idTransacao.present ? idTransacao.value : this.idTransacao,
        checknum: checknum.present ? checknum.value : this.checknum,
        numeroReferencia: numeroReferencia.present
            ? numeroReferencia.value
            : this.numeroReferencia,
        historico: historico.present ? historico.value : this.historico,
        conciliado: conciliado.present ? conciliado.value : this.conciliado,
      );
  ExtratoBancario copyWithCompanion(ExtratoBancariosCompanion data) {
    return ExtratoBancario(
      id: data.id.present ? data.id.value : this.id,
      dataTransacao: data.dataTransacao.present
          ? data.dataTransacao.value
          : this.dataTransacao,
      valor: data.valor.present ? data.valor.value : this.valor,
      idTransacao:
          data.idTransacao.present ? data.idTransacao.value : this.idTransacao,
      checknum: data.checknum.present ? data.checknum.value : this.checknum,
      numeroReferencia: data.numeroReferencia.present
          ? data.numeroReferencia.value
          : this.numeroReferencia,
      historico: data.historico.present ? data.historico.value : this.historico,
      conciliado:
          data.conciliado.present ? data.conciliado.value : this.conciliado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExtratoBancario(')
          ..write('id: $id, ')
          ..write('dataTransacao: $dataTransacao, ')
          ..write('valor: $valor, ')
          ..write('idTransacao: $idTransacao, ')
          ..write('checknum: $checknum, ')
          ..write('numeroReferencia: $numeroReferencia, ')
          ..write('historico: $historico, ')
          ..write('conciliado: $conciliado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dataTransacao, valor, idTransacao,
      checknum, numeroReferencia, historico, conciliado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExtratoBancario &&
          other.id == this.id &&
          other.dataTransacao == this.dataTransacao &&
          other.valor == this.valor &&
          other.idTransacao == this.idTransacao &&
          other.checknum == this.checknum &&
          other.numeroReferencia == this.numeroReferencia &&
          other.historico == this.historico &&
          other.conciliado == this.conciliado);
}

class ExtratoBancariosCompanion extends UpdateCompanion<ExtratoBancario> {
  final Value<int?> id;
  final Value<DateTime?> dataTransacao;
  final Value<double?> valor;
  final Value<String?> idTransacao;
  final Value<String?> checknum;
  final Value<String?> numeroReferencia;
  final Value<String?> historico;
  final Value<String?> conciliado;
  const ExtratoBancariosCompanion({
    this.id = const Value.absent(),
    this.dataTransacao = const Value.absent(),
    this.valor = const Value.absent(),
    this.idTransacao = const Value.absent(),
    this.checknum = const Value.absent(),
    this.numeroReferencia = const Value.absent(),
    this.historico = const Value.absent(),
    this.conciliado = const Value.absent(),
  });
  ExtratoBancariosCompanion.insert({
    this.id = const Value.absent(),
    this.dataTransacao = const Value.absent(),
    this.valor = const Value.absent(),
    this.idTransacao = const Value.absent(),
    this.checknum = const Value.absent(),
    this.numeroReferencia = const Value.absent(),
    this.historico = const Value.absent(),
    this.conciliado = const Value.absent(),
  });
  static Insertable<ExtratoBancario> custom({
    Expression<int>? id,
    Expression<DateTime>? dataTransacao,
    Expression<double>? valor,
    Expression<String>? idTransacao,
    Expression<String>? checknum,
    Expression<String>? numeroReferencia,
    Expression<String>? historico,
    Expression<String>? conciliado,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dataTransacao != null) 'data_transacao': dataTransacao,
      if (valor != null) 'valor': valor,
      if (idTransacao != null) 'id_transacao': idTransacao,
      if (checknum != null) 'checknum': checknum,
      if (numeroReferencia != null) 'numero_referencia': numeroReferencia,
      if (historico != null) 'historico': historico,
      if (conciliado != null) 'conciliado': conciliado,
    });
  }

  ExtratoBancariosCompanion copyWith(
      {Value<int?>? id,
      Value<DateTime?>? dataTransacao,
      Value<double?>? valor,
      Value<String?>? idTransacao,
      Value<String?>? checknum,
      Value<String?>? numeroReferencia,
      Value<String?>? historico,
      Value<String?>? conciliado}) {
    return ExtratoBancariosCompanion(
      id: id ?? this.id,
      dataTransacao: dataTransacao ?? this.dataTransacao,
      valor: valor ?? this.valor,
      idTransacao: idTransacao ?? this.idTransacao,
      checknum: checknum ?? this.checknum,
      numeroReferencia: numeroReferencia ?? this.numeroReferencia,
      historico: historico ?? this.historico,
      conciliado: conciliado ?? this.conciliado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dataTransacao.present) {
      map['data_transacao'] = Variable<DateTime>(dataTransacao.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (idTransacao.present) {
      map['id_transacao'] = Variable<String>(idTransacao.value);
    }
    if (checknum.present) {
      map['checknum'] = Variable<String>(checknum.value);
    }
    if (numeroReferencia.present) {
      map['numero_referencia'] = Variable<String>(numeroReferencia.value);
    }
    if (historico.present) {
      map['historico'] = Variable<String>(historico.value);
    }
    if (conciliado.present) {
      map['conciliado'] = Variable<String>(conciliado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExtratoBancariosCompanion(')
          ..write('id: $id, ')
          ..write('dataTransacao: $dataTransacao, ')
          ..write('valor: $valor, ')
          ..write('idTransacao: $idTransacao, ')
          ..write('checknum: $checknum, ')
          ..write('numeroReferencia: $numeroReferencia, ')
          ..write('historico: $historico, ')
          ..write('conciliado: $conciliado')
          ..write(')'))
        .toString();
  }
}

class $MetodoPagamentosTable extends MetodoPagamentos
    with TableInfo<$MetodoPagamentosTable, MetodoPagamento> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetodoPagamentosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, codigo, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'metodo_pagamento';
  @override
  VerificationContext validateIntegrity(Insertable<MetodoPagamento> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MetodoPagamento map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetodoPagamento(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
    );
  }

  @override
  $MetodoPagamentosTable createAlias(String alias) {
    return $MetodoPagamentosTable(attachedDatabase, alias);
  }
}

class MetodoPagamento extends DataClass implements Insertable<MetodoPagamento> {
  final int? id;
  final String? codigo;
  final String? descricao;
  const MetodoPagamento({this.id, this.codigo, this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  factory MetodoPagamento.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetodoPagamento(
      id: serializer.fromJson<int?>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  MetodoPagamento copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> descricao = const Value.absent()}) =>
      MetodoPagamento(
        id: id.present ? id.value : this.id,
        codigo: codigo.present ? codigo.value : this.codigo,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  MetodoPagamento copyWithCompanion(MetodoPagamentosCompanion data) {
    return MetodoPagamento(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetodoPagamento(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, codigo, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetodoPagamento &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao);
}

class MetodoPagamentosCompanion extends UpdateCompanion<MetodoPagamento> {
  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> descricao;
  const MetodoPagamentosCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  MetodoPagamentosCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  static Insertable<MetodoPagamento> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (descricao != null) 'descricao': descricao,
    });
  }

  MetodoPagamentosCompanion copyWith(
      {Value<int?>? id, Value<String?>? codigo, Value<String?>? descricao}) {
    return MetodoPagamentosCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetodoPagamentosCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $ContaReceitasTable extends ContaReceitas
    with TableInfo<$ContaReceitasTable, ContaReceita> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContaReceitasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 4),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _descricaoMeta =
      const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String> descricao = GeneratedColumn<String>(
      'descricao', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, codigo, descricao];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'conta_receita';
  @override
  VerificationContext validateIntegrity(Insertable<ContaReceita> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContaReceita map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContaReceita(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo']),
      descricao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descricao']),
    );
  }

  @override
  $ContaReceitasTable createAlias(String alias) {
    return $ContaReceitasTable(attachedDatabase, alias);
  }
}

class ContaReceita extends DataClass implements Insertable<ContaReceita> {
  final int? id;
  final String? codigo;
  final String? descricao;
  const ContaReceita({this.id, this.codigo, this.descricao});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<String>(codigo);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String>(descricao);
    }
    return map;
  }

  factory ContaReceita.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContaReceita(
      id: serializer.fromJson<int?>(json['id']),
      codigo: serializer.fromJson<String?>(json['codigo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'codigo': serializer.toJson<String?>(codigo),
      'descricao': serializer.toJson<String?>(descricao),
    };
  }

  ContaReceita copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> codigo = const Value.absent(),
          Value<String?> descricao = const Value.absent()}) =>
      ContaReceita(
        id: id.present ? id.value : this.id,
        codigo: codigo.present ? codigo.value : this.codigo,
        descricao: descricao.present ? descricao.value : this.descricao,
      );
  ContaReceita copyWithCompanion(ContaReceitasCompanion data) {
    return ContaReceita(
      id: data.id.present ? data.id.value : this.id,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descricao: data.descricao.present ? data.descricao.value : this.descricao,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContaReceita(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, codigo, descricao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContaReceita &&
          other.id == this.id &&
          other.codigo == this.codigo &&
          other.descricao == this.descricao);
}

class ContaReceitasCompanion extends UpdateCompanion<ContaReceita> {
  final Value<int?> id;
  final Value<String?> codigo;
  final Value<String?> descricao;
  const ContaReceitasCompanion({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  ContaReceitasCompanion.insert({
    this.id = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descricao = const Value.absent(),
  });
  static Insertable<ContaReceita> custom({
    Expression<int>? id,
    Expression<String>? codigo,
    Expression<String>? descricao,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigo != null) 'codigo': codigo,
      if (descricao != null) 'descricao': descricao,
    });
  }

  ContaReceitasCompanion copyWith(
      {Value<int?>? id, Value<String?>? codigo, Value<String?>? descricao}) {
    return ContaReceitasCompanion(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      descricao: descricao ?? this.descricao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String>(descricao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContaReceitasCompanion(')
          ..write('id: $id, ')
          ..write('codigo: $codigo, ')
          ..write('descricao: $descricao')
          ..write(')'))
        .toString();
  }
}

class $LancamentoReceitasTable extends LancamentoReceitas
    with TableInfo<$LancamentoReceitasTable, LancamentoReceita> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LancamentoReceitasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idContaReceitaMeta =
      const VerificationMeta('idContaReceita');
  @override
  late final GeneratedColumn<int> idContaReceita = GeneratedColumn<int>(
      'id_conta_receita', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idMetodoPagamentoMeta =
      const VerificationMeta('idMetodoPagamento');
  @override
  late final GeneratedColumn<int> idMetodoPagamento = GeneratedColumn<int>(
      'id_metodo_pagamento', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _dataReceitaMeta =
      const VerificationMeta('dataReceita');
  @override
  late final GeneratedColumn<DateTime> dataReceita = GeneratedColumn<DateTime>(
      'data_receita', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<double> valor = GeneratedColumn<double>(
      'valor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusReceitaMeta =
      const VerificationMeta('statusReceita');
  @override
  late final GeneratedColumn<String> statusReceita = GeneratedColumn<String>(
      'status_receita', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _historicoMeta =
      const VerificationMeta('historico');
  @override
  late final GeneratedColumn<String> historico = GeneratedColumn<String>(
      'historico', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idContaReceita,
        idMetodoPagamento,
        dataReceita,
        valor,
        statusReceita,
        historico
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lancamento_receita';
  @override
  VerificationContext validateIntegrity(Insertable<LancamentoReceita> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_conta_receita')) {
      context.handle(
          _idContaReceitaMeta,
          idContaReceita.isAcceptableOrUnknown(
              data['id_conta_receita']!, _idContaReceitaMeta));
    }
    if (data.containsKey('id_metodo_pagamento')) {
      context.handle(
          _idMetodoPagamentoMeta,
          idMetodoPagamento.isAcceptableOrUnknown(
              data['id_metodo_pagamento']!, _idMetodoPagamentoMeta));
    }
    if (data.containsKey('data_receita')) {
      context.handle(
          _dataReceitaMeta,
          dataReceita.isAcceptableOrUnknown(
              data['data_receita']!, _dataReceitaMeta));
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    }
    if (data.containsKey('status_receita')) {
      context.handle(
          _statusReceitaMeta,
          statusReceita.isAcceptableOrUnknown(
              data['status_receita']!, _statusReceitaMeta));
    }
    if (data.containsKey('historico')) {
      context.handle(_historicoMeta,
          historico.isAcceptableOrUnknown(data['historico']!, _historicoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LancamentoReceita map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LancamentoReceita(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      idContaReceita: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_conta_receita']),
      idMetodoPagamento: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}id_metodo_pagamento']),
      dataReceita: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_receita']),
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}valor']),
      statusReceita: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status_receita']),
      historico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}historico']),
    );
  }

  @override
  $LancamentoReceitasTable createAlias(String alias) {
    return $LancamentoReceitasTable(attachedDatabase, alias);
  }
}

class LancamentoReceita extends DataClass
    implements Insertable<LancamentoReceita> {
  final int? id;
  final int? idContaReceita;
  final int? idMetodoPagamento;
  final DateTime? dataReceita;
  final double? valor;
  final String? statusReceita;
  final String? historico;
  const LancamentoReceita(
      {this.id,
      this.idContaReceita,
      this.idMetodoPagamento,
      this.dataReceita,
      this.valor,
      this.statusReceita,
      this.historico});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || idContaReceita != null) {
      map['id_conta_receita'] = Variable<int>(idContaReceita);
    }
    if (!nullToAbsent || idMetodoPagamento != null) {
      map['id_metodo_pagamento'] = Variable<int>(idMetodoPagamento);
    }
    if (!nullToAbsent || dataReceita != null) {
      map['data_receita'] = Variable<DateTime>(dataReceita);
    }
    if (!nullToAbsent || valor != null) {
      map['valor'] = Variable<double>(valor);
    }
    if (!nullToAbsent || statusReceita != null) {
      map['status_receita'] = Variable<String>(statusReceita);
    }
    if (!nullToAbsent || historico != null) {
      map['historico'] = Variable<String>(historico);
    }
    return map;
  }

  factory LancamentoReceita.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LancamentoReceita(
      id: serializer.fromJson<int?>(json['id']),
      idContaReceita: serializer.fromJson<int?>(json['idContaReceita']),
      idMetodoPagamento: serializer.fromJson<int?>(json['idMetodoPagamento']),
      dataReceita: serializer.fromJson<DateTime?>(json['dataReceita']),
      valor: serializer.fromJson<double?>(json['valor']),
      statusReceita: serializer.fromJson<String?>(json['statusReceita']),
      historico: serializer.fromJson<String?>(json['historico']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idContaReceita': serializer.toJson<int?>(idContaReceita),
      'idMetodoPagamento': serializer.toJson<int?>(idMetodoPagamento),
      'dataReceita': serializer.toJson<DateTime?>(dataReceita),
      'valor': serializer.toJson<double?>(valor),
      'statusReceita': serializer.toJson<String?>(statusReceita),
      'historico': serializer.toJson<String?>(historico),
    };
  }

  LancamentoReceita copyWith(
          {Value<int?> id = const Value.absent(),
          Value<int?> idContaReceita = const Value.absent(),
          Value<int?> idMetodoPagamento = const Value.absent(),
          Value<DateTime?> dataReceita = const Value.absent(),
          Value<double?> valor = const Value.absent(),
          Value<String?> statusReceita = const Value.absent(),
          Value<String?> historico = const Value.absent()}) =>
      LancamentoReceita(
        id: id.present ? id.value : this.id,
        idContaReceita:
            idContaReceita.present ? idContaReceita.value : this.idContaReceita,
        idMetodoPagamento: idMetodoPagamento.present
            ? idMetodoPagamento.value
            : this.idMetodoPagamento,
        dataReceita: dataReceita.present ? dataReceita.value : this.dataReceita,
        valor: valor.present ? valor.value : this.valor,
        statusReceita:
            statusReceita.present ? statusReceita.value : this.statusReceita,
        historico: historico.present ? historico.value : this.historico,
      );
  LancamentoReceita copyWithCompanion(LancamentoReceitasCompanion data) {
    return LancamentoReceita(
      id: data.id.present ? data.id.value : this.id,
      idContaReceita: data.idContaReceita.present
          ? data.idContaReceita.value
          : this.idContaReceita,
      idMetodoPagamento: data.idMetodoPagamento.present
          ? data.idMetodoPagamento.value
          : this.idMetodoPagamento,
      dataReceita:
          data.dataReceita.present ? data.dataReceita.value : this.dataReceita,
      valor: data.valor.present ? data.valor.value : this.valor,
      statusReceita: data.statusReceita.present
          ? data.statusReceita.value
          : this.statusReceita,
      historico: data.historico.present ? data.historico.value : this.historico,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LancamentoReceita(')
          ..write('id: $id, ')
          ..write('idContaReceita: $idContaReceita, ')
          ..write('idMetodoPagamento: $idMetodoPagamento, ')
          ..write('dataReceita: $dataReceita, ')
          ..write('valor: $valor, ')
          ..write('statusReceita: $statusReceita, ')
          ..write('historico: $historico')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idContaReceita, idMetodoPagamento,
      dataReceita, valor, statusReceita, historico);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LancamentoReceita &&
          other.id == this.id &&
          other.idContaReceita == this.idContaReceita &&
          other.idMetodoPagamento == this.idMetodoPagamento &&
          other.dataReceita == this.dataReceita &&
          other.valor == this.valor &&
          other.statusReceita == this.statusReceita &&
          other.historico == this.historico);
}

class LancamentoReceitasCompanion extends UpdateCompanion<LancamentoReceita> {
  final Value<int?> id;
  final Value<int?> idContaReceita;
  final Value<int?> idMetodoPagamento;
  final Value<DateTime?> dataReceita;
  final Value<double?> valor;
  final Value<String?> statusReceita;
  final Value<String?> historico;
  const LancamentoReceitasCompanion({
    this.id = const Value.absent(),
    this.idContaReceita = const Value.absent(),
    this.idMetodoPagamento = const Value.absent(),
    this.dataReceita = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusReceita = const Value.absent(),
    this.historico = const Value.absent(),
  });
  LancamentoReceitasCompanion.insert({
    this.id = const Value.absent(),
    this.idContaReceita = const Value.absent(),
    this.idMetodoPagamento = const Value.absent(),
    this.dataReceita = const Value.absent(),
    this.valor = const Value.absent(),
    this.statusReceita = const Value.absent(),
    this.historico = const Value.absent(),
  });
  static Insertable<LancamentoReceita> custom({
    Expression<int>? id,
    Expression<int>? idContaReceita,
    Expression<int>? idMetodoPagamento,
    Expression<DateTime>? dataReceita,
    Expression<double>? valor,
    Expression<String>? statusReceita,
    Expression<String>? historico,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idContaReceita != null) 'id_conta_receita': idContaReceita,
      if (idMetodoPagamento != null) 'id_metodo_pagamento': idMetodoPagamento,
      if (dataReceita != null) 'data_receita': dataReceita,
      if (valor != null) 'valor': valor,
      if (statusReceita != null) 'status_receita': statusReceita,
      if (historico != null) 'historico': historico,
    });
  }

  LancamentoReceitasCompanion copyWith(
      {Value<int?>? id,
      Value<int?>? idContaReceita,
      Value<int?>? idMetodoPagamento,
      Value<DateTime?>? dataReceita,
      Value<double?>? valor,
      Value<String?>? statusReceita,
      Value<String?>? historico}) {
    return LancamentoReceitasCompanion(
      id: id ?? this.id,
      idContaReceita: idContaReceita ?? this.idContaReceita,
      idMetodoPagamento: idMetodoPagamento ?? this.idMetodoPagamento,
      dataReceita: dataReceita ?? this.dataReceita,
      valor: valor ?? this.valor,
      statusReceita: statusReceita ?? this.statusReceita,
      historico: historico ?? this.historico,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idContaReceita.present) {
      map['id_conta_receita'] = Variable<int>(idContaReceita.value);
    }
    if (idMetodoPagamento.present) {
      map['id_metodo_pagamento'] = Variable<int>(idMetodoPagamento.value);
    }
    if (dataReceita.present) {
      map['data_receita'] = Variable<DateTime>(dataReceita.value);
    }
    if (valor.present) {
      map['valor'] = Variable<double>(valor.value);
    }
    if (statusReceita.present) {
      map['status_receita'] = Variable<String>(statusReceita.value);
    }
    if (historico.present) {
      map['historico'] = Variable<String>(historico.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LancamentoReceitasCompanion(')
          ..write('id: $id, ')
          ..write('idContaReceita: $idContaReceita, ')
          ..write('idMetodoPagamento: $idMetodoPagamento, ')
          ..write('dataReceita: $dataReceita, ')
          ..write('valor: $valor, ')
          ..write('statusReceita: $statusReceita, ')
          ..write('historico: $historico')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<String> login = GeneratedColumn<String>(
      'login', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _senhaMeta = const VerificationMeta('senha');
  @override
  late final GeneratedColumn<String> senha = GeneratedColumn<String>(
      'senha', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, login, senha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuario';
  @override
  VerificationContext validateIntegrity(Insertable<Usuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('login')) {
      context.handle(
          _loginMeta, login.isAcceptableOrUnknown(data['login']!, _loginMeta));
    }
    if (data.containsKey('senha')) {
      context.handle(
          _senhaMeta, senha.isAcceptableOrUnknown(data['senha']!, _senhaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      login: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}login']),
      senha: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}senha']),
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int? id;
  final String? login;
  final String? senha;
  const Usuario({this.id, this.login, this.senha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || login != null) {
      map['login'] = Variable<String>(login);
    }
    if (!nullToAbsent || senha != null) {
      map['senha'] = Variable<String>(senha);
    }
    return map;
  }

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int?>(json['id']),
      login: serializer.fromJson<String?>(json['login']),
      senha: serializer.fromJson<String?>(json['senha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'login': serializer.toJson<String?>(login),
      'senha': serializer.toJson<String?>(senha),
    };
  }

  Usuario copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> login = const Value.absent(),
          Value<String?> senha = const Value.absent()}) =>
      Usuario(
        id: id.present ? id.value : this.id,
        login: login.present ? login.value : this.login,
        senha: senha.present ? senha.value : this.senha,
      );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      login: data.login.present ? data.login.value : this.login,
      senha: data.senha.present ? data.senha.value : this.senha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('senha: $senha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, login, senha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.login == this.login &&
          other.senha == this.senha);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int?> id;
  final Value<String?> login;
  final Value<String?> senha;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.senha = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    this.login = const Value.absent(),
    this.senha = const Value.absent(),
  });
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? login,
    Expression<String>? senha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (login != null) 'login': login,
      if (senha != null) 'senha': senha,
    });
  }

  UsuariosCompanion copyWith(
      {Value<int?>? id, Value<String?>? login, Value<String?>? senha}) {
    return UsuariosCompanion(
      id: id ?? this.id,
      login: login ?? this.login,
      senha: senha ?? this.senha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (login.present) {
      map['login'] = Variable<String>(login.value);
    }
    if (senha.present) {
      map['senha'] = Variable<String>(senha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('login: $login, ')
          ..write('senha: $senha')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ContaDespesasTable contaDespesas = $ContaDespesasTable(this);
  late final $LancamentoDespesasTable lancamentoDespesas =
      $LancamentoDespesasTable(this);
  late final $ResumosTable resumos = $ResumosTable(this);
  late final $ExtratoBancariosTable extratoBancarios =
      $ExtratoBancariosTable(this);
  late final $MetodoPagamentosTable metodoPagamentos =
      $MetodoPagamentosTable(this);
  late final $ContaReceitasTable contaReceitas = $ContaReceitasTable(this);
  late final $LancamentoReceitasTable lancamentoReceitas =
      $LancamentoReceitasTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final ContaDespesaDao contaDespesaDao =
      ContaDespesaDao(this as AppDatabase);
  late final LancamentoDespesaDao lancamentoDespesaDao =
      LancamentoDespesaDao(this as AppDatabase);
  late final ResumoDao resumoDao = ResumoDao(this as AppDatabase);
  late final ExtratoBancarioDao extratoBancarioDao =
      ExtratoBancarioDao(this as AppDatabase);
  late final MetodoPagamentoDao metodoPagamentoDao =
      MetodoPagamentoDao(this as AppDatabase);
  late final ContaReceitaDao contaReceitaDao =
      ContaReceitaDao(this as AppDatabase);
  late final LancamentoReceitaDao lancamentoReceitaDao =
      LancamentoReceitaDao(this as AppDatabase);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        contaDespesas,
        lancamentoDespesas,
        resumos,
        extratoBancarios,
        metodoPagamentos,
        contaReceitas,
        lancamentoReceitas,
        usuarios
      ];
}

typedef $$ContaDespesasTableCreateCompanionBuilder = ContaDespesasCompanion
    Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});
typedef $$ContaDespesasTableUpdateCompanionBuilder = ContaDespesasCompanion
    Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});

class $$ContaDespesasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContaDespesasTable,
    ContaDespesa,
    $$ContaDespesasTableFilterComposer,
    $$ContaDespesasTableOrderingComposer,
    $$ContaDespesasTableCreateCompanionBuilder,
    $$ContaDespesasTableUpdateCompanionBuilder> {
  $$ContaDespesasTableTableManager(_$AppDatabase db, $ContaDespesasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContaDespesasTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContaDespesasTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              ContaDespesasCompanion(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              ContaDespesasCompanion.insert(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
        ));
}

class $$ContaDespesasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContaDespesasTable> {
  $$ContaDespesasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ContaDespesasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContaDespesasTable> {
  $$ContaDespesasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LancamentoDespesasTableCreateCompanionBuilder
    = LancamentoDespesasCompanion Function({
  Value<int?> id,
  Value<int?> idContaDespesa,
  Value<int?> idMetodoPagamento,
  Value<DateTime?> dataDespesa,
  Value<double?> valor,
  Value<String?> statusDespesa,
  Value<String?> historico,
});
typedef $$LancamentoDespesasTableUpdateCompanionBuilder
    = LancamentoDespesasCompanion Function({
  Value<int?> id,
  Value<int?> idContaDespesa,
  Value<int?> idMetodoPagamento,
  Value<DateTime?> dataDespesa,
  Value<double?> valor,
  Value<String?> statusDespesa,
  Value<String?> historico,
});

class $$LancamentoDespesasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LancamentoDespesasTable,
    LancamentoDespesa,
    $$LancamentoDespesasTableFilterComposer,
    $$LancamentoDespesasTableOrderingComposer,
    $$LancamentoDespesasTableCreateCompanionBuilder,
    $$LancamentoDespesasTableUpdateCompanionBuilder> {
  $$LancamentoDespesasTableTableManager(
      _$AppDatabase db, $LancamentoDespesasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LancamentoDespesasTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$LancamentoDespesasTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idContaDespesa = const Value.absent(),
            Value<int?> idMetodoPagamento = const Value.absent(),
            Value<DateTime?> dataDespesa = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> statusDespesa = const Value.absent(),
            Value<String?> historico = const Value.absent(),
          }) =>
              LancamentoDespesasCompanion(
            id: id,
            idContaDespesa: idContaDespesa,
            idMetodoPagamento: idMetodoPagamento,
            dataDespesa: dataDespesa,
            valor: valor,
            statusDespesa: statusDespesa,
            historico: historico,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idContaDespesa = const Value.absent(),
            Value<int?> idMetodoPagamento = const Value.absent(),
            Value<DateTime?> dataDespesa = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> statusDespesa = const Value.absent(),
            Value<String?> historico = const Value.absent(),
          }) =>
              LancamentoDespesasCompanion.insert(
            id: id,
            idContaDespesa: idContaDespesa,
            idMetodoPagamento: idMetodoPagamento,
            dataDespesa: dataDespesa,
            valor: valor,
            statusDespesa: statusDespesa,
            historico: historico,
          ),
        ));
}

class $$LancamentoDespesasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LancamentoDespesasTable> {
  $$LancamentoDespesasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idContaDespesa => $state.composableBuilder(
      column: $state.table.idContaDespesa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idMetodoPagamento => $state.composableBuilder(
      column: $state.table.idMetodoPagamento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dataDespesa => $state.composableBuilder(
      column: $state.table.dataDespesa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusDespesa => $state.composableBuilder(
      column: $state.table.statusDespesa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LancamentoDespesasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LancamentoDespesasTable> {
  $$LancamentoDespesasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idContaDespesa => $state.composableBuilder(
      column: $state.table.idContaDespesa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idMetodoPagamento => $state.composableBuilder(
      column: $state.table.idMetodoPagamento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dataDespesa => $state.composableBuilder(
      column: $state.table.dataDespesa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusDespesa => $state.composableBuilder(
      column: $state.table.statusDespesa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ResumosTableCreateCompanionBuilder = ResumosCompanion Function({
  Value<int?> id,
  Value<String?> mesAno,
  Value<String?> receitaDespesa,
  Value<String?> codigo,
  Value<String?> descricao,
  Value<double?> valorOrcado,
  Value<double?> valorRealizado,
  Value<double?> diferenca,
});
typedef $$ResumosTableUpdateCompanionBuilder = ResumosCompanion Function({
  Value<int?> id,
  Value<String?> mesAno,
  Value<String?> receitaDespesa,
  Value<String?> codigo,
  Value<String?> descricao,
  Value<double?> valorOrcado,
  Value<double?> valorRealizado,
  Value<double?> diferenca,
});

class $$ResumosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ResumosTable,
    Resumo,
    $$ResumosTableFilterComposer,
    $$ResumosTableOrderingComposer,
    $$ResumosTableCreateCompanionBuilder,
    $$ResumosTableUpdateCompanionBuilder> {
  $$ResumosTableTableManager(_$AppDatabase db, $ResumosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ResumosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ResumosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> mesAno = const Value.absent(),
            Value<String?> receitaDespesa = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<double?> valorOrcado = const Value.absent(),
            Value<double?> valorRealizado = const Value.absent(),
            Value<double?> diferenca = const Value.absent(),
          }) =>
              ResumosCompanion(
            id: id,
            mesAno: mesAno,
            receitaDespesa: receitaDespesa,
            codigo: codigo,
            descricao: descricao,
            valorOrcado: valorOrcado,
            valorRealizado: valorRealizado,
            diferenca: diferenca,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> mesAno = const Value.absent(),
            Value<String?> receitaDespesa = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
            Value<double?> valorOrcado = const Value.absent(),
            Value<double?> valorRealizado = const Value.absent(),
            Value<double?> diferenca = const Value.absent(),
          }) =>
              ResumosCompanion.insert(
            id: id,
            mesAno: mesAno,
            receitaDespesa: receitaDespesa,
            codigo: codigo,
            descricao: descricao,
            valorOrcado: valorOrcado,
            valorRealizado: valorRealizado,
            diferenca: diferenca,
          ),
        ));
}

class $$ResumosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ResumosTable> {
  $$ResumosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mesAno => $state.composableBuilder(
      column: $state.table.mesAno,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receitaDespesa => $state.composableBuilder(
      column: $state.table.receitaDespesa,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get valorOrcado => $state.composableBuilder(
      column: $state.table.valorOrcado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get valorRealizado => $state.composableBuilder(
      column: $state.table.valorRealizado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get diferenca => $state.composableBuilder(
      column: $state.table.diferenca,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ResumosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ResumosTable> {
  $$ResumosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mesAno => $state.composableBuilder(
      column: $state.table.mesAno,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receitaDespesa => $state.composableBuilder(
      column: $state.table.receitaDespesa,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get valorOrcado => $state.composableBuilder(
      column: $state.table.valorOrcado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get valorRealizado => $state.composableBuilder(
      column: $state.table.valorRealizado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get diferenca => $state.composableBuilder(
      column: $state.table.diferenca,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ExtratoBancariosTableCreateCompanionBuilder
    = ExtratoBancariosCompanion Function({
  Value<int?> id,
  Value<DateTime?> dataTransacao,
  Value<double?> valor,
  Value<String?> idTransacao,
  Value<String?> checknum,
  Value<String?> numeroReferencia,
  Value<String?> historico,
  Value<String?> conciliado,
});
typedef $$ExtratoBancariosTableUpdateCompanionBuilder
    = ExtratoBancariosCompanion Function({
  Value<int?> id,
  Value<DateTime?> dataTransacao,
  Value<double?> valor,
  Value<String?> idTransacao,
  Value<String?> checknum,
  Value<String?> numeroReferencia,
  Value<String?> historico,
  Value<String?> conciliado,
});

class $$ExtratoBancariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExtratoBancariosTable,
    ExtratoBancario,
    $$ExtratoBancariosTableFilterComposer,
    $$ExtratoBancariosTableOrderingComposer,
    $$ExtratoBancariosTableCreateCompanionBuilder,
    $$ExtratoBancariosTableUpdateCompanionBuilder> {
  $$ExtratoBancariosTableTableManager(
      _$AppDatabase db, $ExtratoBancariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExtratoBancariosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ExtratoBancariosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> dataTransacao = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> idTransacao = const Value.absent(),
            Value<String?> checknum = const Value.absent(),
            Value<String?> numeroReferencia = const Value.absent(),
            Value<String?> historico = const Value.absent(),
            Value<String?> conciliado = const Value.absent(),
          }) =>
              ExtratoBancariosCompanion(
            id: id,
            dataTransacao: dataTransacao,
            valor: valor,
            idTransacao: idTransacao,
            checknum: checknum,
            numeroReferencia: numeroReferencia,
            historico: historico,
            conciliado: conciliado,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<DateTime?> dataTransacao = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> idTransacao = const Value.absent(),
            Value<String?> checknum = const Value.absent(),
            Value<String?> numeroReferencia = const Value.absent(),
            Value<String?> historico = const Value.absent(),
            Value<String?> conciliado = const Value.absent(),
          }) =>
              ExtratoBancariosCompanion.insert(
            id: id,
            dataTransacao: dataTransacao,
            valor: valor,
            idTransacao: idTransacao,
            checknum: checknum,
            numeroReferencia: numeroReferencia,
            historico: historico,
            conciliado: conciliado,
          ),
        ));
}

class $$ExtratoBancariosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExtratoBancariosTable> {
  $$ExtratoBancariosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dataTransacao => $state.composableBuilder(
      column: $state.table.dataTransacao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get idTransacao => $state.composableBuilder(
      column: $state.table.idTransacao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get checknum => $state.composableBuilder(
      column: $state.table.checknum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get numeroReferencia => $state.composableBuilder(
      column: $state.table.numeroReferencia,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get conciliado => $state.composableBuilder(
      column: $state.table.conciliado,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ExtratoBancariosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExtratoBancariosTable> {
  $$ExtratoBancariosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dataTransacao => $state.composableBuilder(
      column: $state.table.dataTransacao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get idTransacao => $state.composableBuilder(
      column: $state.table.idTransacao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get checknum => $state.composableBuilder(
      column: $state.table.checknum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get numeroReferencia => $state.composableBuilder(
      column: $state.table.numeroReferencia,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get conciliado => $state.composableBuilder(
      column: $state.table.conciliado,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MetodoPagamentosTableCreateCompanionBuilder
    = MetodoPagamentosCompanion Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});
typedef $$MetodoPagamentosTableUpdateCompanionBuilder
    = MetodoPagamentosCompanion Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});

class $$MetodoPagamentosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MetodoPagamentosTable,
    MetodoPagamento,
    $$MetodoPagamentosTableFilterComposer,
    $$MetodoPagamentosTableOrderingComposer,
    $$MetodoPagamentosTableCreateCompanionBuilder,
    $$MetodoPagamentosTableUpdateCompanionBuilder> {
  $$MetodoPagamentosTableTableManager(
      _$AppDatabase db, $MetodoPagamentosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MetodoPagamentosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MetodoPagamentosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              MetodoPagamentosCompanion(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              MetodoPagamentosCompanion.insert(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
        ));
}

class $$MetodoPagamentosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MetodoPagamentosTable> {
  $$MetodoPagamentosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$MetodoPagamentosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MetodoPagamentosTable> {
  $$MetodoPagamentosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ContaReceitasTableCreateCompanionBuilder = ContaReceitasCompanion
    Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});
typedef $$ContaReceitasTableUpdateCompanionBuilder = ContaReceitasCompanion
    Function({
  Value<int?> id,
  Value<String?> codigo,
  Value<String?> descricao,
});

class $$ContaReceitasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContaReceitasTable,
    ContaReceita,
    $$ContaReceitasTableFilterComposer,
    $$ContaReceitasTableOrderingComposer,
    $$ContaReceitasTableCreateCompanionBuilder,
    $$ContaReceitasTableUpdateCompanionBuilder> {
  $$ContaReceitasTableTableManager(_$AppDatabase db, $ContaReceitasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ContaReceitasTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ContaReceitasTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              ContaReceitasCompanion(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> codigo = const Value.absent(),
            Value<String?> descricao = const Value.absent(),
          }) =>
              ContaReceitasCompanion.insert(
            id: id,
            codigo: codigo,
            descricao: descricao,
          ),
        ));
}

class $$ContaReceitasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ContaReceitasTable> {
  $$ContaReceitasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ContaReceitasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ContaReceitasTable> {
  $$ContaReceitasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get codigo => $state.composableBuilder(
      column: $state.table.codigo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get descricao => $state.composableBuilder(
      column: $state.table.descricao,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$LancamentoReceitasTableCreateCompanionBuilder
    = LancamentoReceitasCompanion Function({
  Value<int?> id,
  Value<int?> idContaReceita,
  Value<int?> idMetodoPagamento,
  Value<DateTime?> dataReceita,
  Value<double?> valor,
  Value<String?> statusReceita,
  Value<String?> historico,
});
typedef $$LancamentoReceitasTableUpdateCompanionBuilder
    = LancamentoReceitasCompanion Function({
  Value<int?> id,
  Value<int?> idContaReceita,
  Value<int?> idMetodoPagamento,
  Value<DateTime?> dataReceita,
  Value<double?> valor,
  Value<String?> statusReceita,
  Value<String?> historico,
});

class $$LancamentoReceitasTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LancamentoReceitasTable,
    LancamentoReceita,
    $$LancamentoReceitasTableFilterComposer,
    $$LancamentoReceitasTableOrderingComposer,
    $$LancamentoReceitasTableCreateCompanionBuilder,
    $$LancamentoReceitasTableUpdateCompanionBuilder> {
  $$LancamentoReceitasTableTableManager(
      _$AppDatabase db, $LancamentoReceitasTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$LancamentoReceitasTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$LancamentoReceitasTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idContaReceita = const Value.absent(),
            Value<int?> idMetodoPagamento = const Value.absent(),
            Value<DateTime?> dataReceita = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> statusReceita = const Value.absent(),
            Value<String?> historico = const Value.absent(),
          }) =>
              LancamentoReceitasCompanion(
            id: id,
            idContaReceita: idContaReceita,
            idMetodoPagamento: idMetodoPagamento,
            dataReceita: dataReceita,
            valor: valor,
            statusReceita: statusReceita,
            historico: historico,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<int?> idContaReceita = const Value.absent(),
            Value<int?> idMetodoPagamento = const Value.absent(),
            Value<DateTime?> dataReceita = const Value.absent(),
            Value<double?> valor = const Value.absent(),
            Value<String?> statusReceita = const Value.absent(),
            Value<String?> historico = const Value.absent(),
          }) =>
              LancamentoReceitasCompanion.insert(
            id: id,
            idContaReceita: idContaReceita,
            idMetodoPagamento: idMetodoPagamento,
            dataReceita: dataReceita,
            valor: valor,
            statusReceita: statusReceita,
            historico: historico,
          ),
        ));
}

class $$LancamentoReceitasTableFilterComposer
    extends FilterComposer<_$AppDatabase, $LancamentoReceitasTable> {
  $$LancamentoReceitasTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idContaReceita => $state.composableBuilder(
      column: $state.table.idContaReceita,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get idMetodoPagamento => $state.composableBuilder(
      column: $state.table.idMetodoPagamento,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get dataReceita => $state.composableBuilder(
      column: $state.table.dataReceita,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get statusReceita => $state.composableBuilder(
      column: $state.table.statusReceita,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$LancamentoReceitasTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $LancamentoReceitasTable> {
  $$LancamentoReceitasTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idContaReceita => $state.composableBuilder(
      column: $state.table.idContaReceita,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get idMetodoPagamento => $state.composableBuilder(
      column: $state.table.idMetodoPagamento,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get dataReceita => $state.composableBuilder(
      column: $state.table.dataReceita,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get valor => $state.composableBuilder(
      column: $state.table.valor,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get statusReceita => $state.composableBuilder(
      column: $state.table.statusReceita,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get historico => $state.composableBuilder(
      column: $state.table.historico,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UsuariosTableCreateCompanionBuilder = UsuariosCompanion Function({
  Value<int?> id,
  Value<String?> login,
  Value<String?> senha,
});
typedef $$UsuariosTableUpdateCompanionBuilder = UsuariosCompanion Function({
  Value<int?> id,
  Value<String?> login,
  Value<String?> senha,
});

class $$UsuariosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsuariosTable,
    Usuario,
    $$UsuariosTableFilterComposer,
    $$UsuariosTableOrderingComposer,
    $$UsuariosTableCreateCompanionBuilder,
    $$UsuariosTableUpdateCompanionBuilder> {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UsuariosTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UsuariosTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> login = const Value.absent(),
            Value<String?> senha = const Value.absent(),
          }) =>
              UsuariosCompanion(
            id: id,
            login: login,
            senha: senha,
          ),
          createCompanionCallback: ({
            Value<int?> id = const Value.absent(),
            Value<String?> login = const Value.absent(),
            Value<String?> senha = const Value.absent(),
          }) =>
              UsuariosCompanion.insert(
            id: id,
            login: login,
            senha: senha,
          ),
        ));
}

class $$UsuariosTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get login => $state.composableBuilder(
      column: $state.table.login,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get senha => $state.composableBuilder(
      column: $state.table.senha,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UsuariosTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get login => $state.composableBuilder(
      column: $state.table.login,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get senha => $state.composableBuilder(
      column: $state.table.senha,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ContaDespesasTableTableManager get contaDespesas =>
      $$ContaDespesasTableTableManager(_db, _db.contaDespesas);
  $$LancamentoDespesasTableTableManager get lancamentoDespesas =>
      $$LancamentoDespesasTableTableManager(_db, _db.lancamentoDespesas);
  $$ResumosTableTableManager get resumos =>
      $$ResumosTableTableManager(_db, _db.resumos);
  $$ExtratoBancariosTableTableManager get extratoBancarios =>
      $$ExtratoBancariosTableTableManager(_db, _db.extratoBancarios);
  $$MetodoPagamentosTableTableManager get metodoPagamentos =>
      $$MetodoPagamentosTableTableManager(_db, _db.metodoPagamentos);
  $$ContaReceitasTableTableManager get contaReceitas =>
      $$ContaReceitasTableTableManager(_db, _db.contaReceitas);
  $$LancamentoReceitasTableTableManager get lancamentoReceitas =>
      $$LancamentoReceitasTableTableManager(_db, _db.lancamentoReceitas);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
}

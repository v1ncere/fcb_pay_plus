/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, override_on_non_overriding_member, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Transaction type in your schema. */
class Transaction extends amplify_core.Model {
  static const classType = const _TransactionModelType();
  final amplify_core.TemporalDate? _transDate;
  final String? _referenceId;
  final String? _transCode;
  final double? _transAmount;
  final String? _amountType;
  final double? _balanceActual;
  final double? _balanceCleared;
  final String? _ledgerStatus;
  final Account? _account;
  final List<TransactionTransactionDetail>? _transactionDetails;
  final amplify_core.TemporalDateTime? _updatedAt;
  final amplify_core.TemporalDateTime? _createdAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  TransactionModelIdentifier get modelIdentifier {
    try {
      return TransactionModelIdentifier(
        transDate: _transDate!,
        referenceId: _referenceId!,
        transCode: _transCode!,
        accountNumber: _accountNumber!
      );
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDate get transDate {
    try {
      return _transDate!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get referenceId {
    try {
      return _referenceId!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get transCode {
    try {
      return _transCode!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get transAmount {
    return _transAmount;
  }
  
  String? get amountType {
    return _amountType;
  }
  
  double? get balanceActual {
    return _balanceActual;
  }
  
  double? get balanceCleared {
    return _balanceCleared;
  }
  
  String? get ledgerStatus {
    return _ledgerStatus;
  }
  
  Account? get account {
    return _account;
  }
  
  List<TransactionTransactionDetail>? get transactionDetails {
    return _transactionDetails;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  const Transaction._internal({required transDate, required referenceId, required transCode, transAmount, amountType, balanceActual, balanceCleared, ledgerStatus, account, transactionDetails, updatedAt, createdAt}): _transDate = transDate, _referenceId = referenceId, _transCode = transCode, _transAmount = transAmount, _amountType = amountType, _balanceActual = balanceActual, _balanceCleared = balanceCleared, _ledgerStatus = ledgerStatus, _account = account, _transactionDetails = transactionDetails, _updatedAt = updatedAt, _createdAt = createdAt;
  
  factory Transaction({required amplify_core.TemporalDate transDate, required String referenceId, required String transCode, double? transAmount, String? amountType, double? balanceActual, double? balanceCleared, String? ledgerStatus, Account? account, List<TransactionTransactionDetail>? transactionDetails, amplify_core.TemporalDateTime? updatedAt}) {
    return Transaction._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      transAmount: transAmount,
      amountType: amountType,
      balanceActual: balanceActual,
      balanceCleared: balanceCleared,
      ledgerStatus: ledgerStatus,
      account: account,
      transactionDetails: transactionDetails != null ? List<TransactionTransactionDetail>.unmodifiable(transactionDetails) : transactionDetails,
      updatedAt: updatedAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transaction &&
      _transDate == other._transDate &&
      _referenceId == other._referenceId &&
      _transCode == other._transCode &&
      _transAmount == other._transAmount &&
      _amountType == other._amountType &&
      _balanceActual == other._balanceActual &&
      _balanceCleared == other._balanceCleared &&
      _ledgerStatus == other._ledgerStatus &&
      _account == other._account &&
      DeepCollectionEquality().equals(_transactionDetails, other._transactionDetails) &&
      _updatedAt == other._updatedAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transaction {");
    buffer.write("transDate=" + (_transDate != null ? _transDate!.format() : "null") + ", ");
    buffer.write("referenceId=" + "$_referenceId" + ", ");
    buffer.write("transCode=" + "$_transCode" + ", ");
    buffer.write("transAmount=" + (_transAmount != null ? _transAmount!.toString() : "null") + ", ");
    buffer.write("amountType=" + "$_amountType" + ", ");
    buffer.write("balanceActual=" + (_balanceActual != null ? _balanceActual!.toString() : "null") + ", ");
    buffer.write("balanceCleared=" + (_balanceCleared != null ? _balanceCleared!.toString() : "null") + ", ");
    buffer.write("ledgerStatus=" + "$_ledgerStatus" + ", ");
    buffer.write("account=" + (_account != null ? _account!.toString() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transaction copyWith({double? transAmount, String? amountType, double? balanceActual, double? balanceCleared, String? ledgerStatus, Account? account, List<TransactionTransactionDetail>? transactionDetails, amplify_core.TemporalDateTime? updatedAt}) {
    return Transaction._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      transAmount: transAmount ?? this.transAmount,
      amountType: amountType ?? this.amountType,
      balanceActual: balanceActual ?? this.balanceActual,
      balanceCleared: balanceCleared ?? this.balanceCleared,
      ledgerStatus: ledgerStatus ?? this.ledgerStatus,
      account: account ?? this.account,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      updatedAt: updatedAt ?? this.updatedAt);
  }
  
  Transaction copyWithModelFieldValues({
    ModelFieldValue<double?>? transAmount,
    ModelFieldValue<String?>? amountType,
    ModelFieldValue<double?>? balanceActual,
    ModelFieldValue<double?>? balanceCleared,
    ModelFieldValue<String?>? ledgerStatus,
    ModelFieldValue<Account?>? account,
    ModelFieldValue<List<TransactionTransactionDetail>?>? transactionDetails,
    ModelFieldValue<amplify_core.TemporalDateTime?>? updatedAt
  }) {
    return Transaction._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      transAmount: transAmount == null ? this.transAmount : transAmount.value,
      amountType: amountType == null ? this.amountType : amountType.value,
      balanceActual: balanceActual == null ? this.balanceActual : balanceActual.value,
      balanceCleared: balanceCleared == null ? this.balanceCleared : balanceCleared.value,
      ledgerStatus: ledgerStatus == null ? this.ledgerStatus : ledgerStatus.value,
      account: account == null ? this.account : account.value,
      transactionDetails: transactionDetails == null ? this.transactionDetails : transactionDetails.value,
      updatedAt: updatedAt == null ? this.updatedAt : updatedAt.value
    );
  }
  
  Transaction.fromJson(Map<String, dynamic> json)  
    : _transDate = json['transDate'] != null ? amplify_core.TemporalDate.fromString(json['transDate']) : null,
      _referenceId = json['referenceId'],
      _transCode = json['transCode'],
      _transAmount = (json['transAmount'] as num?)?.toDouble(),
      _amountType = json['amountType'],
      _balanceActual = (json['balanceActual'] as num?)?.toDouble(),
      _balanceCleared = (json['balanceCleared'] as num?)?.toDouble(),
      _ledgerStatus = json['ledgerStatus'],
      _account = json['account'] != null
        ? json['account']['serializedData'] != null
          ? Account.fromJson(new Map<String, dynamic>.from(json['account']['serializedData']))
          : Account.fromJson(new Map<String, dynamic>.from(json['account']))
        : null,
      _transactionDetails = json['transactionDetails']  is Map
        ? (json['transactionDetails']['items'] is List
          ? (json['transactionDetails']['items'] as List)
              .where((e) => e != null)
              .map((e) => TransactionTransactionDetail.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['transactionDetails'] is List
          ? (json['transactionDetails'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => TransactionTransactionDetail.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'transDate': _transDate?.format(), 'referenceId': _referenceId, 'transCode': _transCode, 'transAmount': _transAmount, 'amountType': _amountType, 'balanceActual': _balanceActual, 'balanceCleared': _balanceCleared, 'ledgerStatus': _ledgerStatus, 'account': _account?.toJson(), 'transactionDetails': _transactionDetails?.map((TransactionTransactionDetail? e) => e?.toJson()).toList(), 'updatedAt': _updatedAt?.format(), 'createdAt': _createdAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'transDate': _transDate,
    'referenceId': _referenceId,
    'transCode': _transCode,
    'transAmount': _transAmount,
    'amountType': _amountType,
    'balanceActual': _balanceActual,
    'balanceCleared': _balanceCleared,
    'ledgerStatus': _ledgerStatus,
    'account': _account,
    'transactionDetails': _transactionDetails,
    'updatedAt': _updatedAt,
    'createdAt': _createdAt
  };

  static final amplify_core.QueryModelIdentifier<TransactionModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TransactionModelIdentifier>();
  static final TRANSDATE = amplify_core.QueryField(fieldName: "transDate");
  static final REFERENCEID = amplify_core.QueryField(fieldName: "referenceId");
  static final TRANSCODE = amplify_core.QueryField(fieldName: "transCode");
  static final TRANSAMOUNT = amplify_core.QueryField(fieldName: "transAmount");
  static final AMOUNTTYPE = amplify_core.QueryField(fieldName: "amountType");
  static final BALANCEACTUAL = amplify_core.QueryField(fieldName: "balanceActual");
  static final BALANCECLEARED = amplify_core.QueryField(fieldName: "balanceCleared");
  static final LEDGERSTATUS = amplify_core.QueryField(fieldName: "ledgerStatus");
  static final ACCOUNT = amplify_core.QueryField(
    fieldName: "account",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Account'));
  static final TRANSACTIONDETAILS = amplify_core.QueryField(
    fieldName: "transactionDetails",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TransactionTransactionDetail'));
  static final UPDATEDAT = amplify_core.QueryField(fieldName: "updatedAt");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transaction";
    modelSchemaDefinition.pluralName = "Transactions";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ]),
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: amplify_core.AuthRuleProvider.USERPOOLS,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["transDate", "referenceId", "transCode", "accountNumber"], name: null),
      amplify_core.ModelIndex(fields: const ["accountNumber", "updatedAt"], name: "transactionsByAccountNumberAndUpdatedAt")
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.TRANSDATE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.REFERENCEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.TRANSCODE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.TRANSAMOUNT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.AMOUNTTYPE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.BALANCEACTUAL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.BALANCECLEARED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.LEDGERSTATUS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Transaction.ACCOUNT,
      isRequired: false,
      targetNames: ['accountNumber'],
      ofModelName: 'Account'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Transaction.TRANSACTIONDETAILS,
      isRequired: false,
      ofModelName: 'TransactionTransactionDetail',
      associatedKey: TransactionTransactionDetail.TRANSACTION
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Transaction.UPDATEDAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TransactionModelType extends amplify_core.ModelType<Transaction> {
  const _TransactionModelType();
  
  @override
  Transaction fromJson(Map<String, dynamic> jsonData) {
    return Transaction.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Transaction';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Transaction] in your schema.
 */
class TransactionModelIdentifier implements amplify_core.ModelIdentifier<Transaction> {
  final amplify_core.TemporalDate transDate;
  final String referenceId;
  final String transCode;
  final String accountNumber;

  /**
   * Create an instance of TransactionModelIdentifier using [transDate] the primary key.
   * And [referenceId], [transCode], [accountNumber] the sort keys.
   */
  const TransactionModelIdentifier({
    required this.transDate,
    required this.referenceId,
    required this.transCode,
    required this.accountNumber});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'transDate': transDate,
    'referenceId': referenceId,
    'transCode': transCode,
    'accountNumber': accountNumber
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TransactionModelIdentifier(transDate: $transDate, referenceId: $referenceId, transCode: $transCode, accountNumber: $accountNumber)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransactionModelIdentifier &&
      transDate == other.transDate &&
      referenceId == other.referenceId &&
      transCode == other.transCode &&
      accountNumber == other.accountNumber;
  }
  
  @override
  int get hashCode =>
    transDate.hashCode ^
    referenceId.hashCode ^
    transCode.hashCode ^
    accountNumber.hashCode;
}
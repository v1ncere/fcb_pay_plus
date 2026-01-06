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


/** This is an auto generated class representing the TransactionDetail type in your schema. */
class TransactionDetail extends amplify_core.Model {
  static const classType = const _TransactionDetailModelType();
  final amplify_core.TemporalDate? _transDate;
  final String? _referenceId;
  final String? _transCode;
  final String? _sourceAccount;
  final String? _destinationAccount;
  final String? _otherInformation;
  final String? _deviceInfo;
  final List<TransactionTransactionDetail>? _transactions;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  TransactionDetailModelIdentifier get modelIdentifier {
    try {
      return TransactionDetailModelIdentifier(
        transDate: _transDate!,
        referenceId: _referenceId!,
        transCode: _transCode!
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
  
  String? get sourceAccount {
    return _sourceAccount;
  }
  
  String? get destinationAccount {
    return _destinationAccount;
  }
  
  String? get otherInformation {
    return _otherInformation;
  }
  
  String? get deviceInfo {
    return _deviceInfo;
  }
  
  List<TransactionTransactionDetail>? get transactions {
    return _transactions;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TransactionDetail._internal({required transDate, required referenceId, required transCode, sourceAccount, destinationAccount, otherInformation, deviceInfo, transactions, createdAt, updatedAt}): _transDate = transDate, _referenceId = referenceId, _transCode = transCode, _sourceAccount = sourceAccount, _destinationAccount = destinationAccount, _otherInformation = otherInformation, _deviceInfo = deviceInfo, _transactions = transactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TransactionDetail({required amplify_core.TemporalDate transDate, required String referenceId, required String transCode, String? sourceAccount, String? destinationAccount, String? otherInformation, String? deviceInfo, List<TransactionTransactionDetail>? transactions}) {
    return TransactionDetail._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      sourceAccount: sourceAccount,
      destinationAccount: destinationAccount,
      otherInformation: otherInformation,
      deviceInfo: deviceInfo,
      transactions: transactions != null ? List<TransactionTransactionDetail>.unmodifiable(transactions) : transactions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionDetail &&
      _transDate == other._transDate &&
      _referenceId == other._referenceId &&
      _transCode == other._transCode &&
      _sourceAccount == other._sourceAccount &&
      _destinationAccount == other._destinationAccount &&
      _otherInformation == other._otherInformation &&
      _deviceInfo == other._deviceInfo &&
      DeepCollectionEquality().equals(_transactions, other._transactions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TransactionDetail {");
    buffer.write("transDate=" + (_transDate != null ? _transDate!.format() : "null") + ", ");
    buffer.write("referenceId=" + "$_referenceId" + ", ");
    buffer.write("transCode=" + "$_transCode" + ", ");
    buffer.write("sourceAccount=" + "$_sourceAccount" + ", ");
    buffer.write("destinationAccount=" + "$_destinationAccount" + ", ");
    buffer.write("otherInformation=" + "$_otherInformation" + ", ");
    buffer.write("deviceInfo=" + "$_deviceInfo" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TransactionDetail copyWith({String? sourceAccount, String? destinationAccount, String? otherInformation, String? deviceInfo, List<TransactionTransactionDetail>? transactions}) {
    return TransactionDetail._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      sourceAccount: sourceAccount ?? this.sourceAccount,
      destinationAccount: destinationAccount ?? this.destinationAccount,
      otherInformation: otherInformation ?? this.otherInformation,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      transactions: transactions ?? this.transactions);
  }
  
  TransactionDetail copyWithModelFieldValues({
    ModelFieldValue<String?>? sourceAccount,
    ModelFieldValue<String?>? destinationAccount,
    ModelFieldValue<String?>? otherInformation,
    ModelFieldValue<String?>? deviceInfo,
    ModelFieldValue<List<TransactionTransactionDetail>?>? transactions
  }) {
    return TransactionDetail._internal(
      transDate: transDate,
      referenceId: referenceId,
      transCode: transCode,
      sourceAccount: sourceAccount == null ? this.sourceAccount : sourceAccount.value,
      destinationAccount: destinationAccount == null ? this.destinationAccount : destinationAccount.value,
      otherInformation: otherInformation == null ? this.otherInformation : otherInformation.value,
      deviceInfo: deviceInfo == null ? this.deviceInfo : deviceInfo.value,
      transactions: transactions == null ? this.transactions : transactions.value
    );
  }
  
  TransactionDetail.fromJson(Map<String, dynamic> json)  
    : _transDate = json['transDate'] != null ? amplify_core.TemporalDate.fromString(json['transDate']) : null,
      _referenceId = json['referenceId'],
      _transCode = json['transCode'],
      _sourceAccount = json['sourceAccount'],
      _destinationAccount = json['destinationAccount'],
      _otherInformation = json['otherInformation'],
      _deviceInfo = json['deviceInfo'],
      _transactions = json['transactions']  is Map
        ? (json['transactions']['items'] is List
          ? (json['transactions']['items'] as List)
              .where((e) => e != null)
              .map((e) => TransactionTransactionDetail.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['transactions'] is List
          ? (json['transactions'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => TransactionTransactionDetail.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'transDate': _transDate?.format(), 'referenceId': _referenceId, 'transCode': _transCode, 'sourceAccount': _sourceAccount, 'destinationAccount': _destinationAccount, 'otherInformation': _otherInformation, 'deviceInfo': _deviceInfo, 'transactions': _transactions?.map((TransactionTransactionDetail? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'transDate': _transDate,
    'referenceId': _referenceId,
    'transCode': _transCode,
    'sourceAccount': _sourceAccount,
    'destinationAccount': _destinationAccount,
    'otherInformation': _otherInformation,
    'deviceInfo': _deviceInfo,
    'transactions': _transactions,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TransactionDetailModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TransactionDetailModelIdentifier>();
  static final TRANSDATE = amplify_core.QueryField(fieldName: "transDate");
  static final REFERENCEID = amplify_core.QueryField(fieldName: "referenceId");
  static final TRANSCODE = amplify_core.QueryField(fieldName: "transCode");
  static final SOURCEACCOUNT = amplify_core.QueryField(fieldName: "sourceAccount");
  static final DESTINATIONACCOUNT = amplify_core.QueryField(fieldName: "destinationAccount");
  static final OTHERINFORMATION = amplify_core.QueryField(fieldName: "otherInformation");
  static final DEVICEINFO = amplify_core.QueryField(fieldName: "deviceInfo");
  static final TRANSACTIONS = amplify_core.QueryField(
    fieldName: "transactions",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TransactionTransactionDetail'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TransactionDetail";
    modelSchemaDefinition.pluralName = "TransactionDetails";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        provider: amplify_core.AuthRuleProvider.IAM,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["transDate", "referenceId", "transCode"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.TRANSDATE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.REFERENCEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.TRANSCODE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.SOURCEACCOUNT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.DESTINATIONACCOUNT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.OTHERINFORMATION,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransactionDetail.DEVICEINFO,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: TransactionDetail.TRANSACTIONS,
      isRequired: false,
      ofModelName: 'TransactionTransactionDetail',
      associatedKey: TransactionTransactionDetail.TRANSACTIONDETAIL
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TransactionDetailModelType extends amplify_core.ModelType<TransactionDetail> {
  const _TransactionDetailModelType();
  
  @override
  TransactionDetail fromJson(Map<String, dynamic> jsonData) {
    return TransactionDetail.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TransactionDetail';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TransactionDetail] in your schema.
 */
class TransactionDetailModelIdentifier implements amplify_core.ModelIdentifier<TransactionDetail> {
  final amplify_core.TemporalDate transDate;
  final String referenceId;
  final String transCode;

  /**
   * Create an instance of TransactionDetailModelIdentifier using [transDate] the primary key.
   * And [referenceId], [transCode] the sort keys.
   */
  const TransactionDetailModelIdentifier({
    required this.transDate,
    required this.referenceId,
    required this.transCode});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'transDate': transDate,
    'referenceId': referenceId,
    'transCode': transCode
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TransactionDetailModelIdentifier(transDate: $transDate, referenceId: $referenceId, transCode: $transCode)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransactionDetailModelIdentifier &&
      transDate == other.transDate &&
      referenceId == other.referenceId &&
      transCode == other.transCode;
  }
  
  @override
  int get hashCode =>
    transDate.hashCode ^
    referenceId.hashCode ^
    transCode.hashCode;
}
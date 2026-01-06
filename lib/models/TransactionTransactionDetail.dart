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


/** This is an auto generated class representing the TransactionTransactionDetail type in your schema. */
class TransactionTransactionDetail extends amplify_core.Model {
  static const classType = const _TransactionTransactionDetailModelType();
  final String id;
  final Transaction? _transaction;
  final TransactionDetail? _transactionDetail;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TransactionTransactionDetailModelIdentifier get modelIdentifier {
      return TransactionTransactionDetailModelIdentifier(
        id: id
      );
  }
  
  Transaction? get transaction {
    return _transaction;
  }
  
  TransactionDetail? get transactionDetail {
    return _transactionDetail;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TransactionTransactionDetail._internal({required this.id, transaction, transactionDetail, createdAt, updatedAt}): _transaction = transaction, _transactionDetail = transactionDetail, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TransactionTransactionDetail({String? id, Transaction? transaction, TransactionDetail? transactionDetail}) {
    return TransactionTransactionDetail._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      transaction: transaction,
      transactionDetail: transactionDetail);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionTransactionDetail &&
      id == other.id &&
      _transaction == other._transaction &&
      _transactionDetail == other._transactionDetail;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TransactionTransactionDetail {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("transaction=" + (_transaction != null ? _transaction!.toString() : "null") + ", ");
    buffer.write("transactionDetail=" + (_transactionDetail != null ? _transactionDetail!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TransactionTransactionDetail copyWith({Transaction? transaction, TransactionDetail? transactionDetail}) {
    return TransactionTransactionDetail._internal(
      id: id,
      transaction: transaction ?? this.transaction,
      transactionDetail: transactionDetail ?? this.transactionDetail);
  }
  
  TransactionTransactionDetail copyWithModelFieldValues({
    ModelFieldValue<Transaction?>? transaction,
    ModelFieldValue<TransactionDetail?>? transactionDetail
  }) {
    return TransactionTransactionDetail._internal(
      id: id,
      transaction: transaction == null ? this.transaction : transaction.value,
      transactionDetail: transactionDetail == null ? this.transactionDetail : transactionDetail.value
    );
  }
  
  TransactionTransactionDetail.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _transaction = json['transaction'] != null
        ? json['transaction']['serializedData'] != null
          ? Transaction.fromJson(new Map<String, dynamic>.from(json['transaction']['serializedData']))
          : Transaction.fromJson(new Map<String, dynamic>.from(json['transaction']))
        : null,
      _transactionDetail = json['transactionDetail'] != null
        ? json['transactionDetail']['serializedData'] != null
          ? TransactionDetail.fromJson(new Map<String, dynamic>.from(json['transactionDetail']['serializedData']))
          : TransactionDetail.fromJson(new Map<String, dynamic>.from(json['transactionDetail']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'transaction': _transaction?.toJson(), 'transactionDetail': _transactionDetail?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'transaction': _transaction,
    'transactionDetail': _transactionDetail,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TransactionTransactionDetailModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TransactionTransactionDetailModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TRANSACTION = amplify_core.QueryField(
    fieldName: "transaction",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Transaction'));
  static final TRANSACTIONDETAIL = amplify_core.QueryField(
    fieldName: "transactionDetail",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'TransactionDetail'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TransactionTransactionDetail";
    modelSchemaDefinition.pluralName = "TransactionTransactionDetails";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: TransactionTransactionDetail.TRANSACTION,
      isRequired: false,
      targetNames: ['transDate', 'referenceId', 'transCode', 'accountNumber'],
      ofModelName: 'Transaction'
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: TransactionTransactionDetail.TRANSACTIONDETAIL,
      isRequired: false,
      targetNames: ['transDate', 'referenceId', 'transCode'],
      ofModelName: 'TransactionDetail'
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

class _TransactionTransactionDetailModelType extends amplify_core.ModelType<TransactionTransactionDetail> {
  const _TransactionTransactionDetailModelType();
  
  @override
  TransactionTransactionDetail fromJson(Map<String, dynamic> jsonData) {
    return TransactionTransactionDetail.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TransactionTransactionDetail';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TransactionTransactionDetail] in your schema.
 */
class TransactionTransactionDetailModelIdentifier implements amplify_core.ModelIdentifier<TransactionTransactionDetail> {
  final String id;

  /** Create an instance of TransactionTransactionDetailModelIdentifier using [id] the primary key. */
  const TransactionTransactionDetailModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'TransactionTransactionDetailModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransactionTransactionDetailModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
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


/** This is an auto generated class representing the Receipt type in your schema. */
class Receipt extends amplify_core.Model {
  static const classType = const _ReceiptModelType();
  final String id;
  final String? _data;
  final String? _owner;
  final Transaction? _transaction;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  ReceiptModelIdentifier get modelIdentifier {
      return ReceiptModelIdentifier(
        id: id
      );
  }
  
  String? get data {
    return _data;
  }
  
  String? get owner {
    return _owner;
  }
  
  Transaction? get transaction {
    return _transaction;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Receipt._internal({required this.id, data, owner, transaction, createdAt, updatedAt}): _data = data, _owner = owner, _transaction = transaction, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Receipt({String? id, String? data, String? owner, Transaction? transaction}) {
    return Receipt._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      data: data,
      owner: owner,
      transaction: transaction);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Receipt &&
      id == other.id &&
      _data == other._data &&
      _owner == other._owner &&
      _transaction == other._transaction;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Receipt {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("data=" + "$_data" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("transaction=" + (_transaction != null ? _transaction!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Receipt copyWith({String? data, String? owner, Transaction? transaction}) {
    return Receipt._internal(
      id: id,
      data: data ?? this.data,
      owner: owner ?? this.owner,
      transaction: transaction ?? this.transaction);
  }
  
  Receipt copyWithModelFieldValues({
    ModelFieldValue<String?>? data,
    ModelFieldValue<String?>? owner,
    ModelFieldValue<Transaction?>? transaction
  }) {
    return Receipt._internal(
      id: id,
      data: data == null ? this.data : data.value,
      owner: owner == null ? this.owner : owner.value,
      transaction: transaction == null ? this.transaction : transaction.value
    );
  }
  
  Receipt.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _data = json['data'],
      _owner = json['owner'],
      _transaction = json['transaction'] != null
        ? json['transaction']['serializedData'] != null
          ? Transaction.fromJson(new Map<String, dynamic>.from(json['transaction']['serializedData']))
          : Transaction.fromJson(new Map<String, dynamic>.from(json['transaction']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'data': _data, 'owner': _owner, 'transaction': _transaction?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'data': _data,
    'owner': _owner,
    'transaction': _transaction,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<ReceiptModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<ReceiptModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DATA = amplify_core.QueryField(fieldName: "data");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final TRANSACTION = amplify_core.QueryField(
    fieldName: "transaction",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Transaction'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Receipt";
    modelSchemaDefinition.pluralName = "Receipts";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Receipt.DATA,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Receipt.OWNER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: Receipt.TRANSACTION,
      isRequired: false,
      targetNames: ['transactionId'],
      ofModelName: 'Transaction'
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

class _ReceiptModelType extends amplify_core.ModelType<Receipt> {
  const _ReceiptModelType();
  
  @override
  Receipt fromJson(Map<String, dynamic> jsonData) {
    return Receipt.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Receipt';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Receipt] in your schema.
 */
class ReceiptModelIdentifier implements amplify_core.ModelIdentifier<Receipt> {
  final String id;

  /** Create an instance of ReceiptModelIdentifier using [id] the primary key. */
  const ReceiptModelIdentifier({
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
  String toString() => 'ReceiptModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is ReceiptModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
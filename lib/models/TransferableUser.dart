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


/** This is an auto generated class representing the TransferableUser type in your schema. */
class TransferableUser extends amplify_core.Model {
  static const classType = const _TransferableUserModelType();
  final String id;
  final String? _name;
  final bool? _isTransferable;
  final String? _owner;
  final Account? _account;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  TransferableUserModelIdentifier get modelIdentifier {
      return TransferableUserModelIdentifier(
        id: id
      );
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get isTransferable {
    try {
      return _isTransferable!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get owner {
    try {
      return _owner!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Account? get account {
    return _account;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const TransferableUser._internal({required this.id, required name, required isTransferable, required owner, account, createdAt, updatedAt}): _name = name, _isTransferable = isTransferable, _owner = owner, _account = account, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory TransferableUser({String? id, required String name, required bool isTransferable, required String owner, Account? account}) {
    return TransferableUser._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      isTransferable: isTransferable,
      owner: owner,
      account: account);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransferableUser &&
      id == other.id &&
      _name == other._name &&
      _isTransferable == other._isTransferable &&
      _owner == other._owner &&
      _account == other._account;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("TransferableUser {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("isTransferable=" + (_isTransferable != null ? _isTransferable!.toString() : "null") + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("account=" + (_account != null ? _account!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  TransferableUser copyWith({String? name, bool? isTransferable, String? owner, Account? account}) {
    return TransferableUser._internal(
      id: id,
      name: name ?? this.name,
      isTransferable: isTransferable ?? this.isTransferable,
      owner: owner ?? this.owner,
      account: account ?? this.account);
  }
  
  TransferableUser copyWithModelFieldValues({
    ModelFieldValue<String>? name,
    ModelFieldValue<bool>? isTransferable,
    ModelFieldValue<String>? owner,
    ModelFieldValue<Account?>? account
  }) {
    return TransferableUser._internal(
      id: id,
      name: name == null ? this.name : name.value,
      isTransferable: isTransferable == null ? this.isTransferable : isTransferable.value,
      owner: owner == null ? this.owner : owner.value,
      account: account == null ? this.account : account.value
    );
  }
  
  TransferableUser.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _isTransferable = json['isTransferable'],
      _owner = json['owner'],
      _account = json['account'] != null
        ? json['account']['serializedData'] != null
          ? Account.fromJson(new Map<String, dynamic>.from(json['account']['serializedData']))
          : Account.fromJson(new Map<String, dynamic>.from(json['account']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'isTransferable': _isTransferable, 'owner': _owner, 'account': _account?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'isTransferable': _isTransferable,
    'owner': _owner,
    'account': _account,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<TransferableUserModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<TransferableUserModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final ISTRANSFERABLE = amplify_core.QueryField(fieldName: "isTransferable");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final ACCOUNT = amplify_core.QueryField(
    fieldName: "account",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Account'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "TransferableUser";
    modelSchemaDefinition.pluralName = "TransferableUsers";
    
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
      key: TransferableUser.NAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransferableUser.ISTRANSFERABLE,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: TransferableUser.OWNER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.belongsTo(
      key: TransferableUser.ACCOUNT,
      isRequired: false,
      targetNames: ['accountId'],
      ofModelName: 'Account'
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

class _TransferableUserModelType extends amplify_core.ModelType<TransferableUser> {
  const _TransferableUserModelType();
  
  @override
  TransferableUser fromJson(Map<String, dynamic> jsonData) {
    return TransferableUser.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'TransferableUser';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [TransferableUser] in your schema.
 */
class TransferableUserModelIdentifier implements amplify_core.ModelIdentifier<TransferableUser> {
  final String id;

  /** Create an instance of TransferableUserModelIdentifier using [id] the primary key. */
  const TransferableUserModelIdentifier({
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
  String toString() => 'TransferableUserModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is TransferableUserModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
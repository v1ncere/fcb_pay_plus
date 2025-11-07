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


/** This is an auto generated class representing the DeviceId type in your schema. */
class DeviceId extends amplify_core.Model {
  static const classType = const _DeviceIdModelType();
  final String id;
  final String? _deviceId;
  final String? _owner;
  final String? _deviceModel;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  DeviceIdModelIdentifier get modelIdentifier {
      return DeviceIdModelIdentifier(
        id: id
      );
  }
  
  String get deviceId {
    try {
      return _deviceId!;
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
  
  String get deviceModel {
    try {
      return _deviceModel!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const DeviceId._internal({required this.id, required deviceId, required owner, required deviceModel, createdAt, updatedAt}): _deviceId = deviceId, _owner = owner, _deviceModel = deviceModel, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory DeviceId({String? id, required String deviceId, required String owner, required String deviceModel}) {
    return DeviceId._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      deviceId: deviceId,
      owner: owner,
      deviceModel: deviceModel);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceId &&
      id == other.id &&
      _deviceId == other._deviceId &&
      _owner == other._owner &&
      _deviceModel == other._deviceModel;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("DeviceId {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("deviceId=" + "$_deviceId" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("deviceModel=" + "$_deviceModel" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  DeviceId copyWith({String? deviceId, String? owner, String? deviceModel}) {
    return DeviceId._internal(
      id: id,
      deviceId: deviceId ?? this.deviceId,
      owner: owner ?? this.owner,
      deviceModel: deviceModel ?? this.deviceModel);
  }
  
  DeviceId copyWithModelFieldValues({
    ModelFieldValue<String>? deviceId,
    ModelFieldValue<String>? owner,
    ModelFieldValue<String>? deviceModel
  }) {
    return DeviceId._internal(
      id: id,
      deviceId: deviceId == null ? this.deviceId : deviceId.value,
      owner: owner == null ? this.owner : owner.value,
      deviceModel: deviceModel == null ? this.deviceModel : deviceModel.value
    );
  }
  
  DeviceId.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _deviceId = json['deviceId'],
      _owner = json['owner'],
      _deviceModel = json['deviceModel'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'deviceId': _deviceId, 'owner': _owner, 'deviceModel': _deviceModel, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'deviceId': _deviceId,
    'owner': _owner,
    'deviceModel': _deviceModel,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<DeviceIdModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<DeviceIdModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final DEVICEID = amplify_core.QueryField(fieldName: "deviceId");
  static final OWNER = amplify_core.QueryField(fieldName: "owner");
  static final DEVICEMODEL = amplify_core.QueryField(fieldName: "deviceModel");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DeviceId";
    modelSchemaDefinition.pluralName = "DeviceIds";
    
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
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DeviceId.DEVICEID,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DeviceId.OWNER,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DeviceId.DEVICEMODEL,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
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

class _DeviceIdModelType extends amplify_core.ModelType<DeviceId> {
  const _DeviceIdModelType();
  
  @override
  DeviceId fromJson(Map<String, dynamic> jsonData) {
    return DeviceId.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'DeviceId';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [DeviceId] in your schema.
 */
class DeviceIdModelIdentifier implements amplify_core.ModelIdentifier<DeviceId> {
  final String id;

  /** Create an instance of DeviceIdModelIdentifier using [id] the primary key. */
  const DeviceIdModelIdentifier({
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
  String toString() => 'DeviceIdModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is DeviceIdModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
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


/** This is an auto generated class representing the OtpSmsEmail type in your schema. */
class OtpSmsEmail extends amplify_core.Model {
  static const classType = const _OtpSmsEmailModelType();
  final String id;
  final String? _target;
  final String? _otp;
  final String? _channel;
  final String? _expiresAt;
  final bool? _verified;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  OtpSmsEmailModelIdentifier get modelIdentifier {
      return OtpSmsEmailModelIdentifier(
        id: id
      );
  }
  
  String get target {
    try {
      return _target!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get otp {
    return _otp;
  }
  
  String? get channel {
    return _channel;
  }
  
  String? get expiresAt {
    return _expiresAt;
  }
  
  bool? get verified {
    return _verified;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const OtpSmsEmail._internal({required this.id, required target, otp, channel, expiresAt, verified, createdAt, updatedAt}): _target = target, _otp = otp, _channel = channel, _expiresAt = expiresAt, _verified = verified, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory OtpSmsEmail({String? id, required String target, String? otp, String? channel, String? expiresAt, bool? verified}) {
    return OtpSmsEmail._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      target: target,
      otp: otp,
      channel: channel,
      expiresAt: expiresAt,
      verified: verified);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpSmsEmail &&
      id == other.id &&
      _target == other._target &&
      _otp == other._otp &&
      _channel == other._channel &&
      _expiresAt == other._expiresAt &&
      _verified == other._verified;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("OtpSmsEmail {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("target=" + "$_target" + ", ");
    buffer.write("otp=" + "$_otp" + ", ");
    buffer.write("channel=" + "$_channel" + ", ");
    buffer.write("expiresAt=" + "$_expiresAt" + ", ");
    buffer.write("verified=" + (_verified != null ? _verified!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  OtpSmsEmail copyWith({String? target, String? otp, String? channel, String? expiresAt, bool? verified}) {
    return OtpSmsEmail._internal(
      id: id,
      target: target ?? this.target,
      otp: otp ?? this.otp,
      channel: channel ?? this.channel,
      expiresAt: expiresAt ?? this.expiresAt,
      verified: verified ?? this.verified);
  }
  
  OtpSmsEmail copyWithModelFieldValues({
    ModelFieldValue<String>? target,
    ModelFieldValue<String?>? otp,
    ModelFieldValue<String?>? channel,
    ModelFieldValue<String?>? expiresAt,
    ModelFieldValue<bool?>? verified
  }) {
    return OtpSmsEmail._internal(
      id: id,
      target: target == null ? this.target : target.value,
      otp: otp == null ? this.otp : otp.value,
      channel: channel == null ? this.channel : channel.value,
      expiresAt: expiresAt == null ? this.expiresAt : expiresAt.value,
      verified: verified == null ? this.verified : verified.value
    );
  }
  
  OtpSmsEmail.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _target = json['target'],
      _otp = json['otp'],
      _channel = json['channel'],
      _expiresAt = json['expiresAt'],
      _verified = json['verified'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'target': _target, 'otp': _otp, 'channel': _channel, 'expiresAt': _expiresAt, 'verified': _verified, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'target': _target,
    'otp': _otp,
    'channel': _channel,
    'expiresAt': _expiresAt,
    'verified': _verified,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<OtpSmsEmailModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<OtpSmsEmailModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TARGET = amplify_core.QueryField(fieldName: "target");
  static final OTP = amplify_core.QueryField(fieldName: "otp");
  static final CHANNEL = amplify_core.QueryField(fieldName: "channel");
  static final EXPIRESAT = amplify_core.QueryField(fieldName: "expiresAt");
  static final VERIFIED = amplify_core.QueryField(fieldName: "verified");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "OtpSmsEmail";
    modelSchemaDefinition.pluralName = "OtpSmsEmails";
    
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
      key: OtpSmsEmail.TARGET,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.OTP,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.CHANNEL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.EXPIRESAT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.VERIFIED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
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

class _OtpSmsEmailModelType extends amplify_core.ModelType<OtpSmsEmail> {
  const _OtpSmsEmailModelType();
  
  @override
  OtpSmsEmail fromJson(Map<String, dynamic> jsonData) {
    return OtpSmsEmail.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'OtpSmsEmail';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [OtpSmsEmail] in your schema.
 */
class OtpSmsEmailModelIdentifier implements amplify_core.ModelIdentifier<OtpSmsEmail> {
  final String id;

  /** Create an instance of OtpSmsEmailModelIdentifier using [id] the primary key. */
  const OtpSmsEmailModelIdentifier({
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
  String toString() => 'OtpSmsEmailModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is OtpSmsEmailModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
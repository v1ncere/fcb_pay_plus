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
  final String? _target;
  final String? _otpHash;
  final String? _channel;
  final amplify_core.TemporalDateTime? _expiresAt;
  final bool? _verified;
  final int? _attempts;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => modelIdentifier.serializeAsString();
  
  OtpSmsEmailModelIdentifier get modelIdentifier {
    try {
      return OtpSmsEmailModelIdentifier(
        target: _target!
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
  
  String? get otpHash {
    return _otpHash;
  }
  
  String? get channel {
    return _channel;
  }
  
  amplify_core.TemporalDateTime? get expiresAt {
    return _expiresAt;
  }
  
  bool? get verified {
    return _verified;
  }
  
  int? get attempts {
    return _attempts;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const OtpSmsEmail._internal({required target, otpHash, channel, expiresAt, verified, attempts, createdAt, updatedAt}): _target = target, _otpHash = otpHash, _channel = channel, _expiresAt = expiresAt, _verified = verified, _attempts = attempts, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory OtpSmsEmail({required String target, String? otpHash, String? channel, amplify_core.TemporalDateTime? expiresAt, bool? verified, int? attempts}) {
    return OtpSmsEmail._internal(
      target: target,
      otpHash: otpHash,
      channel: channel,
      expiresAt: expiresAt,
      verified: verified,
      attempts: attempts);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtpSmsEmail &&
      _target == other._target &&
      _otpHash == other._otpHash &&
      _channel == other._channel &&
      _expiresAt == other._expiresAt &&
      _verified == other._verified &&
      _attempts == other._attempts;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("OtpSmsEmail {");
    buffer.write("target=" + "$_target" + ", ");
    buffer.write("otpHash=" + "$_otpHash" + ", ");
    buffer.write("channel=" + "$_channel" + ", ");
    buffer.write("expiresAt=" + (_expiresAt != null ? _expiresAt!.format() : "null") + ", ");
    buffer.write("verified=" + (_verified != null ? _verified!.toString() : "null") + ", ");
    buffer.write("attempts=" + (_attempts != null ? _attempts!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  OtpSmsEmail copyWith({String? otpHash, String? channel, amplify_core.TemporalDateTime? expiresAt, bool? verified, int? attempts}) {
    return OtpSmsEmail._internal(
      target: target,
      otpHash: otpHash ?? this.otpHash,
      channel: channel ?? this.channel,
      expiresAt: expiresAt ?? this.expiresAt,
      verified: verified ?? this.verified,
      attempts: attempts ?? this.attempts);
  }
  
  OtpSmsEmail copyWithModelFieldValues({
    ModelFieldValue<String?>? otpHash,
    ModelFieldValue<String?>? channel,
    ModelFieldValue<amplify_core.TemporalDateTime?>? expiresAt,
    ModelFieldValue<bool?>? verified,
    ModelFieldValue<int?>? attempts
  }) {
    return OtpSmsEmail._internal(
      target: target,
      otpHash: otpHash == null ? this.otpHash : otpHash.value,
      channel: channel == null ? this.channel : channel.value,
      expiresAt: expiresAt == null ? this.expiresAt : expiresAt.value,
      verified: verified == null ? this.verified : verified.value,
      attempts: attempts == null ? this.attempts : attempts.value
    );
  }
  
  OtpSmsEmail.fromJson(Map<String, dynamic> json)  
    : _target = json['target'],
      _otpHash = json['otpHash'],
      _channel = json['channel'],
      _expiresAt = json['expiresAt'] != null ? amplify_core.TemporalDateTime.fromString(json['expiresAt']) : null,
      _verified = json['verified'],
      _attempts = (json['attempts'] as num?)?.toInt(),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'target': _target, 'otpHash': _otpHash, 'channel': _channel, 'expiresAt': _expiresAt?.format(), 'verified': _verified, 'attempts': _attempts, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'target': _target,
    'otpHash': _otpHash,
    'channel': _channel,
    'expiresAt': _expiresAt,
    'verified': _verified,
    'attempts': _attempts,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<OtpSmsEmailModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<OtpSmsEmailModelIdentifier>();
  static final TARGET = amplify_core.QueryField(fieldName: "target");
  static final OTPHASH = amplify_core.QueryField(fieldName: "otpHash");
  static final CHANNEL = amplify_core.QueryField(fieldName: "channel");
  static final EXPIRESAT = amplify_core.QueryField(fieldName: "expiresAt");
  static final VERIFIED = amplify_core.QueryField(fieldName: "verified");
  static final ATTEMPTS = amplify_core.QueryField(fieldName: "attempts");
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
    
    modelSchemaDefinition.indexes = [
      amplify_core.ModelIndex(fields: const ["target"], name: null)
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.TARGET,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.OTPHASH,
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
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.VERIFIED,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: OtpSmsEmail.ATTEMPTS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.int)
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
  final String target;

  /** Create an instance of OtpSmsEmailModelIdentifier using [target] the primary key. */
  const OtpSmsEmailModelIdentifier({
    required this.target});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'target': target
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'OtpSmsEmailModelIdentifier(target: $target)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is OtpSmsEmailModelIdentifier &&
      target == other.target;
  }
  
  @override
  int get hashCode =>
    target.hashCode;
}
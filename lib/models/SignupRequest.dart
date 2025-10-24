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


/** This is an auto generated class representing the SignupRequest type in your schema. */
class SignupRequest extends amplify_core.Model {
  static const classType = const _SignupRequestModelType();
  final String id;
  final String? _accountNumber;
  final String? _accountAlias;
  final String? _email;
  final String? _mobileNumber;
  final String? _details;
  final String? _profileRef;
  final String? _validIdRef;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  SignupRequestModelIdentifier get modelIdentifier {
      return SignupRequestModelIdentifier(
        id: id
      );
  }
  
  String? get accountNumber {
    return _accountNumber;
  }
  
  String? get accountAlias {
    return _accountAlias;
  }
  
  String? get email {
    return _email;
  }
  
  String? get mobileNumber {
    return _mobileNumber;
  }
  
  String? get details {
    return _details;
  }
  
  String? get profileRef {
    return _profileRef;
  }
  
  String? get validIdRef {
    return _validIdRef;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const SignupRequest._internal({required this.id, accountNumber, accountAlias, email, mobileNumber, details, profileRef, validIdRef, createdAt, updatedAt}): _accountNumber = accountNumber, _accountAlias = accountAlias, _email = email, _mobileNumber = mobileNumber, _details = details, _profileRef = profileRef, _validIdRef = validIdRef, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory SignupRequest({String? id, String? accountNumber, String? accountAlias, String? email, String? mobileNumber, String? details, String? profileRef, String? validIdRef}) {
    return SignupRequest._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      accountNumber: accountNumber,
      accountAlias: accountAlias,
      email: email,
      mobileNumber: mobileNumber,
      details: details,
      profileRef: profileRef,
      validIdRef: validIdRef);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignupRequest &&
      id == other.id &&
      _accountNumber == other._accountNumber &&
      _accountAlias == other._accountAlias &&
      _email == other._email &&
      _mobileNumber == other._mobileNumber &&
      _details == other._details &&
      _profileRef == other._profileRef &&
      _validIdRef == other._validIdRef;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("SignupRequest {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("accountNumber=" + "$_accountNumber" + ", ");
    buffer.write("accountAlias=" + "$_accountAlias" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("mobileNumber=" + "$_mobileNumber" + ", ");
    buffer.write("details=" + "$_details" + ", ");
    buffer.write("profileRef=" + "$_profileRef" + ", ");
    buffer.write("validIdRef=" + "$_validIdRef" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  SignupRequest copyWith({String? accountNumber, String? accountAlias, String? email, String? mobileNumber, String? details, String? profileRef, String? validIdRef}) {
    return SignupRequest._internal(
      id: id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountAlias: accountAlias ?? this.accountAlias,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      details: details ?? this.details,
      profileRef: profileRef ?? this.profileRef,
      validIdRef: validIdRef ?? this.validIdRef);
  }
  
  SignupRequest copyWithModelFieldValues({
    ModelFieldValue<String?>? accountNumber,
    ModelFieldValue<String?>? accountAlias,
    ModelFieldValue<String?>? email,
    ModelFieldValue<String?>? mobileNumber,
    ModelFieldValue<String?>? details,
    ModelFieldValue<String?>? profileRef,
    ModelFieldValue<String?>? validIdRef
  }) {
    return SignupRequest._internal(
      id: id,
      accountNumber: accountNumber == null ? this.accountNumber : accountNumber.value,
      accountAlias: accountAlias == null ? this.accountAlias : accountAlias.value,
      email: email == null ? this.email : email.value,
      mobileNumber: mobileNumber == null ? this.mobileNumber : mobileNumber.value,
      details: details == null ? this.details : details.value,
      profileRef: profileRef == null ? this.profileRef : profileRef.value,
      validIdRef: validIdRef == null ? this.validIdRef : validIdRef.value
    );
  }
  
  SignupRequest.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _accountNumber = json['accountNumber'],
      _accountAlias = json['accountAlias'],
      _email = json['email'],
      _mobileNumber = json['mobileNumber'],
      _details = json['details'],
      _profileRef = json['profileRef'],
      _validIdRef = json['validIdRef'],
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'accountNumber': _accountNumber, 'accountAlias': _accountAlias, 'email': _email, 'mobileNumber': _mobileNumber, 'details': _details, 'profileRef': _profileRef, 'validIdRef': _validIdRef, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'accountNumber': _accountNumber,
    'accountAlias': _accountAlias,
    'email': _email,
    'mobileNumber': _mobileNumber,
    'details': _details,
    'profileRef': _profileRef,
    'validIdRef': _validIdRef,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<SignupRequestModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<SignupRequestModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final ACCOUNTNUMBER = amplify_core.QueryField(fieldName: "accountNumber");
  static final ACCOUNTALIAS = amplify_core.QueryField(fieldName: "accountAlias");
  static final EMAIL = amplify_core.QueryField(fieldName: "email");
  static final MOBILENUMBER = amplify_core.QueryField(fieldName: "mobileNumber");
  static final DETAILS = amplify_core.QueryField(fieldName: "details");
  static final PROFILEREF = amplify_core.QueryField(fieldName: "profileRef");
  static final VALIDIDREF = amplify_core.QueryField(fieldName: "validIdRef");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "SignupRequest";
    modelSchemaDefinition.pluralName = "SignupRequests";
    
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
      key: SignupRequest.ACCOUNTNUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.ACCOUNTALIAS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.EMAIL,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.MOBILENUMBER,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.DETAILS,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.PROFILEREF,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: SignupRequest.VALIDIDREF,
      isRequired: false,
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

class _SignupRequestModelType extends amplify_core.ModelType<SignupRequest> {
  const _SignupRequestModelType();
  
  @override
  SignupRequest fromJson(Map<String, dynamic> jsonData) {
    return SignupRequest.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'SignupRequest';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [SignupRequest] in your schema.
 */
class SignupRequestModelIdentifier implements amplify_core.ModelIdentifier<SignupRequest> {
  final String id;

  /** Create an instance of SignupRequestModelIdentifier using [id] the primary key. */
  const SignupRequestModelIdentifier({
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
  String toString() => 'SignupRequestModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is SignupRequestModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
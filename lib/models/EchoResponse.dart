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


/** This is an auto generated class representing the EchoResponse type in your schema. */
class EchoResponse {
  final bool? _isSuccess;
  final String? _data;
  final String? _error;

  bool get isSuccess {
    try {
      return _isSuccess!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get data {
    return _data;
  }
  
  String? get error {
    return _error;
  }
  
  const EchoResponse._internal({required isSuccess, data, error}): _isSuccess = isSuccess, _data = data, _error = error;
  
  factory EchoResponse({required bool isSuccess, String? data, String? error}) {
    return EchoResponse._internal(
      isSuccess: isSuccess,
      data: data,
      error: error);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EchoResponse &&
      _isSuccess == other._isSuccess &&
      _data == other._data &&
      _error == other._error;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("EchoResponse {");
    buffer.write("isSuccess=" + (_isSuccess != null ? _isSuccess!.toString() : "null") + ", ");
    buffer.write("data=" + "$_data" + ", ");
    buffer.write("error=" + "$_error");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  EchoResponse copyWith({bool? isSuccess, String? data, String? error}) {
    return EchoResponse._internal(
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error);
  }
  
  EchoResponse copyWithModelFieldValues({
    ModelFieldValue<bool>? isSuccess,
    ModelFieldValue<String?>? data,
    ModelFieldValue<String?>? error
  }) {
    return EchoResponse._internal(
      isSuccess: isSuccess == null ? this.isSuccess : isSuccess.value,
      data: data == null ? this.data : data.value,
      error: error == null ? this.error : error.value
    );
  }
  
  EchoResponse.fromJson(Map<String, dynamic> json)  
    : _isSuccess = json['isSuccess'],
      _data = json['data'],
      _error = json['error'];
  
  Map<String, dynamic> toJson() => {
    'isSuccess': _isSuccess, 'data': _data, 'error': _error
  };
  
  Map<String, Object?> toMap() => {
    'isSuccess': _isSuccess,
    'data': _data,
    'error': _error
  };

  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "EchoResponse";
    modelSchemaDefinition.pluralName = "EchoResponses";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'isSuccess',
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'data',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.customTypeField(
      fieldName: 'error',
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}
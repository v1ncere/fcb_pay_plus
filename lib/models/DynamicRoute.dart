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


/** This is an auto generated class representing the DynamicRoute type in your schema. */
class DynamicRoute extends amplify_core.Model {
  static const classType = const _DynamicRouteModelType();
  final String id;
  final String? _title;
  final List<Button>? _buttons;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  DynamicRouteModelIdentifier get modelIdentifier {
      return DynamicRouteModelIdentifier(
        id: id
      );
  }
  
  String? get title {
    return _title;
  }
  
  List<Button>? get buttons {
    return _buttons;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const DynamicRoute._internal({required this.id, title, buttons, createdAt, updatedAt}): _title = title, _buttons = buttons, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory DynamicRoute({String? id, String? title, List<Button>? buttons}) {
    return DynamicRoute._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      title: title,
      buttons: buttons != null ? List<Button>.unmodifiable(buttons) : buttons);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DynamicRoute &&
      id == other.id &&
      _title == other._title &&
      DeepCollectionEquality().equals(_buttons, other._buttons);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("DynamicRoute {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("title=" + "$_title" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  DynamicRoute copyWith({String? title, List<Button>? buttons}) {
    return DynamicRoute._internal(
      id: id,
      title: title ?? this.title,
      buttons: buttons ?? this.buttons);
  }
  
  DynamicRoute copyWithModelFieldValues({
    ModelFieldValue<String?>? title,
    ModelFieldValue<List<Button>?>? buttons
  }) {
    return DynamicRoute._internal(
      id: id,
      title: title == null ? this.title : title.value,
      buttons: buttons == null ? this.buttons : buttons.value
    );
  }
  
  DynamicRoute.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _title = json['title'],
      _buttons = json['buttons']  is Map
        ? (json['buttons']['items'] is List
          ? (json['buttons']['items'] as List)
              .where((e) => e != null)
              .map((e) => Button.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['buttons'] is List
          ? (json['buttons'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => Button.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'title': _title, 'buttons': _buttons?.map((Button? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'title': _title,
    'buttons': _buttons,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<DynamicRouteModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<DynamicRouteModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final TITLE = amplify_core.QueryField(fieldName: "title");
  static final BUTTONS = amplify_core.QueryField(
    fieldName: "buttons",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Button'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "DynamicRoute";
    modelSchemaDefinition.pluralName = "DynamicRoutes";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PRIVATE,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: DynamicRoute.TITLE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: DynamicRoute.BUTTONS,
      isRequired: false,
      ofModelName: 'Button',
      associatedKey: Button.DYNAMICROUTE
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

class _DynamicRouteModelType extends amplify_core.ModelType<DynamicRoute> {
  const _DynamicRouteModelType();
  
  @override
  DynamicRoute fromJson(Map<String, dynamic> jsonData) {
    return DynamicRoute.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'DynamicRoute';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [DynamicRoute] in your schema.
 */
class DynamicRouteModelIdentifier implements amplify_core.ModelIdentifier<DynamicRoute> {
  final String id;

  /** Create an instance of DynamicRouteModelIdentifier using [id] the primary key. */
  const DynamicRouteModelIdentifier({
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
  String toString() => 'DynamicRouteModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is DynamicRouteModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
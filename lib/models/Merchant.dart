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


/** This is an auto generated class representing the Merchant type in your schema. */
class Merchant extends amplify_core.Model {
  static const classType = const _MerchantModelType();
  final String id;
  final String? _name;
  final String? _tag;
  final String? _qrCode;
  final List<DynamicWidget>? _widget;
  final List<DynamicWidget>? _extraWidget;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  MerchantModelIdentifier get modelIdentifier {
      return MerchantModelIdentifier(
        id: id
      );
  }
  
  String? get name {
    return _name;
  }
  
  String? get tag {
    return _tag;
  }
  
  String? get qrCode {
    return _qrCode;
  }
  
  List<DynamicWidget>? get widget {
    return _widget;
  }
  
  List<DynamicWidget>? get extraWidget {
    return _extraWidget;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Merchant._internal({required this.id, name, tag, qrCode, widget, extraWidget, createdAt, updatedAt}): _name = name, _tag = tag, _qrCode = qrCode, _widget = widget, _extraWidget = extraWidget, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Merchant({String? id, String? name, String? tag, String? qrCode, List<DynamicWidget>? widget, List<DynamicWidget>? extraWidget}) {
    return Merchant._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      name: name,
      tag: tag,
      qrCode: qrCode,
      widget: widget != null ? List<DynamicWidget>.unmodifiable(widget) : widget,
      extraWidget: extraWidget != null ? List<DynamicWidget>.unmodifiable(extraWidget) : extraWidget);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Merchant &&
      id == other.id &&
      _name == other._name &&
      _tag == other._tag &&
      _qrCode == other._qrCode &&
      DeepCollectionEquality().equals(_widget, other._widget) &&
      DeepCollectionEquality().equals(_extraWidget, other._extraWidget);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Merchant {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("tag=" + "$_tag" + ", ");
    buffer.write("qrCode=" + "$_qrCode" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Merchant copyWith({String? name, String? tag, String? qrCode, List<DynamicWidget>? widget, List<DynamicWidget>? extraWidget}) {
    return Merchant._internal(
      id: id,
      name: name ?? this.name,
      tag: tag ?? this.tag,
      qrCode: qrCode ?? this.qrCode,
      widget: widget ?? this.widget,
      extraWidget: extraWidget ?? this.extraWidget);
  }
  
  Merchant copyWithModelFieldValues({
    ModelFieldValue<String?>? name,
    ModelFieldValue<String?>? tag,
    ModelFieldValue<String?>? qrCode,
    ModelFieldValue<List<DynamicWidget>?>? widget,
    ModelFieldValue<List<DynamicWidget>?>? extraWidget
  }) {
    return Merchant._internal(
      id: id,
      name: name == null ? this.name : name.value,
      tag: tag == null ? this.tag : tag.value,
      qrCode: qrCode == null ? this.qrCode : qrCode.value,
      widget: widget == null ? this.widget : widget.value,
      extraWidget: extraWidget == null ? this.extraWidget : extraWidget.value
    );
  }
  
  Merchant.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _tag = json['tag'],
      _qrCode = json['qrCode'],
      _widget = json['widget']  is Map
        ? (json['widget']['items'] is List
          ? (json['widget']['items'] as List)
              .where((e) => e != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['widget'] is List
          ? (json['widget'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _extraWidget = json['extraWidget']  is Map
        ? (json['extraWidget']['items'] is List
          ? (json['extraWidget']['items'] as List)
              .where((e) => e != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e)))
              .toList()
          : null)
        : (json['extraWidget'] is List
          ? (json['extraWidget'] as List)
              .where((e) => e?['serializedData'] != null)
              .map((e) => DynamicWidget.fromJson(new Map<String, dynamic>.from(e?['serializedData'])))
              .toList()
          : null),
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'tag': _tag, 'qrCode': _qrCode, 'widget': _widget?.map((DynamicWidget? e) => e?.toJson()).toList(), 'extraWidget': _extraWidget?.map((DynamicWidget? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'name': _name,
    'tag': _tag,
    'qrCode': _qrCode,
    'widget': _widget,
    'extraWidget': _extraWidget,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<MerchantModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<MerchantModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final NAME = amplify_core.QueryField(fieldName: "name");
  static final TAG = amplify_core.QueryField(fieldName: "tag");
  static final QRCODE = amplify_core.QueryField(fieldName: "qrCode");
  static final WIDGET = amplify_core.QueryField(
    fieldName: "widget",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'DynamicWidget'));
  static final EXTRAWIDGET = amplify_core.QueryField(
    fieldName: "extraWidget",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'DynamicWidget'));
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Merchant";
    modelSchemaDefinition.pluralName = "Merchants";
    
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
      key: Merchant.NAME,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Merchant.TAG,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Merchant.QRCODE,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Merchant.WIDGET,
      isRequired: false,
      ofModelName: 'DynamicWidget',
      associatedKey: DynamicWidget.MERCHANTWIDGET
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Merchant.EXTRAWIDGET,
      isRequired: false,
      ofModelName: 'DynamicWidget',
      associatedKey: DynamicWidget.MERCHANTEXTRAWIDGET
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

class _MerchantModelType extends amplify_core.ModelType<Merchant> {
  const _MerchantModelType();
  
  @override
  Merchant fromJson(Map<String, dynamic> jsonData) {
    return Merchant.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Merchant';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Merchant] in your schema.
 */
class MerchantModelIdentifier implements amplify_core.ModelIdentifier<Merchant> {
  final String id;

  /** Create an instance of MerchantModelIdentifier using [id] the primary key. */
  const MerchantModelIdentifier({
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
  String toString() => 'MerchantModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is MerchantModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}
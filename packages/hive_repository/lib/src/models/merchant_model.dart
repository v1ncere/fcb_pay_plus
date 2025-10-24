import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'merchant_model.g.dart';

@HiveType(typeId: 2)
class MerchantModel {
  const MerchantModel({required this.id, required this.name, required this.qrCode, required this.tag, required this.owner});
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String qrCode;

  @HiveField(3)
  final String tag;

  @HiveField(4)
  final String owner;

  MerchantModel copyWith({
    String? id,
    String? name,
    String? qrCode,
    String? tag,
    String? owner,
  }) {
    return MerchantModel(
      id: id ?? this.id,
      name: name ?? this.name,
      qrCode: qrCode ?? this.qrCode,
      tag: tag ?? this.tag,
      owner: owner ?? this.owner,
    );
  }

  static const empty = MerchantModel(id: '', name: '', qrCode: '', tag: '', owner: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qrCode': qrCode,
      'tag': tag,
      'owner': owner,
    };
  }

  factory MerchantModel.fromMap(Map<String, dynamic> map) {
    return MerchantModel(
      id: map['id'] as String, 
      name: map['name'] as String, 
      qrCode: map['qrCode'] as String, 
      tag: map['tag'] as String,
      owner: map['owner'] as String
    );
  }

  @override
  String toString() => 'MerchantModel(id: $id, name: $name, qrCode: $qrCode, tag: $tag, owner: $owner)';

  String toJson() => json.encode(toMap());

  factory MerchantModel.fromJson(String source) => MerchantModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
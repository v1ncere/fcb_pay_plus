import 'dart:convert';

class Merchant {
  final String id;
  final String name;
  final String qrCode;
  final String tag;
  final String owner;

  Merchant({
    required this.id,
    required this.name,
    required this.qrCode,
    required this.tag,
    required this.owner,
  });

  Merchant copyWith({
    String? id,
    String? name,
    String? qrCode,
    String? tag,
    String? owner,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      qrCode: qrCode ?? this.qrCode,
      tag: tag ?? this.tag,
      owner: owner ?? this.owner,
    );
  }

  factory Merchant.fromMap(Map<String, dynamic> map) {
    return Merchant(
      id: map['id'] as String,
      name: map['name'] as String,
      qrCode: map['qrCode'] as String,
      tag: map['tag'] as String,
      owner: map['owner'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'qrCode': qrCode,
      'tag': tag,
      'owner': owner,
    };
  }

  factory Merchant.fromJson(String source) {
    return Merchant.fromMap(json.decode(source) as Map<String, dynamic>);
  }
   
  String toJson() => json.encode(toMap());
}
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PinAuth {
  final String id;
  final String pin;

  PinAuth({
    required this.id,
    required this.pin,
  });

  PinAuth copyWith({
    String? id,
    String? pin,
  }) {
    return PinAuth(
      id: id ?? this.id,
      pin: pin ?? this.pin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pin': pin,
    };
  }

  factory PinAuth.fromMap(Map<String, dynamic> map) {
    return PinAuth(
      id: map['id'] as String,
      pin: map['pin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PinAuth.fromJson(String source) => PinAuth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PinAuth(id: $id, pin: $pin)';

  @override
  bool operator ==(covariant PinAuth other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.pin == pin;
  }

  @override
  int get hashCode => id.hashCode ^ pin.hashCode;
}

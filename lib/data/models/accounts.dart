import 'dart:convert';

class Accounts {
  final String id;
  final String accountNumber;

  Accounts({
    required this.id,
    required this.accountNumber
  });

  Accounts copyWith({
    String? id,
    String? accountNumber
  }) {
    return Accounts(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber
    );
  }

  factory Accounts.fromMap(Map<String, dynamic> map) {
    return Accounts(
      id: map['id'] as String,
      accountNumber: map['accountNumber'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'accountNumber': accountNumber,
    };
  }

  factory Accounts.fromJson(String source) {
    return  Accounts.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());

  static final empty = Accounts(id: '', accountNumber: '');
}
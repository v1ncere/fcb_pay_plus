import 'dart:convert';

class QrData {
  final String id;
  final String title;
  final String data;
  final String widget;

  QrData({
    required this.id,
    required this.title,
    required this.data,
    required this.widget,
  });

  QrData copyWith({
    String? id,
    String? title,
    String? data,
    String? widget,
  }) {
    return QrData(
      id: id ?? this.id,
      title: title ?? this.title,
      data: data ?? this.data,
      widget: widget ?? this.widget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'data': data,
      'widget': widget,
    };
  }

  factory QrData.fromMap(Map<String, dynamic> map) {
    return QrData(
      id: map['id'] as String,
      title: map['title'] as String,
      data: map['data'] as String,
      widget: map['widget'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QrData.fromJson(String source) => QrData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QrData(id: $id, title: $title, data: $data, widget: $widget)';
  }

  // HELPERS
  static final empty = QrData(id: '', title: '', data: '', widget: '');
}
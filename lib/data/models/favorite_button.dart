// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteButton {
  final String id;
  final String backgroundColor;
  final String icon;
  final String iconColor;
  final int position;
  final String title;
  final String titleColor;
  final String type;

  FavoriteButton({
    required this.id,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.position,
    required this.title,
    required this.titleColor,
    required this.type,
  });

  FavoriteButton copyWith({
    String? id,
    String? backgroundColor,
    String? icon,
    String? iconColor,
    int? position,
    String? title,
    String? titleColor,
    String? type,
  }) {
    return FavoriteButton(
      id: id ?? this.id,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      position: position ?? this.position,
      title: title ?? this.title,
      titleColor: titleColor ?? this.titleColor,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'backgroundColor': backgroundColor,
      'icon': icon,
      'iconColor': iconColor,
      'position': position,
      'title': title,
      'titleColor': titleColor,
      'type': type,
    };
  }

  factory FavoriteButton.fromMap(Map<String, dynamic> map) {
    return FavoriteButton(
      id: map['id'] as String,
      backgroundColor: map['backgroundColor'] as String,
      icon: map['icon'] as String,
      iconColor: map['iconColor'] as String,
      position: map['position'] as int,
      title: map['title'] as String,
      titleColor: map['titleColor'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteButton.fromJson(String source) => FavoriteButton.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FavoriteButton(id: $id, backgroundColor: $backgroundColor, icon: $icon, iconColor: $iconColor, position: $position, title: $title, titleColor: $titleColor, type: $type)';
  }

  @override
  bool operator ==(covariant FavoriteButton other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.backgroundColor == backgroundColor &&
      other.icon == icon &&
      other.iconColor == iconColor &&
      other.position == position &&
      other.title == title &&
      other.titleColor == titleColor &&
      other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      backgroundColor.hashCode ^
      icon.hashCode ^
      iconColor.hashCode ^
      position.hashCode ^
      title.hashCode ^
      titleColor.hashCode ^
      type.hashCode;
  }
}

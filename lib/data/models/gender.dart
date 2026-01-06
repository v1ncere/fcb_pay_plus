import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Gender extends Equatable {
  final String name;
  final IconData icon;
  final bool isSelected;

  const Gender({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  /// Makes it easy to create a modified copy
  Gender copyWith({
    String? name,
    IconData? icon,
    bool? isSelected,
  }) {
    return Gender(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [name, icon, isSelected];
}

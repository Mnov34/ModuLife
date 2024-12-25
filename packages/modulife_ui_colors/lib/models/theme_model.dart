import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ThemeModel extends Equatable {
  final String id;
  final String name;
  final ThemeData themeData;

  ThemeModel({
    String? id,
    required this.name,
    required this.themeData,
  }) : id = id ?? const Uuid().v4();

  /// Create a copy with different values
  ThemeModel copyWith({
    String? id,
    String? name,
    ThemeData? themeData,
  }) {
    return ThemeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      themeData: themeData ?? this.themeData,
    );
  }

  /// Convert the model to a map (for storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'themeData': themeData.toString(), // Simplified for demo purposes
    };
  }

  /// Create a model from a map (from storage)
  factory ThemeModel.fromMap(Map<String, dynamic> map) {
    return ThemeModel(
      id: map['id'],
      name: map['name'],
      themeData: ThemeData.light(), // Custom deserialization needed
    );
  }

  @override
  List<Object> get props => [id, name, themeData];
}

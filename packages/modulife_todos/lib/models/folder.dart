import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:modulife_todos/models/models.dart';

class Folder extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<Todo> todos;
  final DateTime creationDate;

  Folder({
    String? id,
    required this.title,
    String? description,
    List<Todo>? todos,
    DateTime? creationDate,
  }) : id = id ?? const Uuid().v4(),
        description = description ?? '',
        todos = todos ?? [],
        creationDate = creationDate ?? DateTime.now();

  Folder copyWith({
    String? id,
    String? title,
    String? description,
    List<Todo>? todos,
    DateTime? creationDate,
  }) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      todos: todos ?? this.todos,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'todos': todos.map((Todo todo) => todo.toMap()).toList(),
      'creationDate': creationDate.toIso8601String(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'] ?? const Uuid().v4(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      todos: List<Todo>.from(
          map['todos']?.map((dynamic x) => Todo.fromMap(x)) ?? []),
      creationDate: DateTime.parse(
          map['creationDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object> get props => [id, title, description, todos, creationDate];
}

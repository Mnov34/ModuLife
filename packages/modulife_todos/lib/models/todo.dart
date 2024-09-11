import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final bool isDone;
  final bool isDeleted;

  Todo({
    String? id,
    required this.title,
    bool? isDone,
    bool? isDeleted,
  })  : id = id ?? const Uuid().v4(),
        isDone = isDone ?? false,
        isDeleted = isDeleted ?? false;

  Todo copyWith({

    String? id,
    String? title,
    bool? isDone,
    bool? isDeleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'isDeleted': isDeleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? const Uuid().v4(),
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  @override
  List<Object?> get props => [id, title, isDone, isDeleted];
}

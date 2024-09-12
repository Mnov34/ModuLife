import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:modulife_notes/models/note.dart';

class Folder extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<Note> notes;
  final DateTime creationDate;
  final DateTime updateDate;

  Folder({
    String? id,
    required this.title,
    String? description,
    List<Note>? notes,
    DateTime? creationDate,
    DateTime? updateDate,
  })  : id = id ?? const Uuid().v4(),
        description = description ?? '',
        notes = notes ?? [],
        creationDate = creationDate ?? DateTime.now(),
        updateDate = updateDate ?? DateTime.now();

  Folder copyWith({
    String? id,
    String? title,
    String? description,
    List<Note>? notes,
    DateTime? creationDate,
    DateTime? updateDate,
  }) {
    return Folder(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'notes': notes.map((Note note) => note.toMap()).toList(),
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'] ?? const Uuid().v4(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      notes: List<Note>.from(
          map['notes']?.map((dynamic x) => Note.fromMap(x)) ?? []),
      creationDate: DateTime.parse(
          map['creationDate'] ?? DateTime.now().toIso8601String()),
      updateDate: DateTime.parse(
          map['updateDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object> get props => [id, title, description, notes, creationDate];
}

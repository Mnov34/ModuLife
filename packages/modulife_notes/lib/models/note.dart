import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Note extends Equatable {
  final String id;
  final String? folderId;
  final String title;
  final String content;
  final DateTime creationDate;
  final DateTime updateDate;

  Note({
    String? id,
    this.folderId,
    required this.title,
    String? content,
    DateTime? creationDate,
    DateTime? updateDate,
  })  : id = id ?? const Uuid().v4(),
        content = content ?? '',
        creationDate = creationDate ?? DateTime.now(),
        updateDate = updateDate ?? DateTime.now();

  Note copyWith({
    String? id,
    String? folderId,
    String? title,
    String? content,
    DateTime? creationDate,
    DateTime? updateDate,
  }) {
    return Note(
      id: id ?? this.id,
      folderId: folderId ?? this.folderId,
      title: title ?? this.title,
      content: content ?? this.content,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'folderId': folderId,
      'title': title,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] ?? const Uuid().v4(),
      folderId: map['folderId'] ?? null,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      creationDate: DateTime.parse(
          map['creationDate'] ?? DateTime.now().toIso8601String()),
      updateDate:
          DateTime.parse(map['updateDate'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  List<Object?> get props =>
      [id, folderId, title, content, creationDate, updateDate];
}

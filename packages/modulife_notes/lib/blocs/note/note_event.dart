part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class AddNote extends NoteEvent {
  final Note note;

  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}

final class UpdateNote extends NoteEvent {
  final Note note;

  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];
}

final class DeleteNote extends NoteEvent {
  final List<Note> notes;

  const DeleteNote({required List<Note> notes}) : notes = notes;

  @override
  List<Object> get props => [notes];
}

final class LoadNotes extends NoteEvent {
  @override
  List<Object> get props => [];
}

part of 'note_bloc.dart';

enum NoteStatus { initial, loading, success, failure }

final class NoteState extends Equatable {
  final List<Note> allNotes;
  final NoteStatus status;

  const NoteState({
    this.allNotes = const <Note>[],
    this.status = NoteStatus.initial,
  });

  NoteState copyWith({
    List<Note>? allNotes,
    NoteStatus? status,
  }) {
    return NoteState(
      allNotes: allNotes ?? List.from(this.allNotes),
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [allNotes, status];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_notes/models/note.dart';
import 'package:modulife_notes/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(const NoteState()) {
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<LoadNotes>(_onLoadNote);
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes = List<Note>.from(state.allNotes)
      ..add(event.note);

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await noteRepository.saveNotes(updatedNotes);
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes = state.allNotes.map((Note note) {
      return note.id == event.note.id ? event.note : note;
    }).toList();

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await noteRepository.saveNotes(updatedNotes);
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes =
        state.allNotes.where((Note note) => note.id != event.note.id).toList();

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await noteRepository.saveNotes(updatedNotes);
  }

  Future<void> _onLoadNote(LoadNotes event, Emitter<NoteState> emit) async {
    emit(state.copyWith(status: NoteStatus.loading));

    try {
      final List<Note> loadedNotes = await noteRepository.loadNotes();
      emit(state.copyWith(allNotes: loadedNotes, status: NoteStatus.success));
    } catch (_) {
      emit(state.copyWith(status: NoteStatus.failure));
    }
  }
}

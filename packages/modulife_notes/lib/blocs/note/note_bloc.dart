import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_notes/models/note.dart';
import 'package:modulife_notes/repositories/note_repository.dart';
import 'package:modulife_utils/modulife_utils.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;

  NoteBloc({required this.noteRepository}) : super(const NoteState()) {
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<LoadNotes>(_onLoadNote);

    LogService.i('NoteBloc initialized');
  }

  Future<void> _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    LogService.d('AddNote event triggered: ${event.note}');
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes = List<Note>.from(state.allNotes)
      ..add(event.note);

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await _saveNotes(updatedNotes);
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    LogService.d('UpdateNote event triggered: ${event.note}');
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes = state.allNotes.map((Note note) {
      return note.id == event.note.id ? event.note : note;
    }).toList();

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await _saveNotes(updatedNotes);
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    LogService.d('DeleteNote event triggered: ${event.notes}');
    emit(state.copyWith(status: NoteStatus.loading));

    final List<Note> updatedNotes = state.allNotes
        .where((Note note) => !event.notes.any((Note n) => n.id == note.id))
        .toList();

    emit(state.copyWith(
      allNotes: updatedNotes,
      status: NoteStatus.success,
    ));

    await _saveNotes(updatedNotes);
  }

  Future<void> _onLoadNote(LoadNotes event, Emitter<NoteState> emit) async {
    LogService.d('LoadNote event triggered.');
    emit(state.copyWith(status: NoteStatus.loading));

    try {
      final List<Note> loadedNotes = await noteRepository.loadNotes();
      emit(state.copyWith(allNotes: loadedNotes, status: NoteStatus.success));
      LogService.i('Notes loaded successfully. Total todos: ${loadedNotes}');
    } catch (e, stackTrace) {
      emit(state.copyWith(status: NoteStatus.failure));
      LogService.e('Failed to load Notes', e, stackTrace);
    }
  }

  /// Helper method to save notes and log the result
  Future<void> _saveNotes(List<Note> notes) async {
    try {
      await noteRepository.saveNotes(notes);
      LogService.i('Notes saved successfully. Total notes: ${notes.length}');
    } catch (e, stackTrace) {
      LogService.e('Failed to save notes', e, stackTrace);
    }
  }
}

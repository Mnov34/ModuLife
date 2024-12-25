import 'dart:convert';
import 'package:modulife_utils/modulife_utils.dart';

import 'package:modulife_notes/models/note.dart';

class NoteRepository {
  static const String notesKey = 'notes_key';

  final StorageUtils _prefs = StorageUtils();

  /// Save the list of notes to storage
  Future<void> saveNotes(List<Note> notes) async {
    final String notesJson =
    jsonEncode(notes.map((Note note) => note.toMap()).toList());

    await _prefs.saveString(notesKey, notesJson);
  }

  /// Load the list of notes from storage
  Future<List<Note>> loadNotes() async {
    final String? notesJson = _prefs.getString(notesKey);

    if (notesJson != null) {
      final List<dynamic> jsonList = jsonDecode(notesJson);
      return jsonList.map((dynamic json) => Note.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  /// Remove all notes from storage
  Future<void> clearNotes() async {
    await _prefs.remove(notesKey);
  }
}

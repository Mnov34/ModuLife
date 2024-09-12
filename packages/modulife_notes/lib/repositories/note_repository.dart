import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:modulife_notes/models/note.dart';

class NoteRepository {
  static const String notesKey = 'notes_key';

  Future<void> saveNotes(List<Note> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String notesJson =
    jsonEncode(notes.map((Note note) => note.toMap()).toList());

    await prefs.setString(notesKey, notesJson);
  }

  Future<List<Note>> loadNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString(notesKey);

    if (notesJson != null) {
      final List<dynamic> jsonList = jsonDecode(notesJson);
      return jsonList.map((dynamic json) => Note.fromMap(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> clearNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(notesKey);
  }
}
